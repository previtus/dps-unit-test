#!/bin/bash

basedir=$( cd "$(dirname "$0")" ; pwd -P)

OUTPUTDIR="${PWD}/output"
INPUT_FILE=$(ls -d input/*)
# ^ it automatically downloads the URL provided (idk how to send just normal args yet)
# what if we had multiple inputs instead that were not URLs?

echo "PATH contents:"
echo $PATH
#/srv/conda/envs/notebook/bin:/srv/conda/condabin:/srv/conda/envs/notebook/bin:/srv/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

mkdir -p ${OUTPUTDIR}
echo "Testing writing output product"
python ${basedir}/test-output-product.py ${OUTPUTDIR}

# Read the positional argument as defined in the algorithm registration here
output_file=$1
my_output_parameter=$2

echo "maybe this is how to parse the outputs params:"
echo $output_file
echo my_output_parameter
# meanwhile all inputs just get downloaded? idk!

echo "Testing opening input file"
python ${basedir}/test-input-file.py ${INPUT_FILE}

echo "PYTHON pip freeze"
pip freeze
# ^ doesn't have anything special outside of the base environment
# -> so we will have to setup a build command likely ...

echo "CONDA conda info --envs"
conda info --envs
## conda environments:
##
## * -> active
## + -> frozen
#base                     /srv/conda
#notebook             *   /srv/conda/envs/notebook

echo "Testing PYTHON imports"
python ${basedir}/test-imports.py

# Hangs there - it's infinitely waiting for "input("Enter your Earthdata Login username: ")"
#echo "Testing PYTHON download"
#python ${basedir}/test-download.py

echo "Trying paths"
echo "ls"
ls

echo "ls /"
ls /

echo "ls *"
ls *

echo "aws s3 commands"
# can I do this?
aws s3 cp s3://nasa-maap-data-store/file-staging/nasa-map/ESACCI_Biomass_L4_AGB_V4_100m_2020/S40E160_ESACCI-BIOMASS-L4-AGB-MERGED-100m-2020-fv4.0.tif .
aws s3 ls s3://nasa-maap-data-store/file-staging/nasa-map/

