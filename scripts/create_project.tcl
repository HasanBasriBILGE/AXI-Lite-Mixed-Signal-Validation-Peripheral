#!/usr/bin/tclsh
# scripts/create_project.tcl - Essential project creation script

# ============================================================================
# PROJECT CONFIGURATION - EDIT THESE VALUES FOR YOUR PROJECT
# ============================================================================

# Set the project name
set project_name "AXI-Lite-MultiFunctionalPeripheral"
set part "xc7z020clg484-1"
set board_part "digilentinc.com:eclypse-z7:part0:1.1"
set target_language "Verilog"
# set top_module "top_level"

# ============================================================================
# AUTOMATIC SETUP - DON'T EDIT BELOW UNLESS YOU KNOW WHAT YOU'RE DOING
# ============================================================================

# Use project name variable, if specified in the tcl shell
if { [info exists ::user_project_name] } {
  set project_name $::user_project_name
}

# Get script directory
set script_dir [file normalize [file dirname [info script]]]
set project_root [file dirname $script_dir]
set project_dir [file join $project_root $project_name]

puts "=== CREATING VIVADO PROJECT ==="
puts "Project: $project_name"
puts "Part: $part"
puts "Language: $target_language"
puts "Root directory: $project_root"

# Create project
create_project ${project_name} ${project_dir} -part xc7z020clg484-1


# Set project properties
set obj [current_project]
if {$board_part ne ""} {
  set_property -name "board_part" -value ${board_part} -objects $obj
}
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "target_language" -value ${target_language} -objects $obj
set_property -name "tool_flow" -value "Vivado" -objects $obj

# Define relative paths from script directory
set src_dir [file join $project_root src]
set sim_dir [file join $project_root tb]
set constraints_dir [file join $project_root constraints]

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Add source files
if {[file exists ${src_dir}]} {
    set src_files [glob -nocomplain ${src_dir}/*.vhd ${src_dir}/*.v ${src_dir}/*.sv]
    if {[llength $src_files] > 0} { 
        add_files -norecurse $src_files
    }
}

# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Add constraints
if {[file exists ${constraints_dir}]} {
     set xdc_files [glob -nocomplain ${constraints_dir}/*.xdc]
     if {[llength $xdc_files] > 0} {
         add_files -fileset constrs_1 -norecurse $xdc_files
     }
}

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Add simulation files
if {[file exists ${sim_dir}]} {
    set sim_files [glob -nocomplain ${sim_dir}/*.vhd ${sim_dir}/*.v ${sim_dir}/*.sv]
    if {[llength $sim_files] > 0} {
        add_files -fileset sim_1 -norecurse $sim_files
    }
}

# Update compile order
update_compile_order -fileset sources_1
catch {update_compile_order -fileset sim_1}


puts "\n✅ PROJECT CREATED SUCCESSFULLY!"
puts "Project location: $project_dir"
puts "Next steps:"
puts "1. Add your HDL files to src/"
puts "2. Add your simulation files to simulation/"
puts "3. Add your constraints to constraints/"
puts "4. Add your constraints to constraints/"
