sudo apt update 
sudo apt upgrade -y
sudo apt install openjdk-11-jdk -y

#Add a user and give him a password
sudo adduser nexus

#Give the same user permissions 
sudo usermod -aG sudo nexus

#Download nexus repository 
cd /opt
sudo wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz

#Extract the same 
sudo tar -xvf latest-unix.tar.gz

#Rename the extracted folder
sudo mv nexus-3.* nexus

#Set permissions 
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work

#Configure nexus as a service 
sudo nano /opt/nexus/bin/nexus.rc
#Add the following lines if not present 
run_as_user="nexus"

#Create a service file for nexus 
sudo nano /etc/systemd/system/nexus.service

#Add the following to the same file 
[Unit]
Description=Nexus Repository Manager
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target

#Enable and start the nexaus servie 
sudo systemctl enable nexus
sudo systemctl start nexus

