set -x PATH \
        /usr/local/Cellar/llvm/HEAD-2c4ca68/bin \
	/Applications/Julia-1.4.app/Contents/Resources/julia/bin \
	/usr/local/cuda/bin \
	/Users/adamkowalski/zig \
	/Users/adamkowalski/bin \
	/Library/Developer/CommandLineTools/usr/bin \
	/usr/local/Cellar/cmake/3.15.3/bin \
	/usr/local/Cellar/gcc/9.1.0/bin \
	/usr/local/Cellar/ruby/2.6.5/bin \
	/usr/local/Cellar/vim/HEAD-bb65a56/bin \
	/usr/local/Cellar/llvm/HEAD-2c4ca68/bin \
	/Library/Frameworks/Python.framework/Versions/3.8/bin \
	/Users/adamkowalski/Library/Python/3.8/bin \
	/Users/adamkowalski/.cargo/bin \
	/Users/adamkowalski/.local/bin \
	$PATH

set -x SDKROOT (xcrun --sdk macosx --show-sdk-path)

set -x DYLD_LIBRARY_PATH usr/local/cuda/lib $DYLD_LIBRARY_PATH

set -x JULIA_NUM_THREADS (sysctl -n hw.ncpu)

set -x EDITOR vim

set -x CXX clang++
set -x CC clang

set fish_greeting

alias v=vim
alias vi=vim
alias e="emacsclient -a '' -c"

fish_vi_key_bindings

zoxide init fish | source
