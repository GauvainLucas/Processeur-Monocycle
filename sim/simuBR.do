
vlib work
vcom -93 ../src/banc_registre.vhd
vcom -93 banc_registre_tb.vhd

vsim banc_registre_tb(TEST)

view signals
add wave *

run -all