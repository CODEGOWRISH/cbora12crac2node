#
#
#   prepare_asm_disks.rb
#
#   Formats disks using 'sfdisk'
#   Creates ASM disks using oracleasm
#
#

# Create the template file to use for sfdisk command
template node[:sfdisk2gb_format_file] do
  source node[:sfdisk2gb_format_template]
end

# Format 2gb disks
# TBD - add checks to see if these disks are already formatted, and do only if not
# TBD - make an array of disks, their sizes and sfdisk tempalte erb files in attributes file, and loop through
formatFile = node[:sfdisk2gb_format_file]

diskDev=node[:diskDev1]
execute 'sfdisk 1' do
  user "root"
  command "sfdisk #{diskDev} < #{formatFile}"
end

diskDev=node[:diskDev2]
execute 'sfdisk 2' do
  user "root"
  command "sfdisk #{diskDev} < #{formatFile}"
end

diskDev=node[:diskDev3]
execute 'sfdisk 3' do
  user "root"
  command "sfdisk #{diskDev} < #{formatFile}"
end

# Creae ASM disks
