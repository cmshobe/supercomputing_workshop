#! /bin/sh

## This script runs a batch of 3 my_model runs.

#PBS -t 1-3
#PBS -N modelsim1to3
#PBS -e modelsim1to3.err
#PBS -o modelsim1to3.out

## Send email when the job is aborted, started, or stopped
#PBS -m abe

## Send email here
#PBS -M charles.shobe@colorado.edu

INPUT_DIR=/home/chsh5846/supercomputing_tutorial/

OUTPUT_DIR=/home/chsh5846/supercomputing_tutorial/

SIM_NO=${PBS_ARRAYID}

SIM_DIR=modelsim${SIM_NO}

INPUT_FILES=${INPUT_DIR}/sim${SIM_NO}

OUTPUT_FILES=${OUTPUT_DIR}/sim${SIM_NO}

MODEL_NAME=/home/chsh5846/supercomputing_tutorial/sim${SIM_NO}/model_sim${SIM_NO}.py

setup()
{
echo "Running Simulation ${SIM_NO}"
echo "Transferring input to compute node..."
echo "${INPUT_FILES} -> ${SIM_DIR}"

cd ${TMPDIR} && \
mkdir -p ${SIM_DIR} && \
cp ${INPUT_FILES}/* ${SIM_DIR}
}

run()
{
echo "Running model in ${SIM_DIR} on Beach node ${PBS_NODENUM}..."

cd ${SIM_DIR} && \
python ${MODEL_NAME}
}

teardown()
{
echo "Transferring output to ${OUTPUT_FILES} and cleaning up..."

mkdir -p ${OUTPUT_DIR} && \
cd ${TMPDIR} && \
tar --create --gzip --file ${OUTPUT_FILES}/${SIM_DIR}.tar.gz ${SIM_DIR} && \
rm -r ${SIM_DIR}

echo "Teardown complete. Simulation complete."
}


setup
run
teardown