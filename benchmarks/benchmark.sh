#set -euo pipefail

prog=$1
output_file=$2

already_written=$(wc -l < $output_file)
counter=0
printf "Skipping %d first steps\n" "$already_written"

# using a greater backup step than the total number of steps to
# prevent gzip compression from poisoning the benchmark
n_steps=1000
backup_step=1001

for iteration in $(seq 10); do
    for n_threads in 8 6 4 2 1; do
        for dna_size in 500 5000 50000; do
            for grid_size in 32 128 256 512; do
                for mutation_rate in 0.0001 0.00001 0.000001; do
                    if [[ "$counter" -ge "$already_written" ]]; then
                        printf "Counter : %s\n" "$counter" 1>&2
                        export OMP_NUM_THREADS=${n_threads} && $prog -n "$n_steps" -b "$backup_step" -w "$grid_size" -h "$grid_size" -g "$dna_size" -m "$mutation_rate" >> "$output_file"
                    else
                        printf "Counter : %s (skipping)\n" "$counter" 1>&2
                    fi
                    ((counter++))
                done
            done
        done
    done
done
