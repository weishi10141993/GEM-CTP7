# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7vx690tffg1927-2

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/evka/code/tamu_ctp7_v7/ip/edit_registers_v1_0.cache/wt [current_project]
set_property parent.project_path /home/evka/code/tamu_ctp7_v7/ip/edit_registers_v1_0.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_repo_paths {
  /home/evka/code/tamu_ctp7_v7/ip/registers_1.0
  /home/evka/code/tamu_ctp7_v7/ip/ipbus_interface
} [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
add_files -quiet /home/evka/code/tamu_ctp7_v7/ip/edit_registers_v1_0.runs/ila_axi_regs_synth_1/ila_axi_regs.dcp
set_property used_in_implementation false [get_files /home/evka/code/tamu_ctp7_v7/ip/edit_registers_v1_0.runs/ila_axi_regs_synth_1/ila_axi_regs.dcp]
read_vhdl -library xil_defaultlib {
  /home/evka/code/tamu_ctp7_v7/ip/registers_1.0/hdl/ipbus_pkg.vhd
  /home/evka/code/tamu_ctp7_v7/ip/registers_1.0/hdl/ipb_addr_decode.vhd
  /home/evka/code/tamu_ctp7_v7/ip/registers_1.0/hdl/registers_v1_0_AXI.vhd
  /home/evka/code/tamu_ctp7_v7/ip/registers_1.0/hdl/registers_v1_0.vhd
}
read_xdc /home/evka/code/tamu_ctp7_v7/ip/registers_1.0/src/constrs/registers.xdc
set_property used_in_implementation false [get_files /home/evka/code/tamu_ctp7_v7/ip/registers_1.0/src/constrs/registers.xdc]

synth_design -top registers_v1_0 -part xc7vx690tffg1927-2
write_checkpoint -noxdef registers_v1_0.dcp
catch { report_utilization -file registers_v1_0_utilization_synth.rpt -pb registers_v1_0_utilization_synth.pb }
