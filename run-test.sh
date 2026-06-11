#!/bin/bash

basedir=$( cd "$(dirname "$0")" ; pwd -P)

OUTPUTDIR="${PWD}/output"
INPUT_FILE=$(ls -d input/*)
# ^ it automatically downloads the URL provided (idk how to send just normal args yet)
# what if we had multiple inputs instead that were not URLs?

echo "Trying pwd"
pwd
#Trying pwd
#/data/work/jobs/2026/06/10/21/52/job-vitek_tutorial_v03__main-20260610T213801.863754Z

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

echo "Testing secrets interface:"
python ${basedir}/test-secrets.py

echo "PYTHONPATH contents (before and after):"
echo $PYTHONPATH
export PYTHONPATH="$basedir/daily-trace-gases:$PYTHONPATH"
echo $PYTHONPATH

# download sample scene - would need to have rad, obs, mask and ch4enh to fully replace the download ...
#echo "making dir"
#mkdir ${basedir}/daily-trace-gases/run_data/intermediates_folder/EMIT_L1B_RAD_001_20260102T143123_2600209_005
#echo "downloading sample from gdown"
#gdown 1npZ8Q9mQPiE0I_2W2B1TcHspfTiODwom
#echo "unzipping"
#unzip EMIT_L1B_RAD_001_20260102T143123_2600209_005.zip -d ${basedir}/daily-trace-gases/run_data/intermediates_folder/EMIT_L1B_RAD_001_20260102T143123_2600209_005
## Archive:  EMIT_L1B_RAD_001_20260102T143123_2600209_005.zip

# ======
echo "Testing full code!"
python ${basedir}/daily-trace-gases/detect_trace_gas.py -gas "ch4" -tile "EMIT_L1B_RAD_001_20260102T143123_2600209_005" -basedir ${basedir}/daily-trace-gases/

echo "1st debug code directories..."
echo "---"
echo "ls daily-trace-gases/"
ls ${basedir}/daily-trace-gases/
echo "---"
echo "ls daily-trace-gases/run_data"
ls ${basedir}/daily-trace-gases/run_data
echo "---"
echo "ls daily-trace-gases/run_data/*"
ls ${basedir}/daily-trace-gases/run_data/*


# ======
echo "Full code with tile name from parameter!"
echo $1
python ${basedir}/daily-trace-gases/detect_trace_gas.py -gas "ch4" -tile $1 -basedir ${basedir}/daily-trace-gases/

echo "2nd debug code directories..."
echo "---"
echo "ls daily-trace-gases/"
ls ${basedir}/daily-trace-gases/
echo "---"
echo "ls daily-trace-gases/run_data"
ls ${basedir}/daily-trace-gases/run_data
echo "---"
echo "ls daily-trace-gases/run_data/*"
ls ${basedir}/daily-trace-gases/run_data/*

# Hangs there - it's infinitely waiting for "input("Enter your Earthdata Login username: ")"
#echo "Testing PYTHON download"
#python ${basedir}/test-download.py

#echo "Trying paths"
#echo "ls"
#ls
##_context.json
##_docker_params.json
##_job.json
##_pid
##_run.sh
##_stderr.txt
##_stdout.txt
##celeryconfig.py
##datasets.json
##input
##output
#
#echo "ls /"
#ls /

echo "ls *"
ls *
#input:
#vr03.jpg
#
#output:
#write-output.txt


# what about aws access like this?
echo "tryin aws s3 ls EMITL2ARFL"
aws s3 ls s3://lp-prod-protected/EMITL2ARFL.001/

# TODO: also try python mailing out
