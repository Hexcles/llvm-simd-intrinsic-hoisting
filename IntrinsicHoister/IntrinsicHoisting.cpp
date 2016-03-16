#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

using namespace llvm;

namespace {
  struct IntrinsicHoistingPass : public FunctionPass {
    static char ID;
    IntrinsicHoistingPass() : FunctionPass(ID) {}

    virtual bool doInitialization(Module &M) override {
      errs() << "Entering module: " << M.getModuleIdentifier() << "\n";
      return false;
    }

    virtual bool runOnFunction(Function &F) override {
      bool modified = false;
      LLVMContext & context = F.getContext();

      errs() << "Function: " << F.getName() << "\n";
      //F.viewCFG();      // Display CFG of the current function (require Graphviz)
      for (auto &BB: F) {
        errs() << "Entering basic block: \n";
        for (BasicBlock::iterator InstItr = BB.begin(); InstItr != BB.end(); InstItr++) {
          CallInst * call = dyn_cast<CallInst>(InstItr);
          if (call == NULL) continue;
          Function * func = call->getCalledFunction();
          if (func->getName().startswith("llvm.x86"))
            errs() << "Found intrinsic: " << func->getName() << "\n";
          else
            continue;

          // TODO more intrinsic replacement
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
        }
      }

      return modified;
    }

    virtual bool doFinalization(Module &) override {
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
