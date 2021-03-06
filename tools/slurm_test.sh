set -x

PARTITION=$1
JOB_NAME=$2
CONFIG=$3
CHECKPOINT=$4
GPUS=${GPUS:-1}
GPUS_PER_NODE=$GPUS
CPUS_PER_TASK=$GPUS
PY_ARGS=${@:5}
SRUN_ARGS=${SRUN_ARGS:-""}

srun -p ${PARTITION} \
    --job-name=${JOB_NAME} \
    --gres=gpu:${GPUS_PER_NODE} \
    --ntasks=${GPUS} \
    --ntasks-per-node=${GPUS_PER_NODE} \
    --cpus-per-task=${CPUS_PER_TASK} \
    --kill-on-bad-exit=1 \
    ${SRUN_ARGS} \
    python -u tools/slurm_test.py ${CONFIG} ${CHECKPOINT} --launcher="slurm" ${PY_ARGS}
