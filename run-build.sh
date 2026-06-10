#!/bin/bash

basedir=$( cd "$(dirname "$0")" ; pwd -P )

pip install -r ${basedir}/requirements.txt

hf download previtus/JPL_TRACE_GASES_MODELS --local-dir ${basedir}/models/JPL_TRACE_GASES_MODELS

