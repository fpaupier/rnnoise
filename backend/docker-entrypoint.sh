#!/bin/bash

# Perform the de-noising from the noisy input file
./examples/rnnoise_demo examples/$INPUT_FILE /tmp/denoised.pcm

# Export the RAW PCM data to wav
#TODO: FPR ffmpeg options should be parametrized instead of hardcoded (freq, mono/stereo, etc)
ffmpeg -f s16le -ar 44.1k -ac 2 -i /tmp/denoised.pcm examples/denoised.wav -y -hide_banner -loglevel error

# Remove the temp file
rm /tmp/denoised.pcm
