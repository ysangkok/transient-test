#!/bin/sh
set -e
set -x
stack setup
stack build
stack setup --compiler=ghcjs-0.2.0_ghc-7.10.3
stack build --compiler=ghcjs-0.2.0_ghc-7.10.3
mkdir -p static/out.jsexe
cp -vr .stack-work/install/x86_64-linux/lts-6.5/ghcjs-0.2.0_ghc-7.10.3/bin/transient-test-exe.jsexe/. static/out.jsexe/
