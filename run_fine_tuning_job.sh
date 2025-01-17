#!/bin/bash

# Example usage:
# sbatch run_fine_tuning_job.sh

#SBATCH --job-name="fine_tuning_job"

#SBATCH -N 1                         # number of minimum nodes
#SBATCH --gres=gpu:8                 # Request n gpus

#SBATCH -p nlp
#SBATCH -A nlp

#SBATCH -o eval_runs/slurm_%N_%j_out.txt       # stdout goes here
#SBATCH -e eval_runs/slurm_%N_%j_err.txt       # stderr goes here
#SBATCH --mail-type=fail         # send email if job fails

# To send you an email on failure, add 'SBATCH --mail-user=<your_mail>'

nvidia-smi
accelerate launch fine_tune_t5.py \
--model_name_or_path t5-base \
--dataset_name rte \
--num_train_epochs 50 \
--warmup_ratio 0.1 \
--learning_rate 5e-4 \
--early_stopping_patience 100 \
--early_stopping_threshold 0.001 \
--eval_steps 200 \
--save_steps 1_000 \
--logging_steps 50 \
--training_accumulation_steps 4

