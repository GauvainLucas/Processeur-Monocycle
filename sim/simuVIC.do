vlib work
vcom -93 ../src/vic.vhd
vcom -93 vic_tb.vhd

vsim vic_tb(bench)

view signals
view structure
add wave *

run -all