#!/bin/bash

task=ali
f_event=event.txt
f_time=time.txt

DATA_ROOT=$HOME/Research/NeuralPointProcess/data/real/$task
RESULT_ROOT=$HOME/scratch/results/NeuralPointProcess

n_embed=64
H=64
bsize=64
bptt=3
learning_rate=0.001
max_iter=4000000
cur_iter=0
test_pct=0.5
T=0
w_scale=0.01
mode=CPU
net=event
heldout_eval=1
save_dir=$RESULT_ROOT/$net-$task-hidden-$H-embed-$n_embed-bptt-$bptt-bsize-$bsize

if [ ! -e $save_dir ];
then
    mkdir -p $save_dir
fi

dev_id=0

./build/main \
    -heldout $heldout_eval \
    -test_pct $test_pct \
    -event $DATA_ROOT/$f_event \
    -time $DATA_ROOT/$f_time \
    -lr $learning_rate \
    -device $dev_id \
    -maxe $max_iter \
    -svdir $save_dir \
    -hidden $H \
    -embed $n_embed \
    -save_eval 0 \
    -save_test 1 \
    -T $T \
    -m 0.9 \
    -b $bsize \
    -w_scale $w_scale \
    -int_report 500 \
    -int_test 2500 \
    -int_save 2500 \
    -bptt $bptt \
    -cur_iter $cur_iter \
    -mode $mode \
    -net $net \
    2>&1 | tee $save_dir/log.txt
