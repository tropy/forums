Tropy Forums
============
Join the discussion at [forums.tropy.org](https://forums.tropy.org).

Discourse standalone docker installation exposed via socket.
Nginx reverse proxy and Certbot set up outside.

Applying Updates
----------------
Ideally, updates should be applied via the admin interface.
To update to the latest image run

   sudo -s
   cd /var/discourse
   git pull
   ./launcher rebuild app

Certificates
------------
To request a new certificate manually run

   sudo certbot certonly --webroot -w /var/www/html -d forums.tropy.org

To renew

   sudo certbot renew --deploy-hook "systemctl reload nginx"

Restoring Backups
-----------------
Ensure that your backup file exists in

    /var/discourse/shared/standalone/backups/default

To restore the backup

    sudo -s
    cd /var/discourse
    ./launcher enter app

And from inside the container

    discourse enable_restore
    discourse restore forums-tropy-org-YYYY-MM-DD-HHMMSS-vYYYYMMDDHHMMSS.tar.gz
    discourse disable_restore

Back outside rebuild the instance

    ./launcher rebuild app

Content Security Policy
-----------------------
To temporarily switch off CSP in the Rails console

    SiteSetting.content_security_policy = false
