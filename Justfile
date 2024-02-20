
default: build

init:
	rm .west -fR
	west init -l $(pwd)/config
	west update
	west zephyr-export

[private]
build_dir:
	rm -fR build
	mkdir -p build

build_reset: init build_dir
	west build -s zmk/app -d $(pwd)/build -b seeeduino_xiao_ble -- -DZMK_CONFIG=$(pwd)/config -DSHIELD=settings_reset
	cp build/zephyr/zmk.uf2 settings_reset.uf2

build_left: init build_dir
	west build -s zmk/app -d $(pwd)/build -b seeeduino_xiao_ble -- -DZMK_CONFIG=$(pwd)/config -DSHIELD=mnhttn_left
	cp build/zephyr/zmk.uf2 mnhttn_left.uf2

build_right: init build_dir
	west build -s zmk/app -d $(pwd)/build -b seeeduino_xiao_ble -- -DZMK_CONFIG=$(pwd)/config -DSHIELD=mnhttn_left
	cp build/zephyr/zmk.uf2 mnhttn_right.uf2

build: build_left build_right build_reset



