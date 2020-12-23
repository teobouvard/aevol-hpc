set -euo pipefail

prog=$1

for iteration in $(seq 5); do
    for n_threads in 1 2 4 6 8; do
        for dna_size in 500 5000 50000; do
            for grid_size in 32 128 256 512; do
                for mutation_rate in 0.0001 0.00001 0.000001; do
                    export OMP_NUM_THREADS=${n_threads} && $prog -w "$grid_size" -h "$grid_size" -g "$dna_size" -m "$mutation_rate"
                done
            done
        done
    done
done
