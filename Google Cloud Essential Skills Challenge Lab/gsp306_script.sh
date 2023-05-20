# Migrate a MySQL Database to Google Cloud SQL

export ZONE=<zone vm> //check your zone vm lab

gcloud sql instances create wordpress --tier=db-n1-standard-1 --activation-policy=ALWAYS --gce-zone $ZONE

gcloud sql users set-password --host % root --instance wordpress --password Password1*

export ADDRESS=<external IP Demo Blog>/32

gcloud sql instances patch wordpress --authorized-networks $ADDRESS --quiet

gcloud compute ssh blog --zone=<zone vm>

MYSQLIP=$(gcloud sql instances describe wordpress --format="value(ipAddresses.ipAddress)")

mysql --host=$MYSQLIP \
    --user=root --password
    
----------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE DATABASE wordpress;
CREATE USER 'blogadmin'@'%' IDENTIFIED BY 'Password1*';
GRANT ALL PRIVILEGES ON wordpress.* TO 'blogadmin'@'%';
FLUSH PRIVILEGES;
exit

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

sudo mysqldump -u root -pPassword1* wordpress > wordpress_backup.sql

mysql --host=$MYSQLIP --user=root -pPassword1* --verbose wordpress < wordpress_backup.sql

sudo service apache2 restart

cd /var/www/html/wordpress

sudo nano wp-config.php
# Change DB_HOST 'localhost' with IP SQL <wordpress>
