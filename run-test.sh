#!/bin/bash

basedir=$( cd "$(dirname "$0")" ; pwd -P)

OUTPUTDIR="${PWD}/output"
INPUT_FILE=$(ls -d input/*)

echo "PATH contents:"
echo $PATH

mkdir -p ${OUTPUTDIR}
echo "Testing writing output product"
python ${basedir}/test-output-product.py ${OUTPUTDIR}

echo "Testing opening input file"
python ${basedir}/test-input-file.py ${INPUT_FILE}

echo "PYTHON pip freeze"
pip freeze

echo "CONDA conda info --envs"
conda info --envs

echo "Testing PYTHON imports"
python ${basedir}/test-imports.py

echo "Testing PYTHON download"
python ${basedir}/test-download.py


