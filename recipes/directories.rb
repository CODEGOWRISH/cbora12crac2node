#
#   Creates necessary directories for RAC install
#
# TBD - create a erb file to generate a shell script, create that shell in node1, 
#       execute it in node1 and  with ssh in node2 in two steps here

# Node1
directory node[:oraAppBase][:dirName] do
  owner node[:oraAppBase][:dirOwner]
  group node[:oraAppBase][:dirGroup]
  mode  node[:oraAppBase][:dirPerm]
  action :create
end

directory node[:oraInventory][:dirName] do
  owner node[:oraInventory][:dirOwner]
  group node[:oraInventory][:dirGroup]
  mode  node[:oraInventory][:dirPerm]
  action :create
end

directory node[:gridHome][:dirName] do
  owner node[:gridHome][:dirOwner]
  group node[:gridHome][:dirGroup]
  mode  node[:gridHome][:dirPerm]
  action :create
end

directory node[:gridBase][:dirName] do
  owner node[:gridBase][:dirOwner]
  group node[:gridBase][:dirGroup]
  mode  node[:gridBase][:dirPerm]
  action :create
end

