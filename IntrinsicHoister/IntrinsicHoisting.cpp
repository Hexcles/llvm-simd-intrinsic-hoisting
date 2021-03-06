#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

// Not using "llvm/Support/Debug.h" because of backward-compatiblity issues
#ifndef NDEBUG
#define DEBUG(X) X
#else
#define DEBUG(X) {}
#endif

using namespace llvm;

namespace {
  struct IntrinsicHoistingPass : public BasicBlockPass {
    static char ID;
    IntrinsicHoistingPass() : BasicBlockPass(ID) {}

    virtual bool doInitialization(Function &F) override {
      DEBUG(errs() << "Entering function: " << F.getName() << "\n");
      return false;
    }

    virtual bool runOnBasicBlock(BasicBlock &BB) override {
      bool modified = false;
      LLVMContext & context = BB.getContext();

      DEBUG(errs() << "ORIGINAL BB:\n\n");
      DEBUG(BB.dump());
      //BB.getParent()->viewCFG();  // Display CFG of the current function (requires Graphviz)

      for (BasicBlock::iterator InstItr = BB.begin(); InstItr != BB.end(); InstItr++) {
        CallInst * call = dyn_cast<CallInst>(InstItr);
        if (call == NULL) continue;
        Function * func = call->getCalledFunction();
        if (func->getName().startswith("llvm.x86"))
          DEBUG(errs() << "Found intrinsic: " << func->getName() << "\n");
        else
          continue;

        if (func->getName() == "llvm.x86.sse2.psll.q") {
          Value *v = call->getOperand(0);
          Value *count_raw = call->getOperand(1);
          // Insert before call.
          IRBuilder<> builder(call);
          Value* count = builder.CreateShuffleVector(
              count_raw,
              UndefValue::get(count_raw->getType()),
              ConstantVector::get({
                ConstantInt::get(Type::getInt32Ty(context), 0),
                ConstantInt::get(Type::getInt32Ty(context), 0),
                })
              );
          // res = shl v, <count[0], count[0]>
          Value* newshl = builder.CreateShl(v, count);
          ReplaceInstWithValue(BB.getInstList(), InstItr, newshl);
          modified = true;
        }

        if (func->getName() == "llvm.x86.fma.vfmadd.pd") {
          Value *v0 = call->getOperand(0);
          Value *v1 = call->getOperand(1);
          Value *v2 = call->getOperand(2);
          std::vector<Value *> args;
          args.push_back(v0);
          args.push_back(v1);
          args.push_back(v2);

          Function *fun = Intrinsic::getDeclaration(BB.getParent()->getParent(), Intrinsic::fma, VectorType::get(Type::getDoubleTy(context), 2));
          // Insert before call.
          IRBuilder<> Builder(call);
          Value *newfunc = Builder.CreateCall(fun, args);
          ReplaceInstWithValue(BB.getInstList(), InstItr, newfunc);
          modified = true;
        }

        if (func->getName() == "llvm.x86.sse2.sqrt.pd") {
          Value *args = call->getOperand(0);

          Function *fun = Intrinsic::getDeclaration(BB.getParent()->getParent(), Intrinsic::sqrt, VectorType::get(Type::getDoubleTy(context), 2));
          // Insert before call.
          IRBuilder<> Builder(call);
          Value *newfunc = Builder.CreateCall(fun, args);
          ReplaceInstWithValue(BB.getInstList(), InstItr, newfunc);
          modified = true;
        }

        if (func->getName() == "llvm.x86.sse2.psad.bw") {
          Value *l = call->getOperand(0);
          Value *r = call->getOperand(1);

          // Insert before call.
          IRBuilder<> builder(call);

          //calculate the absolute difference of two <16 x i8> vectors:
          //%sub = sub nsw <16 x i8> %a, %b
          //%comp = icmp slt <16 x i8> %sub, zeroinitializer
          //%neg = sub nsw <16 x i8> zeroinitializer, %sub
          //%val = select <16 x i1> %comp, <16 x i8> %neg, <16 x i8> %sub

          Value *sub = builder.CreateSub(l, r);
          Value *temp = Constant::getIntegerValue(Type::getInt8Ty(context), llvm::APInt(8, 0, false));
          Value *zero = builder.CreateVectorSplat(16, temp);

          Value *neg = builder.CreateSub(zero, sub);
          Value *comp = builder.CreateICmpSLT(sub, zero);
          Value *val = builder.CreateSelect(comp, neg, sub);
          DEBUG(errs() << "\n*****v0:" << *val << "*******\n");

          //split a <16 x i8> vector to two <8 x i8> vectors:
          Constant * index[8];
          for (int i = 0; i < 8;i++){
            index[i] = ConstantInt::get(Type::getInt32Ty(context), i);
          }
          ArrayRef <Constant *> indexref(index, 8);
          Constant * indexVector = ConstantVector::get(indexref);

          Value* vec0 = builder.CreateShuffleVector(val, UndefValue::get(VectorType::get(Type::getInt8Ty(context), 16)), indexVector);
          DEBUG(errs() << "\n*****v0:" << *vec0 << "*******\n");

          Constant * index1[8];
          for (int i = 0; i < 8;i++){
            index1[i] = ConstantInt::get(Type::getInt32Ty(context), 8 + i);
          }
          ArrayRef <Constant *> indexref1(index1, 8);
          Constant * indexVector1 = ConstantVector::get(indexref1);

          Value* vec1 = builder.CreateShuffleVector(val, UndefValue::get(VectorType::get(Type::getInt8Ty(context), 16)), indexVector1);
          DEBUG(errs() << "\n*****v1:" << *vec1 << "*******\n");

          //mask0 = <4 x i32> <i32 0, i32 1, i32 2, i32 3>
          Constant * index_0[4];
          for (int i = 0; i < 4;i++){
            index_0[i] = ConstantInt::get(Type::getInt32Ty(context), i);
          }
          ArrayRef <Constant *> indexref_0(index_0, 4);
          Constant * indexVector_0 = ConstantVector::get(indexref_0);
          DEBUG(errs() << "\n*****v1:" << *indexVector_0 << "*******\n");

          //mask1 = <4 x i32> <i32 4, i32 5, i32 6, i32 7>
          Constant * index_1[4];
          for (int i = 0; i < 4;i++){
            index_1[i] = ConstantInt::get(Type::getInt32Ty(context), i + 4);
          }
          ArrayRef <Constant *> indexref_1(index_1, 4);
          Constant * indexVector_1 = ConstantVector::get(indexref_1);
          DEBUG(errs() << "\n*****v1:" << *indexVector_1 << "*******\n");

          //mask2 = <2 x i32> <i32 0, i32 1>
          Constant * index_2[2];
          for (int i = 0; i < 2;i++){
            index_2[i] = ConstantInt::get(Type::getInt32Ty(context), i);
          }
          ArrayRef <Constant *> indexref_2(index_2, 2);
          Constant * indexVector_2 = ConstantVector::get(indexref_2);
          DEBUG(errs() << "\n*****v1:" << *indexVector_2 << "*******\n");

          //mask3 = <2 x i32> <i32 2, i32 3>
          Constant * index_3[2];
          for (int i = 0; i < 2;i++){
            index_3[i] = ConstantInt::get(Type::getInt32Ty(context), i + 2);
          }
          ArrayRef <Constant *> indexref_3(index_3, 2);
          Constant * indexVector_3 = ConstantVector::get(indexref_3);
          DEBUG(errs() << "\n*****v1:" << *indexVector_3 << "*******\n");

          //calculate the horizontally sums of the two <8 x i8> vectors respectively.
          //define i8 @sum(<8 x i8> %a) {
          //  %v1 = shufflevector <8 x i8> %a, <8 x i8> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
          //  %v2 = shufflevector <8 x i8> %a, <8 x i8> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
          //  %sum1 = add <4 x i8> %v1, %v2
          //  %v3 = shufflevector <4 x i8> %sum1, <4 x i8> undef, <2 x i32> <i32 0, i32 1>
          //  %v4 = shufflevector <4 x i8> %sum1, <4 x i8> undef, <2 x i32> <i32 2, i32 3>
          //  %sum2 = add <2 x i8> %v3, %v4
          //  %v5 = extractelement <2 x i8> %sum2, i32 0
          //  %v6 = extractelement <2 x i8> %sum2, i32 1
          //  %sum3 = add i8 %v5, %v6
          //  ret i8 %sum3
          //}

          Value *v1 = builder.CreateShuffleVector(vec0, UndefValue::get(VectorType::get(Type::getInt8Ty(context), 8)), indexVector_0);
          Value *v2 = builder.CreateShuffleVector(vec0, UndefValue::get(VectorType::get(Type::getInt8Ty(context), 8)), indexVector_1);
          Value *sum1 = builder.CreateAdd(v1, v2);
          Value *v3 = builder.CreateShuffleVector(sum1, UndefValue::get(VectorType::get(Type::getInt8Ty(context), 4)), indexVector_2);
          Value *v4 = builder.CreateShuffleVector(sum1, UndefValue::get(VectorType::get(Type::getInt8Ty(context), 4)), indexVector_3);
          Value *sum2 = builder.CreateAdd(v3, v4);
          Value *v5 = builder.CreateExtractElement(sum2, ConstantInt::get(Type::getInt8Ty(context), 0));
          Value *v6 = builder.CreateExtractElement(sum2, ConstantInt::get(Type::getInt8Ty(context), 1));
          Value *sum3 = builder.CreateAdd(v5, v6);

          Value *elem0 = builder.CreateZExt(sum3, Type::getInt64Ty(context));
          DEBUG(errs() << "\n*****v1:" << *v1 << "*******\n" << "\n*****v2:" << *v2 << "*******\n"<< "\n*****sum1:" << *sum1 << "*******\n");
          DEBUG(errs() << "\n*****v3:" << *v3 << "*******\n" << "\n*****v4:" << *v4 << "*******\n"<< "\n*****sum2:" << *sum2 << "*******\n");
          DEBUG(errs() << "\n*****v5:" << *v5 << "*******\n" << "\n*****v6:" << *v6 << "*******\n"<< "\n*****sum3:" << *sum3 << "*******\n");

          Value *v11 = builder.CreateShuffleVector(vec1, UndefValue::get(VectorType::get(Type::getInt8Ty(context), 8)), indexVector_0);
          Value *v22 = builder.CreateShuffleVector(vec1, UndefValue::get(VectorType::get(Type::getInt8Ty(context), 8)), indexVector_1);
          Value *sum11 = builder.CreateAdd(v11, v22);
          Value *v33 = builder.CreateShuffleVector(sum11, UndefValue::get(VectorType::get(Type::getInt8Ty(context), 4)), indexVector_2);
          Value *v44 = builder.CreateShuffleVector(sum11, UndefValue::get(VectorType::get(Type::getInt8Ty(context), 4)), indexVector_3);
          Value *sum22 = builder.CreateAdd(v33, v44);
          Value *v55 = builder.CreateExtractElement(sum22, ConstantInt::get(Type::getInt8Ty(context), 0));
          Value *v66 = builder.CreateExtractElement(sum22, ConstantInt::get(Type::getInt8Ty(context), 1));
          Value *sum33 = builder.CreateAdd(v55, v66);

          Value *elem1 = builder.CreateZExt(sum33, Type::getInt64Ty(context));

          VectorType * vecTy = VectorType::get(builder.getInt64Ty(), 2);
          Value *vec = UndefValue::get(vecTy);
          vec = builder.CreateInsertElement(vec, elem0, builder.getInt32(0));
          vec = builder.CreateInsertElement(vec, elem1, builder.getInt32(1));

          ReplaceInstWithValue(BB.getInstList(), InstItr, vec);
          modified = true;
        }

        if (func->getName() == "llvm.x86.sse2.pavg.w") {
          Value *v0 = call->getOperand(0);
          Value *v1 = call->getOperand(1);

          // Insert before call.
          IRBuilder<> builder(call);
          // %sum = add <8 x i16> v0, <8 x i16> v1;
          //%one = <8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>;
          //%sum1 = add %sum, %one;
          //%avg = %sum1 >> 1;
          Value *sum = builder.CreateAdd(v0, v1);
          Value *temp = Constant::getIntegerValue(Type::getInt16Ty(context), llvm::APInt(16, 1, false));
          Value *one = builder.CreateVectorSplat(8, temp);
          Value *sum1 = builder.CreateAdd(sum, one);
          Value *avg = builder.CreateLShr(sum1, one);

          ReplaceInstWithValue(BB.getInstList(), InstItr, avg);
          modified = true;
        }

        if (func->getName() == "llvm.x86.sse2.pmins.w") {
          Value *v0 = call->getOperand(0);
          Value *v1 = call->getOperand(1);

          // Insert before call.
          IRBuilder<> builder(call);
          //%comp = icmp slt <8 x i16> v0, <8 x i16> v1;
          //%sel = select <8 x i1> comp, <8 x i16> v0, <8 x i16> v1;
          Value *comp = builder.CreateICmpSLT(v0, v1);
          Value *sel = builder.CreateSelect(comp, v0, v1);

          ReplaceInstWithValue(BB.getInstList(), InstItr, sel);
          modified = true;
        }

        if (func->getName() == "llvm.x86.sse2.cmp.pd") {
          Value *v0 = call->getOperand(0);
          Value *v1 = call->getOperand(1);
          Value *v2 = call->getOperand(2);
          DEBUG(errs() << "\n*****v0:" << *v0 << "*******\n");
          DEBUG(errs() << "\n*****v1:" << *v1 << "*******\n");
          // Insert before call.
          IRBuilder<> builder(call);

          // %comp = fcmp ult <2 x double> %v0, %v1 || %comp = fcmp ueq <2 x double> %v0, %v1 
          // %temp = sext <2 x i1> %comp to <2 x i64>
          // %result = bitcast <2 x i64> %temp to <2 x double>
          ConstantInt * CI = dyn_cast<ConstantInt>(v2);
          Value * comp;
          if (CI->isZero()) {
              // op2 == 0: cmpeq
              comp = builder.CreateFCmpOEQ(v0, v1);
          } else {
              // op2 == 1: cmplt
              // There is no cmpgt, which is implemented by swapping operands.
              comp = builder.CreateFCmpOLT(v0, v1);
          }
          Value *temp = builder.CreateSExt(comp, VectorType::get(Type::getInt64Ty(context), 2));
          Value *result = builder.CreateBitCast(temp, VectorType::get(Type::getDoubleTy(context), 2));          

          ReplaceInstWithValue(BB.getInstList(), InstItr, result);
          modified = true;
        }

        if (func->getName() == "llvm.x86.sse2.cmp.sd") {
          // TODO only deals with cmplt_pd for now
          // check the third parameter of the intrinsic call to know its variation (lt/gt/eq)
          Value *v0 = call->getOperand(0);
          Value *v1 = call->getOperand(1);
          Value *v2 = call->getOperand(2);
          DEBUG(errs() << "\n*****v0:" << *v0 << "*******\n");
          DEBUG(errs() << "\n*****v1:" << *v1 << "*******\n");
          // Insert before call.
          IRBuilder<> builder(call);

          // %a0 = extractelement <2 x double> %x, i32 0
          // %a1 = extractelement <2 x double> %y, i32 0
          // %comp = fcmp ueq double %a0, %a1

          Value *a0 = builder.CreateExtractElement(v0, builder.getInt32(0));
          Value *a1 = builder.CreateExtractElement(v1, builder.getInt32(0));
          ConstantInt * CI = dyn_cast<ConstantInt>(v2);
          Value * comp;
          // Same as above (cmp.pd).
          if (CI->isZero()) {
            comp = builder.CreateFCmpOEQ(a0, a1);
          } else {
            comp = builder.CreateFCmpOLT(a0, a1);
          }
          
          // %temp = sext i1 %comp to i64
          // %b0 = bitcast i64 %temp to double
          // %b1 = extractelement <2 x double> %x, i32 1          
          Value *temp = builder.CreateSExt(comp, Type::getInt64Ty(context));
          Value *b0 = builder.CreateBitCast(temp, Type::getDoubleTy(context));
          Value *b1 = builder.CreateExtractElement(v0, builder.getInt32(1));

          // %res = insertelement <2 x double> undef, double %b0, i32 0
          // %result = insertelement <2 x double> %11, double %b1, i32 1
          // ret <2 x double> %result
          VectorType * vecTy = VectorType::get(builder.getDoubleTy(), 2);
          Value *vec = UndefValue::get(vecTy);
          vec = builder.CreateInsertElement(vec, b0, builder.getInt32(0));
          vec = builder.CreateInsertElement(vec, b1, builder.getInt32(1));          

          ReplaceInstWithValue(BB.getInstList(), InstItr, vec);
          modified = true;
        }       

        if (func->getName() == "llvm.x86.sse2.pmulu.dq") {
          Value *v0 = call->getOperand(0);
          Value *v1 = call->getOperand(1);
          // Insert before call.

          IRBuilder<> builder(call);
          //%m0 = bitcast %v0 to <2 x i64>
          //%m1 = bitcast %v1 to <2 x i64>
          //%magic = <2 x i64> <i64 4294967295, i64 4294967295>
          //%and0 = and %m0, %magic
          //%and1 = and %m1, %magic
          //%result = mul %and0, %and1
          Value *m0 = builder.CreateBitCast(v0, VectorType::get(Type::getInt64Ty(context), 2));
          Value *m1 = builder.CreateBitCast(v1, VectorType::get(Type::getInt64Ty(context), 2));
          Value *temp = Constant::getIntegerValue(Type::getInt64Ty(context), llvm::APInt(64, 4294967295, false));
          Value *magic = builder.CreateVectorSplat(2, temp);
          Value *and0 = builder.CreateAnd(m0, magic);
          Value *and1 = builder.CreateAnd(m1, magic); 
          Value *result = builder.CreateMul(and0, and1);

          ReplaceInstWithValue(BB.getInstList(), InstItr, result);
          modified = true;
        } 

        if (func->getName() == "llvm.x86.sse2.pmadd.wd") {
          Value *v0 = call->getOperand(0);
          Value *v1 = call->getOperand(1);
          // Insert before call.

          IRBuilder<> builder(call);


          // %m0 = bitcast <8 x i16> %x to <4 x i32>
          // %m1 = bitcast <8 x i16> %y to <4 x i32>
          // %andm0 = and <4 x i32> %m0, <i32 65535, i32 65535, i32 65535, i32 65535>
          // %andm1 = and <4 x i32> %m1, <i32 65535, i32 65535, i32 65535, i32 65535>
          // %result0 = mul <4 x i32> %andm0, %andm1

          Value *m0 = builder.CreateBitCast(v0, VectorType::get(Type::getInt32Ty(context), 4));
          Value *m1 = builder.CreateBitCast(v1, VectorType::get(Type::getInt32Ty(context), 4));
          Value *temp = Constant::getIntegerValue(Type::getInt32Ty(context), llvm::APInt(32, 65535, false));
          Value *magic = builder.CreateVectorSplat(4, temp);
          Value *andm0 = builder.CreateAnd(m0, magic);
          Value *andm1 = builder.CreateAnd(m1, magic); 
          Value *result0 = builder.CreateMul(andm0, andm1);

          // %n0 = lshr <4 x i32> %m0, <i32 16, i32 16, i32 16, i32 16>
          // %n1 = lshr <4 x i32> %m1, <i32 16, i32 16, i32 16, i32 16>
          // %andn0 = and <4 x i32> %n0, <i32 65535, i32 65535, i32 65535, i32 65535>
          // %andn1 = and <4 x i32> %n1, <i32 65535, i32 65535, i32 65535, i32 65535>
          // %result1 = mul <4 x i32> %andn0, %andn1
          // %result = add <4 x i32> %result0, %result1          

          Value *sixteen = Constant::getIntegerValue(Type::getInt8Ty(context), llvm::APInt(32, 16, false));
          Value *mask = builder.CreateVectorSplat(4, sixteen);
          Value *n0 = builder.CreateLShr(m0, mask);
          Value *n1 = builder.CreateLShr(m1, mask);

          Value *andn0 = builder.CreateAnd(n0, magic);
          Value *andn1 = builder.CreateAnd(n1, magic); 
          Value *result1 = builder.CreateMul(andn0, andn1);

          Value *result = builder.CreateAdd(result0, result1);

          ReplaceInstWithValue(BB.getInstList(), InstItr, result);
          modified = true;
        }                           

        if (func->getName() == "llvm.x86.sse2.packuswb.128") {
          Value *v0 = call->getOperand(0);
          Value *v1 = call->getOperand(1);
          // Insert before call.
          IRBuilder<> builder(call);
          //%m0 = bitcast %v0 to <16 x i8>
          //%m1 = bitcast %v1 to <16 x i8>
          //%result = shufflevector <16 x i8> %m0, <16 x i8> %m1, <16 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14, i32 16, i32 18, i32 20, i32 22, i32 24, i32 26, i32 28, i32 30>
          Value *m0 = builder.CreateBitCast(v0, VectorType::get(Type::getInt8Ty(context), 16));
          Value *m1 = builder.CreateBitCast(v1, VectorType::get(Type::getInt8Ty(context), 16));
          Constant * index[16];
          for (int i = 0; i < 16;i++){
            index[i] = ConstantInt::get(Type::getInt32Ty(context), 2 * i);
          }
          ArrayRef <Constant *> indexref(index,16);
          Constant * indexVector = ConstantVector::get(indexref);

          Value* result = builder.CreateShuffleVector(m0, m1, indexVector);

          // Another way to hoist "llvm.x86.sse2.packuswb.128" instruction.
          /*Value *v0 = call->getOperand(0);
            Value *v1 = call->getOperand(1);
          // Insert before call.
          IRBuilder<> builder(call);
          Value *high8 = builder.CreateTrunc(v1, VectorType::get(Type::getInt8Ty(context), 8));
          Value *low8 = builder.CreateTrunc(v0, VectorType::get(Type::getInt8Ty(context), 8));

          Constant * index[16];
          for (int i = 0; i < 16;i++){
          index[i] = ConstantInt::get(Type::getInt32Ty(context), i);
          }
          ArrayRef <Constant *> indexref(index,16);
          Constant * indexVector = ConstantVector::get(indexref);

          Value* result = builder.CreateShuffleVector(low8, high8, indexVector);*/
          ReplaceInstWithValue(BB.getInstList(), InstItr, result);
          modified = true;
        }        

        if (func->getName() == "llvm.x86.sse2.pmovmskb.128") {
          Value *v = call->getOperand(0);
          IRBuilder<> builder(call);
          //%zero = <16 x i8> <i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0, i8 0>
          //%comp = icmp slt <16 x i8> %v, <16 x i8> %zero
          //%result16 = bitcast <8 x i1> %comp to i16
          //%result = zext i16 %result16 to i32
          Value *temp = Constant::getIntegerValue(Type::getInt8Ty(context), llvm::APInt(8, 0, false));
          Value *zero = builder.CreateVectorSplat(16, temp);
          Value *comp = builder.CreateICmpSLT(v, zero);
          Value *result16 = builder.CreateBitCast(comp, Type::getInt16Ty(context));
          Value *result = builder.CreateZExt(result16, Type::getInt32Ty(context));

          //Another way to hoist "llvm.x86.sse2.pmovmskb.128" instruction.
          //build a vector <16 * i8> <i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7, i8 7>
          /*Value *seven = Constant::getIntegerValue(Type::getInt8Ty(context), llvm::APInt(8, 7, false));
            Value *temp = builder.CreateVectorSplat(16, seven);
            Value *msb = builder.CreateLShr(v, temp); 
            errs() << "\nmsb:" << *msb << "\n";         	
            Value *tmp = builder.CreateTrunc(msb, VectorType::get(Type::getInt1Ty(context), 16));         	
            Value *result16 = builder.CreateBitCast(tmp, Type::getInt16Ty(context));
            Value *result = builder.CreateZExt(result16, Type::getInt32Ty(context));*/
          ReplaceInstWithValue(BB.getInstList(), InstItr, result);
          modified = true;
        }

        if (func->getName() == "llvm.x86.sse2.psrl.q") {
          Value *v = call->getOperand(0);
          Value *count_raw = call->getOperand(1);
          // Insert before call.
          IRBuilder<> builder(call);
          Value* count = builder.CreateShuffleVector(
              count_raw,
              UndefValue::get(count_raw->getType()),
              ConstantVector::get({
                ConstantInt::get(Type::getInt32Ty(context), 0),
                ConstantInt::get(Type::getInt32Ty(context), 0),
                })
              );
          // res = lshr v, <count[0], count[0]>
          Value* newshl = builder.CreateLShr(v, count);
          ReplaceInstWithValue(BB.getInstList(), InstItr, newshl);
          modified = true;
        }

      }

      if (modified) {
        DEBUG(errs() << "MODIFIED BB:\n\n");
        DEBUG(BB.dump());
      } else {
        DEBUG(errs() << "BB unmodified\n");
      }
      return modified;
    }

