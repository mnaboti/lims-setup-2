#!/bin/bash

(crontab -l 2>/dev/null; echo $"* * * * * /bin/bash -lc 'cd /var/www/html/iBLIS && php artisan nlims:sync \"\" >> log/iblis.log' ") | crontab -

#setup cronjob to sync data
(crontab -l 2>/dev/null; echo "0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58 * * * * /bin/bash -l -c 'cd /var/www/nlims_data_syncroniser/ && rvm use 2.5.3 && RAILS_ENV=development bundle exec rake nlims:sync_from_couchdb_to_couchdb --silent >> log/sync_couchdb_to_couchdb.log 2>&1'") | crontab -

