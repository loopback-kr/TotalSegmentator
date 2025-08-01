#!/bin/bash

# SBatch Logging and mailing
#SBATCH --job-name TotalSeg-CBCT
#SBATCH --output logs/%x/%j.log # https://slurm.schedmd.com/archive/slurm-24.05.1/sbatch.html#SECTION_%3CB%3Efilename-pattern%3C/B%3E:~:text=%5C%5C,Job%20name.

# SBatch Reservation and runtime
#SBATCH --time 1-00:00:00
#SBATCH --partition V100,A6000,RTX3090,A5000,RTX8000,TitanRTX
#SBATCH --gpus-per-node 1
#SBATCH --array 0-29
#SBATCH --account found.mi2rl

# Define Variables
TAG_NAME=$(echo "$SLURM_JOB_NAME" | tr -cd '[:print:]' | tr ' ' '_' | tr '[:upper:]' '[:lower:]')
DOCKER_IMAGE="localhost/$TAG_NAME"

# 기타 장기들
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
# 간 혈관
PARAMS_ARRAY=(
    "-i=data/nifti_respacing5.0/CT???0/*.nii.gz -o=data/totalseg --task=liver_vessels --remove_small_blobs"
    "-i=data/nifti_respacing5.0/CT???1/*.nii.gz -o=data/totalseg --task=liver_vessels --remove_small_blobs"
    "-i=data/nifti_respacing5.0/CT???2/*.nii.gz -o=data/totalseg --task=liver_vessels --remove_small_blobs"
    "-i=data/nifti_respacing5.0/CT???3/*.nii.gz -o=data/totalseg --task=liver_vessels --remove_small_blobs"
    "-i=data/nifti_respacing5.0/CT???4/*.nii.gz -o=data/totalseg --task=liver_vessels --remove_small_blobs"
    "-i=data/nifti_respacing5.0/CT???5/*.nii.gz -o=data/totalseg --task=liver_vessels --remove_small_blobs"
    "-i=data/nifti_respacing5.0/CT???6/*.nii.gz -o=data/totalseg --task=liver_vessels --remove_small_blobs"
    "-i=data/nifti_respacing5.0/CT???7/*.nii.gz -o=data/totalseg --task=liver_vessels --remove_small_blobs"
    "-i=data/nifti_respacing5.0/CT???8/*.nii.gz -o=data/totalseg --task=liver_vessels --remove_small_blobs"
    "-i=data/nifti_respacing5.0/CT???9/*.nii.gz -o=data/totalseg --task=liver_vessels --remove_small_blobs"
)
# 간 비장
PARAMS_ARRAY=(
    # "-i=data/nifti_respacing5.0/CT???0/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=data/nifti_respacing5.0/CT???1/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=data/nifti_respacing5.0/CT???2/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=data/nifti_respacing5.0/CT???3/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=data/nifti_respacing5.0/CT???4/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=data/nifti_respacing5.0/CT???5/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=data/nifti_respacing5.0/CT???6/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=data/nifti_respacing5.0/CT???7/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=data/nifti_respacing5.0/CT???8/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=data/nifti_respacing5.0/CT???9/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=data/nifti_respacing5.0/CT5550/*.nii.gz -o=data/totalseg --task=total --remove_small_blobs --roi_subset=liver,spleen"
)

