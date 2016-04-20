add_library(IntrinsicHoisting MODULE
    # List your source files here.
    IntrinsicHoisting.cpp
)

# LLVM is (typically) built with no C++ RTTI. We need to match that.
set_target_properties(IntrinsicHoisting PROPERTIES
    COMPILE_FLAGS "-fno-rtti"
)

# Get proper shared-library behavior (where symbols are not necessarily
# resolved when the shared library is linked) on OS X.
if(APPLE)
    set_target_properties(IntrinsicHoisting PROPERTIES
        LINK_FLAGS "-undefined dynamic_lookup"
    )
endif(APPLE)