    virtual bool doFinalization(Function &) override {
      // TODO (low priority)
      // Add some function definitions on demand (corresponding to the
      // intrinsics used in this module).  And replace intrinsic calls with
      // these function calls (making the transformation easier and simpler).
      // Concerns: 1. inline. 2. call before declaring. Else?
      return false;
    }
  };
}

char IntrinsicHoistingPass::ID = 0;

// Register the pass.
static RegisterPass<IntrinsicHoistingPass> X(
    "intrinsic-hoisting", "Intrinsic Hoisting Pass", false, false
    );

// Automatically enable the pass.
// http://adriansampson.net/blog/clangpass.html
static void registerIntrinsicHoistingPass(const PassManagerBuilder &,
    legacy::PassManagerBase &PM) {
  PM.add(new IntrinsicHoistingPass());
}
static RegisterStandardPasses
  RegisterMyPass(
      PassManagerBuilder::EP_EarlyAsPossible,
      // PassManagerBuilder::EP_ModuleOptimizerEarly,
      // PassManagerBuilder::EP_LoopOptimizerEnd,
      // PassManagerBuilder::EP_ScalarOptimizerLate,
      // PassManagerBuilder::EP_OptimizerLast,
      // PassManagerBuilder::EP_VectorizerStart,
      // PassManagerBuilder::EP_EnabledOnOptLevel0,
      // PassManagerBuilder::EP_Peephole,
      registerIntrinsicHoistingPass
      );
