#!/bin/bash

basedir=$( cd "$(dirname "$0")" ; pwd -P )

pip install -r ${basedir}/requirements.txt
# ^ this does install loads of things ... (TODO: maybe select just a CPU only subset? Also from a smaller source container?)

pip install -U "huggingface_hub[cli]"
# ^ so this also probably worked!

hf download previtus/JPL_TRACE_GASES_MODELS --local-dir ${basedir}/models/JPL_TRACE_GASES_MODELS
# > should end up at "/app/dps-unit-test/models/JPL_TRACE_GASES_MODELS"
# Fetching 12 files:   0%|          | 0/12 [00:00<?, ?it/s]
# Warning: You are sending unauthenticated requests to the HF Hub.
# Please set a HF_TOKEN to enable higher rate limits and faster downloads.

# ... this all will only occur once during the "algorithm registration" == image building ...

pip install maap-py
# ^ needed for loading the secrets handed over as configs (should be used for API keys etc)

pip install gdown
# ^ for our own s3 access independent demo...

