
vlib work
vcom -93 ../src/processeur.vhd
vcom -93 ../src/banc_registre.vhd
vcom -93 ../src/data_memory.vhd
vcom -93 ../src/decod_instruction.vhd
vcom -93 ../src/memoire_instruction.vhd
vcom -93 ../src/mux2v1.vhd
vcom -93 ../src/registreAfficheur.vhd
vcom -93 ../src/registrePC.vhd
vcom -93 ../src/registrePSR.vhd
vcom -93 ../src/sign_extend.vhd
vcom -93 ../src/ual.vhd
vcom -93 ../src/unite_de_gestion_des_instructions.vhd
vcom -93 ../src/unite_de_traitement_avance.vhd
vcom -93 processeur_tb.vhd


vsim processeur_tb(bench)

view signals
view structure
add wave *
add wave /processeur_tb/processeur/decodeur/instr_courante
add wave -radix hexadecimal /processeur_tb/processeur/UTA/banc_registre/Banc
add wave -radix hexadecimal /processeur_tb/processeur/*
add wave -radix hexadecimal /processeur_tb/processeur/UTA/DataMemory/Banc
add wave /processeur_tb/processeur/UTA/B
add wave -radix hexadecimal /processeur_tb/processeur/UGI/sPlus

run -all