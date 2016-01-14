#
#
#  Default attributes file for RAC on Linux VM
#
#  Author - Gowrish Mallipattana
#
#

# Cluster Name
default ['clusterName'] = 'rac2'

# Host Names
default ['hostnameNode1'] = 'rac2n1'
default ['hostnameNode2'] = 'rac2n1'

# IP Addresses
# Public
default ['publicIpNode1'] = '192.168.0.111'
default ['publicIpNode2'] = '192.168.0.112'

# Virtual
default ['virtualIpNode1'] = '192.168.0.121'
default ['virtualIpNode2'] = '192.168.0.122'

# Private Interconnect
default ['privateIpNode1'] = '10.10.10.111'
default ['privateIpNode2'] = '10.10.10.112'

# SCAN
default ['scanIp1'] = '192.168.0.131'
default ['scanIp2'] = '192.168.0.132'
default ['scanIp3'] = '192.168.0.133'

# Hosts File
default ['hostsFile'] = '/etc/hosts'