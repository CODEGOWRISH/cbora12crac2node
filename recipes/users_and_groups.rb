#
#
# users_and_groups.rb
#
# Author :  Gowrish Mallipattana
# 

# Set password (for productionizing, this cannot be this simple!)
user node[:gridUser] do
  # User is already there in the 'racattack' box - just change the password
  password node[:passwordString]
end

dbUser=node[:dbUser]
password=node[:passwordString]

# User equivalence - do on both nodes one after the other
bash 'set up ssh key' do
  user "#{dbUser}"
  code <<-EOH
    homedir=`grep #{dbUser} /etc/passwd | cut -d: -f6`
    cd $homedir
    sshdir=${homedir}/.ssh
    mkdir -p .ssh
    ssh-keygen -t rsa -f $sshdir/id_rsa -q -P ""
    cd $sshdir
    cat id_rsa.pub >> authorized_keys

    thisHost=`hostname`

    if [ "$thisHost" == "#{node[:hostnameNode1]}" ]
    then

        cd $sshdir
        echo sshpass -p "#{node[:passwordString]}" scp -o StrictHostKeyChecking=no -r authorized_keys "#{dbUser}@#{node[:hostnameNode2]}":${sshdir}/. > /home/oracle/test
        sshpass -p "#{node[:passwordString]}" scp -r -o StrictHostKeyChecking=no -r authorized_keys "#{dbUser}@#{node[:hostnameNode2]}":${sshdir}/.
    else

        cd $sshdir
        echo sshpass -p "#{node[:passwordString]}" scp -o StrictHostKeyChecking=no -r authorized_keys "#{dbUser}@#{node[:hostnameNode1]}":${sshdir}/. > /home/oracle/test
        sshpass -p "#{node[:passwordString]}" scp -o StrictHostKeyChecking=no -r authorized_keys "#{dbUser}@#{node[:hostnameNode1]}":${sshdir}/.
    fi

  EOH
end

bash 'Copy authorized_keys file' do
  user "#{dbUser}"
  code <<-EOH
    homedir=`grep #{dbUser} /etc/passwd | cut -d: -f6`
    cd $homedir
    sshdir=${homedir}/.ssh
    cd $sshdir

    echo sshpass -p "#{node[:passwordString]}" scp -r authorized_keys "#{node[:hostnameNode1]}":${sshdir}/. > $homedir/test
    echo sshpass -p "#{node[:passwordString]}" scp -r authorized_keys "#{node[:hostnameNode2]}":${sshdir}/. >> $homedir/test


    #sshpass -p "#{node[:passwordString]}" scp -r authorized_keys "#{node[:hostnameNode1]}":${sshdir}/.
    #sshpass -p "#{password}" scp -r authorized_keys "#{node[:hostnameNode2]}":${sshdir}/.

    #cd .ssh
    #to_dir=`pwd`
    #echo $to_dir
    #echo 
    #sshpass -p "#{node[:passwordString]}" scp -r authorized_keys #{node[:hostnameNode1]}:/home/oracle/.ssh/.
  EOH
end