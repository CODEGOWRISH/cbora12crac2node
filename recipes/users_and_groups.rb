#
#
# users_and_groups.rb
#
# Author :  Gowrish Mallipattana
# 

#  CAUTION - UNDERSTAND THIS CORRETLY AND REWRITE.  IT IS MESSING UP AND NOT REALLY SETTING THE PASSWORD TO WHAT WE WANTED
#
# Set password (for productionizing, this cannot be this simple!)
#
#  CAUTION - UNDERSTAND THIS CORRETLY AND REWRITE.  IT IS MESSING UP AND NOT REALLY SETTING THE PASSWORD TO WHAT WE WANTED
#
#user node[:gridUser] do
  ## User is already there in the 'racattack' box - just change the password
  #password node[:passwordString]
#end

dbUser=node[:dbUser]
groupToUse=node[:oinstallGroup]
passwordString=node[:passwordString]

# User equivalence - do on both nodes one after the other
bash 'set up ssh key' do
  user "#{dbUser}"
  group "#{groupToUse}"

  code <<-EOH

    thisHost=`hostname`
    homedir=`grep #{dbUser} /etc/passwd | cut -d: -f6`
    sshdir=${homedir}/.ssh

    cd $homedir
    mkdir -p .ssh

    ssh-keygen -t rsa -f $sshdir/id_rsa -q -P ""
    cd $sshdir
    cat id_rsa.pub >> authorized_keys

    if [ "$thisHost" == "#{node[:hostnameNode1]}" ]
    then

        echo sshpass -p "#{node[:passwordString]}" ssh -o StrictHostKeyChecking=no "#{dbUser}"@"#{node[:hostnameNode2]}" /bin/mkdir -p $sshdir > /home/oracle/run.mkdir
        sshpass -p "#{node[:passwordString]}" ssh -o StrictHostKeyChecking=no "#{dbUser}"@"#{node[:hostnameNode2]}" /bin/mkdir -p $sshdir > /home/oracle/out.mkdir 2>> /home/oracle/out.mkdir

        cd $sshdir
        echo sshpass -p "#{node[:passwordString]}" scp -r -o StrictHostKeyChecking=no -r authorized_keys "#{dbUser}"@"#{node[:hostnameNode2]}":${sshdir}/. > /home/oracle/run.scp
        sshpass -p "#{node[:passwordString]}" scp -r -o StrictHostKeyChecking=no -r authorized_keys "#{dbUser}"@"#{node[:hostnameNode2]}":${sshdir}/. > /home/oracle/out.scp 2>> /home/oracle/out.scp

    else

        cd $sshdir
        echo sshpass -p "#{node[:passwordString]}" scp -o StrictHostKeyChecking=no -r authorized_keys "#{dbUser}"@"#{node[:hostnameNode1]}":${sshdir}/. > /home/oracle/run.scp
        sshpass -p "#{node[:passwordString]}" scp -r -o StrictHostKeyChecking=no -r authorized_keys "#{dbUser}"@"#{node[:hostnameNode1]}":${sshdir}/. > /home/oracle/out.scp 2>> /home/oracle/out.scp

    fi

  EOH
end