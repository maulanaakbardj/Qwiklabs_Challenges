# Configure Secure RDP using a Windows Bastion Host

gcloud compute networks create securenetwork --subnet-mode=custom
gcloud compute networks subnets create securenetwork --network=securenetwork --region=us-central1 --range=192.168.1.0/24
gcloud compute firewall-rules create myfirewalls --network securenetwork --allow=tcp:3389 --target-tags=rdp
gcloud compute instances create vm-bastionhost --zone=us-central1-a --machine-type=n1-standard-2 --subnet=securenetwork --network-tier=PREMIUM --maintenance-policy=MIGRATE --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --tags=rdp --image=windows-server-2016-dc-v20200211 --image-project=windows-cloud --boot-disk-size=50GB --boot-disk-type=pd-standard --boot-disk-device-name=vm-bastionhost --reservation-affinity=any
gcloud compute instances create vm-securehost --zone=us-central1-a --machine-type=n1-standard-2 --subnet=securenetwork --no-address --maintenance-policy=MIGRATE --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --tags=rdp --image=windows-server-2016-dc-v20200211 --image-project=windows-cloud --boot-disk-size=50GB --boot-disk-type=pd-standard --boot-disk-device-name=vm-securehost --reservation-affinity=any
gcloud compute reset-windows-password vm-bastionhost --user app_admin --zone us-central1-a (choose Y and copy the password)
gcloud compute reset-windows-password vm-securehost --user app_admin --zone us-central1-a (choose Y and copy the password)

# Install Chrome RDP for Google Cloud Platform (https://chrome.google.com/webstore/detail/chrome-rdp-for-google-clo/mpbbnannobiobpnfblimoapbephgifkm)
# Go to Compute Engine > VM instances
# Click RDP on vm-bastionhost, fill username with app_admin and password with your copied vm-bastionhost's password 
# Click Search, search for Remote Desktop Connection and run it
# Copy and paste the internal ip from vm-securehost, click Connect
# Fill username with app_admin and password with your copied vm-securehost's password 
# Click Search, type Powershell, right click and Run as Administrator
# Run: Install-WindowsFeature -name Web-Server -IncludeManagementTools
