#!/bin/bash

basedir=$( cd "$(dirname "$0")" ; pwd -P )

pip install -r ${basedir}/requirements.txt

pip install -U "huggingface_hub[cli]"

hf download previtus/JPL_TRACE_GASES_MODELS --local-dir ${basedir}/models/JPL_TRACE_GASES_MODELS