# 기타 장기들
PARAMS_ARRAY=(
    "-i=data/nifti-respacing5/CT???0/pre.nii.gz -o=data/mask-respacing5 --task=total --remove_small_blobs --roi_subset=liver,spleen,stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti-respacing5/CT???1/pre.nii.gz -o=data/mask-respacing5 --task=total --remove_small_blobs --roi_subset=liver,spleen,stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti-respacing5/CT???2/pre.nii.gz -o=data/mask-respacing5 --task=total --remove_small_blobs --roi_subset=liver,spleen,stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti-respacing5/CT???3/pre.nii.gz -o=data/mask-respacing5 --task=total --remove_small_blobs --roi_subset=liver,spleen,stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti-respacing5/CT???4/pre.nii.gz -o=data/mask-respacing5 --task=total --remove_small_blobs --roi_subset=liver,spleen,stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti-respacing5/CT???5/pre.nii.gz -o=data/mask-respacing5 --task=total --remove_small_blobs --roi_subset=liver,spleen,stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti-respacing5/CT???6/pre.nii.gz -o=data/mask-respacing5 --task=total --remove_small_blobs --roi_subset=liver,spleen,stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti-respacing5/CT???7/pre.nii.gz -o=data/mask-respacing5 --task=total --remove_small_blobs --roi_subset=liver,spleen,stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti-respacing5/CT???8/pre.nii.gz -o=data/mask-respacing5 --task=total --remove_small_blobs --roi_subset=liver,spleen,stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
    "-i=data/nifti-respacing5/CT???9/pre.nii.gz -o=data/mask-respacing5 --task=total --remove_small_blobs --roi_subset=liver,spleen,stomach,kidney_left,kidney_right,aorta,portal_vein_and_splenic_vein,inferior_vena_cava"
)
PARAMS_ARRAY=(
    "-i=/mnt/NEW/DATA/ct_nii_resampled_direction/*0.nii.gz -o=/mnt/NEW/hyunseoki/TotalSegmt --task=total --remove_small_blobs --roi_subset=vertebrae_S1,vertebrae_L5,vertebrae_L4,vertebrae_L3,vertebrae_L2,vertebrae_L1,vertebrae_T12,vertebrae_T11,vertebrae_T10,vertebrae_T9,vertebrae_T8,vertebrae_T7,vertebrae_T6,vertebrae_T5,vertebrae_T4,vertebrae_T3,vertebrae_T2,vertebrae_T1,vertebrae_C7,vertebrae_C6,vertebrae_C5,vertebrae_C4,vertebrae_C3,vertebrae_C2,vertebrae_C1"
    "-i=/mnt/NEW/DATA/ct_nii_resampled_direction/*1.nii.gz -o=/mnt/NEW/hyunseoki/TotalSegmt --task=total --remove_small_blobs --roi_subset=vertebrae_S1,vertebrae_L5,vertebrae_L4,vertebrae_L3,vertebrae_L2,vertebrae_L1,vertebrae_T12,vertebrae_T11,vertebrae_T10,vertebrae_T9,vertebrae_T8,vertebrae_T7,vertebrae_T6,vertebrae_T5,vertebrae_T4,vertebrae_T3,vertebrae_T2,vertebrae_T1,vertebrae_C7,vertebrae_C6,vertebrae_C5,vertebrae_C4,vertebrae_C3,vertebrae_C2,vertebrae_C1"
    "-i=/mnt/NEW/DATA/ct_nii_resampled_direction/*2.nii.gz -o=/mnt/NEW/hyunseoki/TotalSegmt --task=total --remove_small_blobs --roi_subset=vertebrae_S1,vertebrae_L5,vertebrae_L4,vertebrae_L3,vertebrae_L2,vertebrae_L1,vertebrae_T12,vertebrae_T11,vertebrae_T10,vertebrae_T9,vertebrae_T8,vertebrae_T7,vertebrae_T6,vertebrae_T5,vertebrae_T4,vertebrae_T3,vertebrae_T2,vertebrae_T1,vertebrae_C7,vertebrae_C6,vertebrae_C5,vertebrae_C4,vertebrae_C3,vertebrae_C2,vertebrae_C1"
    "-i=/mnt/NEW/DATA/ct_nii_resampled_direction/*3.nii.gz -o=/mnt/NEW/hyunseoki/TotalSegmt --task=total --remove_small_blobs --roi_subset=vertebrae_S1,vertebrae_L5,vertebrae_L4,vertebrae_L3,vertebrae_L2,vertebrae_L1,vertebrae_T12,vertebrae_T11,vertebrae_T10,vertebrae_T9,vertebrae_T8,vertebrae_T7,vertebrae_T6,vertebrae_T5,vertebrae_T4,vertebrae_T3,vertebrae_T2,vertebrae_T1,vertebrae_C7,vertebrae_C6,vertebrae_C5,vertebrae_C4,vertebrae_C3,vertebrae_C2,vertebrae_C1"
    "-i=/mnt/NEW/DATA/ct_nii_resampled_direction/*4.nii.gz -o=/mnt/NEW/hyunseoki/TotalSegmt --task=total --remove_small_blobs --roi_subset=vertebrae_S1,vertebrae_L5,vertebrae_L4,vertebrae_L3,vertebrae_L2,vertebrae_L1,vertebrae_T12,vertebrae_T11,vertebrae_T10,vertebrae_T9,vertebrae_T8,vertebrae_T7,vertebrae_T6,vertebrae_T5,vertebrae_T4,vertebrae_T3,vertebrae_T2,vertebrae_T1,vertebrae_C7,vertebrae_C6,vertebrae_C5,vertebrae_C4,vertebrae_C3,vertebrae_C2,vertebrae_C1"
    "-i=/mnt/NEW/DATA/ct_nii_resampled_direction/*5.nii.gz -o=/mnt/NEW/hyunseoki/TotalSegmt --task=total --remove_small_blobs --roi_subset=vertebrae_S1,vertebrae_L5,vertebrae_L4,vertebrae_L3,vertebrae_L2,vertebrae_L1,vertebrae_T12,vertebrae_T11,vertebrae_T10,vertebrae_T9,vertebrae_T8,vertebrae_T7,vertebrae_T6,vertebrae_T5,vertebrae_T4,vertebrae_T3,vertebrae_T2,vertebrae_T1,vertebrae_C7,vertebrae_C6,vertebrae_C5,vertebrae_C4,vertebrae_C3,vertebrae_C2,vertebrae_C1"
    "-i=/mnt/NEW/DATA/ct_nii_resampled_direction/*6.nii.gz -o=/mnt/NEW/hyunseoki/TotalSegmt --task=total --remove_small_blobs --roi_subset=vertebrae_S1,vertebrae_L5,vertebrae_L4,vertebrae_L3,vertebrae_L2,vertebrae_L1,vertebrae_T12,vertebrae_T11,vertebrae_T10,vertebrae_T9,vertebrae_T8,vertebrae_T7,vertebrae_T6,vertebrae_T5,vertebrae_T4,vertebrae_T3,vertebrae_T2,vertebrae_T1,vertebrae_C7,vertebrae_C6,vertebrae_C5,vertebrae_C4,vertebrae_C3,vertebrae_C2,vertebrae_C1"
    "-i=/mnt/NEW/DATA/ct_nii_resampled_direction/*7.nii.gz -o=/mnt/NEW/hyunseoki/TotalSegmt --task=total --remove_small_blobs --roi_subset=vertebrae_S1,vertebrae_L5,vertebrae_L4,vertebrae_L3,vertebrae_L2,vertebrae_L1,vertebrae_T12,vertebrae_T11,vertebrae_T10,vertebrae_T9,vertebrae_T8,vertebrae_T7,vertebrae_T6,vertebrae_T5,vertebrae_T4,vertebrae_T3,vertebrae_T2,vertebrae_T1,vertebrae_C7,vertebrae_C6,vertebrae_C5,vertebrae_C4,vertebrae_C3,vertebrae_C2,vertebrae_C1"
    "-i=/mnt/NEW/DATA/ct_nii_resampled_direction/*8.nii.gz -o=/mnt/NEW/hyunseoki/TotalSegmt --task=total --remove_small_blobs --roi_subset=vertebrae_S1,vertebrae_L5,vertebrae_L4,vertebrae_L3,vertebrae_L2,vertebrae_L1,vertebrae_T12,vertebrae_T11,vertebrae_T10,vertebrae_T9,vertebrae_T8,vertebrae_T7,vertebrae_T6,vertebrae_T5,vertebrae_T4,vertebrae_T3,vertebrae_T2,vertebrae_T1,vertebrae_C7,vertebrae_C6,vertebrae_C5,vertebrae_C4,vertebrae_C3,vertebrae_C2,vertebrae_C1"
    "-i=/mnt/NEW/DATA/ct_nii_resampled_direction/*9.nii.gz -o=/mnt/NEW/hyunseoki/TotalSegmt --task=total --remove_small_blobs --roi_subset=vertebrae_S1,vertebrae_L5,vertebrae_L4,vertebrae_L3,vertebrae_L2,vertebrae_L1,vertebrae_T12,vertebrae_T11,vertebrae_T10,vertebrae_T9,vertebrae_T8,vertebrae_T7,vertebrae_T6,vertebrae_T5,vertebrae_T4,vertebrae_T3,vertebrae_T2,vertebrae_T1,vertebrae_C7,vertebrae_C6,vertebrae_C5,vertebrae_C4,vertebrae_C3,vertebrae_C2,vertebrae_C1"
)
PARAMS_ARRAY=(
    # "-i=/mnt/data/CT0*0_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT0*1_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT0*2_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT0*3_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT0*4_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT0*5_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT0*6_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT0*7_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT0*8_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT0*9_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
# 
    # "-i=/mnt/data/CT1*0_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT1*1_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT1*2_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT1*3_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT1*4_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT1*5_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT1*6_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT1*7_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT1*8_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT1*9_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
# 
    # "-i=/mnt/data/CT2*0_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT2*1_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT2*2_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT2*3_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT2*4_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT2*5_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT2*6_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT2*7_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT2*8_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    # "-i=/mnt/data/CT2*9_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"

    "-i=/mnt/data/CT3*0_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT3*1_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT3*2_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT3*3_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT3*4_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT3*5_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT3*6_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT3*7_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT3*8_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT3*9_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"

    "-i=/mnt/data/CT4*0_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT4*1_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT4*2_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT4*3_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT4*4_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT4*5_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT4*6_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT4*7_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT4*8_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT4*9_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"

    "-i=/mnt/data/CT5*0_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT5*1_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT5*2_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT5*3_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT5*4_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT5*5_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT5*6_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT5*7_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT5*8_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
    "-i=/mnt/data/CT5*9_*.nii.gz -o=/mnt/out --task=total --remove_small_blobs --roi_subset=liver,spleen"
)
PARAMS="${PARAMS_ARRAY[$SLURM_ARRAY_TASK_ID]}"

printf "Datetime: $(date)\n"
printf "Hostname: $(hostname)\n"
printf "Allocated GPUs:\n" && nvidia-smi -L

# Build image
docker build . -t $DOCKER_IMAGE \
    --build-arg http_proxy=http://proxy.mi2rl.co:3128 \
    --build-arg https_proxy=http://proxy.mi2rl.co:3128 \
    -f Dockerfile

# Start Container
docker run -i --rm --device nvidia.com/gpu=all --shm-size 64GB \
    -v $PWD:/workspace:rw \
    -v $HOME/projects/fattyliver-detector/fattyliver-regression/data/fattyliver-align_spacing_5or6mm-30days-PreOnly.nifti:/mnt/data \
    -v $HOME/projects/fattyliver-detector/fattyliver-regression/data/fattyliver-align_spacing_5or6mm-30days-PreOnly.totalseg:/mnt/out \
    -e TOTALSEG_WEIGHTS_PATH=/workspace/models \
    -e http_proxy=http://proxy.mi2rl.co:3128 \
    -e https_proxy=http://proxy.mi2rl.co:3128 \
    $DOCKER_IMAGE \
    python totalsegmentator/bin/TotalSegmentator.py $PARAMS