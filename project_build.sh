#!/bin/bash

cd tcl
echo ""
echo "*** Building Vivado Project ***"
vivado -mode batch -source vivado_build.tcl -notrace
echo "Done"

echo ""
echo ""
echo ""
echo "*** Building Vitis Project ***"
xsct vitis_build.tcl
echo "Done"

# Remove unused files
# todo
