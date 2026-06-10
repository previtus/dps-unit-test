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
my_output_parameter=$1

echo "maybe this is how to parse the outputs params:"
echo $my_output_parameter
# ^ this works! TODO: send EMIT_... L1B name probably

echo "Testing opening input file"
python ${basedir}/test-input-file.py --input_file ${INPUT_FILE} --my_output_parameter ${my_output_parameter}

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
# >> Passed all tested imports!

# Hangs there - it's infinitely waiting for "input("Enter your Earthdata Login username: ")"
#echo "Testing PYTHON download"
#python ${basedir}/test-download.py

echo "Trying paths"
echo "ls"
ls
#_context.json
#_docker_params.json
#_job.json
#_pid
#_run.sh
#_stderr.txt
#_stdout.txt
#celeryconfig.py
#datasets.json
#input
#output

echo "ls /"
ls /

echo "ls *"
ls *
#input:
#vr03.jpg
#
#output:
#write-output.txt


echo "aws s3 commands"
# can I do this?
#aws s3 cp s3://nasa-maap-data-store/file-staging/nasa-map/ESACCI_Biomass_L4_AGB_V4_100m_2020/S40E160_ESACCI-BIOMASS-L4-AGB-MERGED-100m-2020-fv4.0.tif .
# ^ ... maybe this makes it slow btw ...
# Completed 256.0 KiB/7.5 MiB (1.1 MiB/s) with 1 file(s) remaining
# Completed 7.5 MiB/7.5 MiB (12.7 MiB/s) with 1 file(s) remaining

aws s3 ls s3://nasa-maap-data-store/file-staging/nasa-map/

# and what about the EMIT data? (we might get access denied - idk if we need some special credentials or to be at some special location (aws us-west-2 ? maybe ?)
aws s3 ls s3://lp-prod-protected/EMITL2ARFL.001/

# TODO: also try maap secrets for getting earthaccess working
# TODO: also try python mailing out