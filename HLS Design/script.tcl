############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
############################################################
open_project LSTM_MSSP2_vitis
set_top Controller
add_files LSTM_MSSP2/Controller7.h
add_files LSTM_MSSP2_vitis/LSTM8.cpp
add_files LSTM_MSSP2/bias.h
add_files LSTM_MSSP2/cellw.h
add_files LSTM_MSSP2/fcW.h
add_files LSTM_MSSP2/forw.h
add_files LSTM_MSSP2/inRe.h
add_files LSTM_MSSP2/inputsLSTM.h
add_files LSTM_MSSP2/inputsLSTM2.h
add_files LSTM_MSSP2/inw.h
add_files LSTM_MSSP2/outw.h
add_files -tb LSTM_MSSP2_vitis/TestBench.cpp -cflags "-Wno-unknown-pragmas" -csimflags "-Wno-unknown-pragmas"
open_solution "solution1_new5_u55c" -flow_target vivado
set_part {xcu55c-fsvh2892-2L-e}
create_clock -period 2.5 -name default
config_export -format ip_catalog -rtl verilog -vivado_clock 4 -vivado_phys_opt all
set_clock_uncertainty 12.5%
source "./LSTM_MSSP2_vitis/solution1_new5_u55c/directives.tcl"
csim_design
csynth_design
cosim_design
export_design -rtl verilog -format ip_catalog
