#!/bin/bash
#SBATCH --job-name=RTX80004GPU
#SBATCH --partition=rtx8000
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:4
#SBATCH --output=%x.result
#SBATCH --mem=96GB
#SBATCH --time=00:90:00

module load python/intel/3.8.6
module load anaconda3/2020.07
module load cuda/11.6.2
module load cudnn/8.6.0.163-cuda11

/scratch/kv2154/HPML-PokeGans-main/
eval "$(conda shell.bash hook)"
conda activate ../../env/

python3 -m pip install torch

timeout 900 nvidia-smi --query-gpu=memory.total,memory.used,utilization.gpu,gpu_name,gpu_bus_id --format=csv -l 1 > results-file.csv & 

python3 pokegan.py