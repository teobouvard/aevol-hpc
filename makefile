gen:
	cmake -S . -B build -DUSE_OMP=1 -DCMAKE_BUILD_TYPE=Debug

build: gen
	cmake --build build

run: build
	cd experiments/sim_0 && ../../build/micro_aevol_cpu -h 64 -w 64

clean:
	rm -rf build

test:
	echo "TODO"

profile-cpu: build
	cd experiments/sim_0 && perf record -o - -g -- ../../build/micro_aevol_cpu -h 128 -w 128 | perf script | c++filt | gprof2dot -f perf | dot -Tsvg -o profile.svg