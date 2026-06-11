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

# download sample scene
echo "making dir"
mkdir ${basedir}/daily-trace-gases/run_data/intermediates_folder/EMIT_L1B_RAD_001_20260102T143123_2600209_005
echo "downloading sample from gdown"
gdown 1npZ8Q9mQPiE0I_2W2B1TcHspfTiODwom
echo "unzipping"
unzip EMIT_L1B_RAD_001_20260102T143123_2600209_005.zip -d ${basedir}/daily-trace-gases/run_data/intermediates_folder/EMIT_L1B_RAD_001_20260102T143123_2600209_005
# Archive:  EMIT_L1B_RAD_001_20260102T143123_2600209_005.zip

# I hope this will use the downloaded example (and not hang on Earthdata login as before...)
echo "Testing full code!"
python ${basedir}/daily-trace-gases/detect_trace_gas.py -gas "ch4" -tile "EMIT_L1B_RAD_001_20260102T143123_2600209_005" -basedir ${basedir}/daily-trace-gases/
#Testing full code!
#Running detection of ch4 in EMIT tile: EMIT_L1B_RAD_001_20260102T143123_2600209_005
#----------------------------------------
#Step 1: getting data, computing WMF, RGB
#Downloading L1 data (RAD, OBS and mask) (... This might take some time!)
#Enter your Earthdata Login username:

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


# I hope this will use the downloaded example (and not hang on Earthdata login as before...)
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


#echo "aws s3 commands"
# can I do this?
#aws s3 cp s3://nasa-maap-data-store/file-staging/nasa-map/ESACCI_Biomass_L4_AGB_V4_100m_2020/S40E160_ESACCI-BIOMASS-L4-AGB-MERGED-100m-2020-fv4.0.tif .
# ^ ... maybe this makes it slow btw ...
# Completed 256.0 KiB/7.5 MiB (1.1 MiB/s) with 1 file(s) remaining
# Completed 7.5 MiB/7.5 MiB (12.7 MiB/s) with 1 file(s) remaining

#aws s3 ls s3://nasa-maap-data-store/file-staging/nasa-map/
# and what about the EMIT data? (we might get access denied - idk if we need some special credentials or to be at some special location (aws us-west-2 ? maybe ?)
#aws s3 ls s3://lp-prod-protected/EMITL2ARFL.001/

# TODO: also try maap secrets for getting earthaccess working
# TODO: also try python mailing out
# TODO: also try running my longer demo ...