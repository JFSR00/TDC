# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param synth.incrementalSynthesisCache C:/Users/JFSR00/AppData/Roaming/Xilinx/Vivado/.Xil/Vivado-20076-JFSR00-RAIDERPC/incrSyn
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/JFSR00/Vivado/Project_10/Project_10.cache/wt [current_project]
set_property parent.project_path C:/Users/JFSR00/Vivado/Project_10/Project_10.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo c:/Users/JFSR00/Vivado/Project_10/Project_10.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/JFSR00/Vivado/Project_10/Project_10.srcs/sources_1/new/combinational_components.vhd
  C:/Users/JFSR00/Vivado/Project_10/Project_10.srcs/sources_1/imports/Vivado/Project_01/Project_01.srcs/sources_1/new/AND_GATE.vhd
  C:/Users/JFSR00/Vivado/Project_10/Project_10.srcs/sources_1/imports/Vivado/Project_6/Project_6.srcs/sources_1/new/FULL_ADDER.vhd
  C:/Users/JFSR00/Vivado/Project_10/Project_10.srcs/sources_1/imports/Vivado/Project_7/Project_7.srcs/sources_1/new/MUX4.vhd
  C:/Users/JFSR00/Vivado/Project_10/Project_10.srcs/sources_1/imports/Vivado/Project_03/Project_03.srcs/sources_1/new/XOR_GATE.vhd
  C:/Users/JFSR00/Vivado/Project_10/Project_10.srcs/sources_1/new/ALU_1bit.vhd
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top ALU_1bit -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef ALU_1bit.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file ALU_1bit_utilization_synth.rpt -pb ALU_1bit_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]