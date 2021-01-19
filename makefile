.PHONY: run_cpu run_gpu

setup_global:
	mkdir -p experiments/sim_0

setup_gpu: setup_global
	cmake -S . -B build -DUSE_CUDA=1 -DCMAKE_BUILD_TYPE=Release

setup_cpu: setup_global
	cmake -S . -B build -DUSE_OMP=1 -DCMAKE_BUILD_TYPE=Release

build_cpu: setup_cpu
	cmake --build build

build_gpu: setup_gpu
	cmake --build build

run_cpu: build_cpu
	cd experiments/sim_0 && ../../build/micro_aevol_cpu -h 64 -w 64

run_gpu: build_gpu
	cd experiments/sim_0 && ../../build/micro_aevol_gpu -h 32 -w 32 -n 1000 -b 1001

clean:
	rm -rf build

benchmark_cpu: build_cpu
	bash benchmarks/benchmark.sh ./build/micro_aevol_cpu

benchmark_gpu: build_gpu
	./build/micro_aevol_gpu

test:
	echo "TODO"

profile_cpu: build_cpu
	cd experiments/sim_0 && perf record -o - -g -- ../../build/micro_aevol_cpu -h 128 -w 128 | perf script | c++filt | gprof2dot -f perf | dot -Tpdf -o profile.pdf
