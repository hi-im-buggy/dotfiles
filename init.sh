#!/bin/sh
crates=$(find . -mindepth 1 -maxdepth 1 -type d ! -iname ".*" -printf "%f\n")
for crate in $crates; do
	stow $crate
done
