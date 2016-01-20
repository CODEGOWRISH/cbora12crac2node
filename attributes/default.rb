#
#
#  Default attributes file for RAC on Linux VM
#
#  Author - Gowrish Mallipattana
#
#

# Users and Groups
default['gridUser'] = 'oracle'
default['dbUser']   = 'oracle'
default['oinstallGroup']  = 'oinstall'
default['osdbaGroup']     = 'dba'
default['asmadminGroup']  = 'dba'
default['asmdbaGroup']    = 'dba'
default['passwordString'] = 'oracle'
default['rootPassword']   = 'root'

# Cluster Name
default['clusterName'] = 'rac2'

# Host Names
default['hostnameNode1'] = 'rac2n1'
default['hostnameNode2'] = 'rac2n2'

# IP Addresses
# Public
default['publicIpNode1'] = '192.168.0.111'
default['publicIpNode2'] = '192.168.0.112'

# Virtual
default['virtualIpNode1'] = '192.168.0.121'
default['virtualIpNode2'] = '192.168.0.122'

# Private Interconnect
default['privateIpNode1'] = '10.10.10.111'
default['privateIpNode2'] = '10.10.10.112'

# SCAN
default['scanIp1'] = '192.168.0.131'
default['scanIp2'] = '192.168.0.132'
default['scanIp3'] = '192.168.0.133'

# Hosts File
default['hostsFile'] = '/etc/hosts'

# Disks
default['diskDev1'] = '/dev/sdc'
default['diskDev2'] = '/dev/sdd'
default['diskDev3'] = '/dev/sde'

default['sfdisk2gb_format_file']      = '/tmp/sfdisk_2gb.format'
default['sfdisk2gb_format_template']  = 'sfdisk_2gb.erb'