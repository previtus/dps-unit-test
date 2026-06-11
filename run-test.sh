#!/bin/bash

BASEDIR=$( cd "$(dirname "$0")" ; pwd -P)

# prepare output directory
OUTPUTDIR="${PWD}/output"
mkdir -p ${OUTPUTDIR}

echo "Testing writing output product"
python ${BASEDIR}/test-output-product.py ${OUTPUTDIR}

# Read the positional argument as defined in the algorithm registration here
emit_scene_name=$1

echo "Testing PYTHON imports"
python ${BASEDIR}/test-imports.py
# >> Passed all tested imports!

echo "Testing PYTHON vector codes"
python ${BASEDIR}/test-vectors.py

echo "Testing PYTHON mailout codes"
python ${BASEDIR}/test-mailout.py

export PYTHONPATH="$BASEDIR/daily-trace-gases:$PYTHONPATH"

# ======
echo "Testing full run!"
python ${BASEDIR}/daily-trace-gases/detect_trace_gas.py -gas "ch4" -tile $1 -basedir ${BASEDIR}/daily-trace-gases/ -results_folder ${OUTPUTDIR}

echo "---"
echo "ls ${OUTPUTDIR}"
ls ${OUTPUTDIR}
echo "---"
echo "ls ${OUTPUTDIR}/*"
ls ${OUTPUTDIR}/*
echo "---"
echo "ls *"
ls *
echo "---"


echo "further debug for gdal ..."
echi "ls /srv/conda/envs/notebook/share/gdal"
ls /srv/conda/envs/notebook/share/gdal
echo "GDAL_DATA:"
echo $GDAL_DATA

# TODO: also try python mailing out

#echo "PYTHON pip freeze"
#pip freeze
#echo "CONDA conda info --envs"
#conda info --envs
