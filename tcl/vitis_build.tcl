# Run it by typing
#   $ xsct <script name>.tcl

# Source project globals
source project_defs.tcl

# Check if the workspace folder exists
cd ..
if {[file exist $vitis_workspace]} {
  puts "$vitis_workspace exists, clean project first"
  exit 2
} else {
    file mkdir $vitis_workspace
}

# Creating a Vitis project
puts "Starting scripts"
set script [info script] 
set script_dir [file normalize [file dirname $script]]
set workspace_dir [file normalize $script_dir/$vitis_workspace]
set platform_name "hello_world_platform"
puts "Project: $project_name"

# Change path to workspace and point Vitis to it
set popd [pwd]
cd $workspace_dir
setws -switch $workspace_dir

# Create a platform project 
set xsa_filepath "[file normalize "../$vivado_folder/$project_name.xsa"]"
platform create -name "$platform_name" -hw $xsa_filepath
platform active "$platform_name"
# Create a domain
domain create -name a9_standalone -os standalone -proc {ps7_cortexa9_0}
# Generate a platform
platform generate
# Create an application
app create -name app1 -platform "$platform_name" -domain a9_standalone -template {Hello World}
app build -name app1
