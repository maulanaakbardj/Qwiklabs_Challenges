## Google Cloud Essential Skills: Challenge Lab ##

### Create a Compute Engine instance, add necessary firewall rules
```
// Goto Compute Engine -> VM Instannces -> Create Instance.
   
   Name : <Instance_name_LAB>
   Zone : <Compute_zone_LAB>
   Series : N1
   
   Check : Allow HTTP Traffic
          Allow HTTPS Traffic
          
// Click Create.
```
### Configure Apache2 Web Server in your instance & Test your server
```
// SSH to 'apache' instance and run:-

sudo su -
apt-get update
apt-get install apache2 -y
service --status-all
```
