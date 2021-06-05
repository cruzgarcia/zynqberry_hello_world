# Run it by typing
#   $ xsct <script name>.tcl

# Creating a Vitis project
puts "Starting scripts"
set script [info script] 
set script_dir [file normalize [file dirname $script]]
set workspace_dir [file normalize $script_dir/workspace]
set platform_name "hello_world_platform"
set project_name "hello_world"
puts "Project: $project_name"

# Change path to workspace and point Vitis to it
set popd [pwd]
cd $workspace_dir
setws -switch $workspace_dir

# Create a platform project 
set xsa_filepath "[file normalize "$script_dir/vivado/$project_name.xsa"]"
platform create -name "$platform_name" -hw $xsa_filepath
platform active "$platform_name"
# Create a domain
domain create -name a9_standalone -os standalone -proc {ps7_cortexa9_0}
# Generate a platform
platform generate
# Create an application
app create -name app1 -platform "$platform_name" -domain a9_standalone -template {Hello World}
app build -name app1

puts "DONE"
