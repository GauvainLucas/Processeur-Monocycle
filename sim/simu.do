
vlib work
vcom -93 ../src/ual.vhd
vcom -93 ual_tb.vhd

vsim tb_ual(TEST)

view signals
add wave *

run -all