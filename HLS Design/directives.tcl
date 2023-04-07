############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
############################################################
set_directive_interface -mode s_axilite -bundle bus_bundle "Controller"
set_directive_interface -mode bram -storage_type rom_1p "Controller" param_stream1
set_directive_interface -mode bram -storage_type rom_1p "Controller" param_stream2
set_directive_interface -mode bram -storage_type rom_1p "Controller" param_stream3
set_directive_interface -mode bram -storage_type rom_1p "Controller" param_stream4
set_directive_interface -mode bram -storage_type ram_1p "Controller" out_stream
set_directive_interface -mode s_axilite -bundle bus_bundle "Controller" new_net
set_directive_array_partition -type complete -dim 1 "Controller" cellState
set_directive_array_partition -type complete -dim 1 "Controller" cellStateNext
set_directive_array_partition -type complete -dim 1 "Controller" cellState1
set_directive_array_partition -type complete -dim 1 "Controller" cellStateNext1
set_directive_array_partition -type complete -dim 1 "Controller" cellState2
set_directive_array_partition -type complete -dim 1 "Controller" cellStateNext2
set_directive_array_partition -type complete -dim 1 "Controller" hiddenStateTemp1
set_directive_array_partition -type complete -dim 1 "Controller" hiddenStateTemp2
set_directive_array_partition -type complete -dim 1 "Controller" hiddenStateTemp3
set_directive_array_partition -type complete -dim 1 "Controller" cellStateTemp1
set_directive_array_partition -type complete -dim 1 "Controller" cellStateTemp2
set_directive_array_partition -type complete -dim 1 "Controller" cellStateTemp1_1
set_directive_array_partition -type complete -dim 1 "Controller" cellStateTemp2_1
set_directive_array_partition -type complete -dim 1 "Controller" cellStateTemp1_2
set_directive_array_partition -type complete -dim 1 "Controller" cellStateTemp2_2
set_directive_array_partition -type complete -dim 1 "Controller" hiddenStateF
set_directive_array_partition -type complete -dim 1 "Controller" hiddenStateI
set_directive_array_partition -type complete -dim 1 "Controller" hiddenStateC
set_directive_array_partition -type complete -dim 1 "Controller" hiddenStateO
set_directive_array_partition -type complete -dim 1 "Controller" hiddenStateF1
set_directive_array_partition -type complete -dim 1 "Controller" hiddenStateI1
set_directive_array_partition -type complete -dim 1 "Controller" hiddenStateC1
set_directive_array_partition -type complete -dim 1 "Controller" hiddenStateO1
set_directive_array_partition -type complete -dim 1 "Controller" hiddenStateF2
set_directive_array_partition -type complete -dim 1 "Controller" hiddenStateI2
set_directive_array_partition -type complete -dim 1 "Controller" hiddenStateC2
set_directive_array_partition -type complete -dim 1 "Controller" hiddenStateO2
set_directive_array_partition -type complete -dim 1 "Controller" weights
set_directive_bind_storage -type ram_2p "Controller" forgetReWeight
set_directive_bind_storage -type ram_2p "Controller" inputReWeight
set_directive_bind_storage -type ram_2p "Controller" cellReWeight
set_directive_bind_storage -type ram_2p "Controller" outputReWeight
set_directive_bind_storage -type ram_2p "Controller" forgetReWeight1
set_directive_bind_storage -type ram_2p "Controller" inputReWeight1
set_directive_bind_storage -type ram_2p "Controller" cellReWeight1
set_directive_bind_storage -type ram_2p "Controller" outputReWeight1
set_directive_bind_storage -type ram_2p "Controller" forgetReWeight2
set_directive_bind_storage -type ram_2p "Controller" inputReWeight2
set_directive_bind_storage -type ram_2p "Controller" cellReWeight2
set_directive_bind_storage -type ram_2p "Controller" outputReWeight2
set_directive_array_partition -type cyclic -factor 1 -dim 1 "Controller" forgetReWeight
set_directive_array_partition -type cyclic -factor 1 -dim 1 "Controller" inputReWeight
set_directive_array_partition -type cyclic -factor 1 -dim 1 "Controller" cellReWeight
set_directive_array_partition -type cyclic -factor 1 -dim 1 "Controller" outputReWeight
set_directive_array_partition -type cyclic -factor 1 -dim 1 "Controller" forgetReWeight1
set_directive_array_partition -type cyclic -factor 1 -dim 1 "Controller" inputReWeight1
set_directive_array_partition -type cyclic -factor 1 -dim 1 "Controller" cellReWeight1
set_directive_array_partition -type cyclic -factor 1 -dim 1 "Controller" outputReWeight1
set_directive_array_partition -type cyclic -factor 1 -dim 1 "Controller" forgetReWeight2
set_directive_array_partition -type cyclic -factor 1 -dim 1 "Controller" inputReWeight2
set_directive_array_partition -type cyclic -factor 1 -dim 1 "Controller" cellReWeight2
set_directive_array_partition -type cyclic -factor 1 -dim 1 "Controller" outputReWeight2
set_directive_array_partition -type complete -dim 1 "Controller" forgetBias
set_directive_array_partition -type complete -dim 1 "Controller" inputBias
set_directive_array_partition -type complete -dim 1 "Controller" cellBias
set_directive_array_partition -type complete -dim 1 "Controller" outputBias
set_directive_array_partition -type complete -dim 1 "Controller" forgetBias1
set_directive_array_partition -type complete -dim 1 "Controller" cellBias1
set_directive_array_partition -type complete -dim 1 "Controller" inputBias1
set_directive_array_partition -type complete -dim 1 "Controller" outputBias1
set_directive_array_partition -type complete -dim 1 "Controller" forgetBias2
set_directive_array_partition -type complete -dim 1 "Controller" inputBias2
set_directive_array_partition -type complete -dim 1 "Controller" cellBias2
set_directive_array_partition -type complete -dim 1 "Controller" outputBias2
set_directive_array_partition -type complete -dim 1 "Controller" finalOut
set_directive_array_partition -type complete -dim 1 "Controller" forget1
set_directive_array_partition -type complete -dim 1 "Controller" input1
set_directive_array_partition -type complete -dim 1 "Controller" cell1
set_directive_array_partition -type complete -dim 1 "Controller" output1
set_directive_array_partition -type complete -dim 1 "Controller" forget2
set_directive_array_partition -type complete -dim 1 "Controller" input2
set_directive_array_partition -type complete -dim 1 "Controller" output2
set_directive_array_partition -type complete -dim 1 "Controller" cell2
set_directive_pipeline "Controller/StoreInput1"
set_directive_pipeline "Controller/WEIGHTS"
set_directive_pipeline "Controller/setBias1"
set_directive_pipeline "Controller/setBias2"
set_directive_pipeline "Controller/setBias3"
set_directive_pipeline "Controller/setBias4"
set_directive_pipeline "Controller/SetReWeights1"
set_directive_pipeline "Controller/SetReWeights2"
set_directive_pipeline "Controller/SetReWeights3"
set_directive_pipeline "Controller/SetReWeights4"
set_directive_pipeline "Controller/SetReWeights5"
set_directive_pipeline "Controller/SetReWeights6"
set_directive_pipeline "Controller/SetReWeights7"
set_directive_pipeline "Controller/SetReWeights8"
set_directive_pipeline "Controller/SetReWeights9"
set_directive_pipeline "Controller/SetReWeights10"
set_directive_pipeline "Controller/SetReWeights11"
set_directive_pipeline "Controller/SetReWeight12"
set_directive_pipeline "Controller/cellCandidate"
set_directive_pipeline "Controller/cellStatusNew"
set_directive_pipeline "Controller/hiddenStatus"
set_directive_pipeline "Controller/StoreInput2"
set_directive_pipeline "Controller/nextState1"
set_directive_pipeline "Controller/cellCandidate2"
set_directive_pipeline "Controller/cellStatusNew2"
set_directive_pipeline "Controller/hiddenStatus2"
set_directive_pipeline "Controller/StoreInput3"
set_directive_pipeline "Controller/nextState2"
set_directive_pipeline "Controller/cellCandidate3"
set_directive_pipeline "Controller/cellStatusNew3"
set_directive_pipeline "Controller/hiddenStatus3"
set_directive_pipeline "Controller/outStatus"
set_directive_pipeline "Controller/result"
set_directive_pipeline "Controller/nextState3"
set_directive_array_partition -type complete -dim 1 "forgetGate" sum2
set_directive_array_partition -type complete -dim 1 "forgetGate" inMul2
set_directive_pipeline "forgetGate/hiddenLayerf"
set_directive_unroll "forgetGate/hiddenMultf"
set_directive_unroll "forgetGate/hiddenAccumf"
set_directive_pipeline "forgetGate/finalf"
set_directive_array_partition -type complete -dim 1 "inputGate" sum4
set_directive_array_partition -type complete -dim 1 "inputGate" inMul4
set_directive_unroll "inputGate/hiddenMulti"
set_directive_pipeline "inputGate/hiddenLayeri"
set_directive_unroll "inputGate/hiddenAccumi"
set_directive_pipeline "inputGate/finali"
set_directive_array_partition -type complete -dim 1 "cellGate" sum6
set_directive_array_partition -type complete -dim 1 "cellGate" inMul6
set_directive_unroll "cellGate/hiddenMultc"
set_directive_unroll "cellGate/hiddenAccumc"
set_directive_pipeline "cellGate/hiddenLayerc"
set_directive_pipeline "cellGate/finalc"
set_directive_array_partition -type complete -dim 1 "outputGate" sum8
set_directive_array_partition -type complete -dim 1 "outputGate" inMul8
set_directive_pipeline "outputGate/hiddenLayero"
set_directive_unroll "outputGate/hiddenMulto"
set_directive_unroll "outputGate/hiddenAccumo"
set_directive_pipeline "outputGate/finalo"
set_directive_interface -mode bram -storage_type ram_1p "Controller" in_stream
set_directive_top -name Controller "Controller"
