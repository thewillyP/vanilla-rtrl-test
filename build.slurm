#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem=14G
#SBATCH --time=00:15:00
#SBATCH --job-name=build
#SBATCH --error=build.err
#SBATCH --output=build.log
#SBATCH --cpus-per-task=10
#SBATCH --mail-type=END
#SBATCH --mail-user=wlp9800@nyu.edu

USER=wlp9800
IMAGE=vanilla-rtrl
DOCKER_URL="docker://thewillyp/${IMAGE}:master-1.0.1@sha256:3482a169a2600d7182e838d05bf547d535e0d933bbeae2a24e321f46a6d78ac1"
OVERLAY_TYPE="overlay-15GB-500K.ext3"
SAVE_DIR="/scratch/${USER}/"


# Check if the file already exists
# https://sites.google.com/nyu.edu/nyu-hpc/hpc-systems/greene/software/singularity-with-miniconda?authuser=0
cp -rp /scratch/work/public/overlay-fs-ext3/${OVERLAY_TYPE}.gz "${SAVE_DIR}${IMAGE}.ext3.gz"
gunzip -f "${SAVE_DIR}${IMAGE}.ext3.gz"

singularity build --force /scratch/${USER}/images/${IMAGE}.sif ${DOCKER_URL} 
