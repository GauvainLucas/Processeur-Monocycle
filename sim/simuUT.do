
vlib work
vcom -93 ../src/unite_de_traitement.vhd
vcom -93 unite_de_traitement_tb.vhd

vsim unite_de_traitement_tb(bench)

view signals
view structure
add wave *
add wave -radix hexadecimal /unite_de_traitement_tb/UDT/banc_registre/Banc

run -all