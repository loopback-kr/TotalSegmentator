#!/bin/bash

# SBatch Logging and mailing
#SBATCH --job-name TotalSeg-ALL-7
#SBATCH --output logs/%x-%A-%N.out # https://slurm.schedmd.com/archive/slurm-24.05.1/sbatch.html#SECTION_%3CB%3Efilename-pattern%3C/B%3E:~:text=%5C%5C,Job%20name.
#SBATCH --mail-user hyunseoki.bus@gmail.com
#SBATCH --mail-type BEGIN,END,FAIL,TIME_LIMIT_90,INVALID_DEPEND # https://slurm.schedmd.com/archive/slurm-24.05.1/sbatch.html#OPT_mail-type:~:text=Notify%20user%20by,the%20job%20array.
#SBATCH --extra SLURM_MAIL_QUEUED_MINS=1,SLURM_MAIL_RUN_MINS=1 # The minimum PENDING and RUNNING time (in minutes) of the job that should be exceeded to send mail.

# SBatch Reservation and runtime
#SBATCH --time 10:00:00
#SBATCH --partition A6000,RTX3090,A5000,V100,RTX8000,TitanRTX #,Pascal,TeslaP40,Xeon # https://lambdalabs.com/gpu-benchmarks
#SBATCH --gpus-per-node 1
##SBATCH --qos cpu # Uncomment to use CPU partitions
##SBATCH --dependency afterany:<JOB-ID> # https://slurm.schedmd.com/archive/slurm-24.05.1/sbatch.html#OPT_dependency
#SBATCH --exclude gpu10,gpu31,gpu35,gpu102

# Define Variables
TAG_NAME=$(echo "$SLURM_JOB_NAME" | tr -cd '[:print:]' | tr ' ' '_' | tr '[:upper:]' '[:lower:]')
DOCKER_IMAGE="localhost/$TAG_NAME"

# Start Container
docker build . -t $DOCKER_IMAGE -f ./Dockerfile
docker run -i --rm --device nvidia.com/gpu=all --shm-size 64GB \
    -v $PWD:/workspace:rw \
    -v /mnt/nas100/forGPU/sunggu/0.Challenge/MICCAI2024_AMOSMM/dataset/AMOS-MM-ReSpacing5.0:/workspace/data/AMOS-MM-ReSpacing5.0 \
    $DOCKER_IMAGE \
    python -u totalsegmentator/bin/TotalSegmentator.py \
        -i=data/AMOS-MM-ReSpacing5.0/images*/amos_\?\?\?7.nii.gz \
        -o=out/amos-mm-mask \
        -rs="kidney_right kidney_left liver sacrum lung_upper_lobe_left lung_lower_lobe_left lung_upper_lobe_right lung_lower_lobe_right"
