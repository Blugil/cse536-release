# Install brew if not installed
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

# Install prerequisite packages
brew install python3 gawk gnu-sed gmp mpfr libmpc isl zlib expat
brew tap discoteq/discoteq
brew install flock
brew install textinfo
brew tap riscv-software-src/riscv
brew install riscv-tools

# Install toolchain
pushd ../
    # clone the repo
    [ ! -d "riscv-gnu-toolchain" ] && git clone https://github.com/riscv/riscv-gnu-toolchain

    pushd riscv-gnu-toolchain
        mkdir build
        pushd gcc
            ./contrib/download_prerequisites
        popd
        ./configure --prefix=`pwd`/build 
        make -j `sysctl -n hw.ncpu`
    popd
popd
