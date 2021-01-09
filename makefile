setup_cpu:
	cmake -S . -B build -DUSE_OMP=1 -DCMAKE_BUILD_TYPE=Release
	mkdir -p experiments/sim_0

build_cpu: setup_cpu
	cmake --build build

run_cpu: build_cpu
	cd experiments/sim_0 && ../../build/micro_aevol_cpu -h 64 -w 64

clean:
	rm -rf build

benchmark_cpu: build_cpu
	bash benchmarks/benchmark.sh ./build/micro_aevol_cpu

test:
	echo "TODO"

profile_cpu: build_cpu
	cd experiments/sim_0 && perf record -o - -g -- ../../build/micro_aevol_cpu -h 128 -w 128 | perf script | c++filt | gprof2dot -f perf | dot -Tpdf -o profile.pdf
