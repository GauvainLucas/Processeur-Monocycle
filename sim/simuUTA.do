
vlib work
vcom -93 ../src/unite_de_traitement_avance.vhd
vcom -93 ../src/banc_registre.vhd
vcom -93 ../src/sign_extend.vhd
vcom -93 ../src/mux2v1.vhd
vcom -93 ../src/ual.vhd
vcom -93 ../src/data_memory.vhd
vcom -93 unite_de_traitement_avance_tb.vhd

vsim unite_de_traitement_avance_tb(bench)

view signals
view structure
add wave *

run -all