#!/bin/bash

# SBatch Logging and mailing
#SBATCH --job-name TotalSeg
#SBATCH --output logs/sbatch-%A_%a-%x@%N.log # https://slurm.schedmd.com/archive/slurm-24.05.1/sbatch.html#SECTION_%3CB%3Efilename-pattern%3C/B%3E:~:text=%5C%5C,Job%20name.
##SBATCH --mail-user <YOUR-MAIL>
#SBATCH --mail-type END,FAIL,TIME_LIMIT_90,INVALID_DEPEND # https://slurm.schedmd.com/archive/slurm-24.05.1/sbatch.html#OPT_mail-type:~:text=Notify%20user%20by,the%20job%20array.
#SBATCH --extra SLURM_MAIL_QUEUED_MINS=1,SLURM_MAIL_RUN_MINS=1 # The minimum PENDING and RUNNING time (in minutes) of the job that should be exceeded to send mail.

# SBatch Reservation and runtime
#SBATCH --time 1-00:00:00
#SBATCH --partition V100,A6000,RTX3090,A5000,TitanRTX #,Pascal,TeslaP40,Xeon # https://lambdalabs.com/gpu-benchmarks
#SBATCH --gpus-per-node 1
##SBATCH --dependency afterany:<JOB-ID> # https://slurm.schedmd.com/archive/slurm-24.05.1/sbatch.html#OPT_dependency
##SBATCH -w gpu102
#SBATCH --exclude gpu12
#SBATCH --array 0-9

# Define Variables
TAG_NAME=$(echo "$SLURM_JOB_NAME" | tr -cd '[:print:]' | tr ' ' '_' | tr '[:upper:]' '[:lower:]')
DOCKER_IMAGE="localhost/$TAG_NAME"

PARAMS_ARRAY=(
    "-i=data/nifti_respacing5.0/CT???0/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti_respacing5.0/CT???1/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti_respacing5.0/CT???2/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti_respacing5.0/CT???3/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti_respacing5.0/CT???4/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti_respacing5.0/CT???5/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti_respacing5.0/CT???6/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti_respacing5.0/CT???7/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti_respacing5.0/CT???8/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti_respacing5.0/CT???9/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
)
PARAMS="${PARAMS_ARRAY[$SLURM_ARRAY_TASK_ID]}"

printf "Datetime: $(date)\n"
printf "Hostname: $(hostname)\n"
printf "Allocated GPUs:\n" && nvidia-smi -L

# Build image
docker build . -t $DOCKER_IMAGE \
    --build-arg http_proxy=http://192.168.45.108:3128 \
    --build-arg https_proxy=http://192.168.45.108:3128 \
    --build-arg HTTP_PROXY=http://192.168.45.108:3128 \
    --build-arg HTTPS_PROXY=http://192.168.45.108:3128 \
    -f Dockerfile

# Start Container
docker run -i --rm --device nvidia.com/gpu=all --shm-size 64GB \
    -v $PWD:/workspace:rw \
    -v /mnt/nas216/Fatty_LLiver:/workspace/data/raw:ro \
    -v /mnt/nas216/Fatty_LLiver/_Preprocessed:/workspace/data:rw \
    -e http_proxy=http://192.168.45.108:3128 \
    -e https_proxy=http://192.168.45.108:3128 \
    -e HTTP_PROXY=http://192.168.45.108:3128 \
    -e HTTPS_PROXY=http://192.168.45.108:3128 \
    $DOCKER_IMAGE \
    python totalsegmentator/bin/TotalSegmentator.py $PARAMS