import requests
import json
import platform
import subprocess
import os
import tarfile
from fabric import Connection


def get_xi_data(url):
    response = requests.get(url)
    data = json.loads(response.text)
    data = data[0]['fields']
    return data


""" 
* sends SMS alerts
* @params url, params
* return dict
"""


def alert(url, params):
    headers = {'Content-type': 'application/json; charset=utf-8'}
    r = requests.post(url, json=params, headers=headers)
    return r


recipients = ["+265998006237", "+265998276712"]

cluster = get_xi_data('http://10.44.0.52/sites/api/v1/get_single_cluster/23')

for site_id in cluster['site']:
    site = get_xi_data('http://10.44.0.52/sites/api/v1/get_single_site/' + str(site_id))

    # functionality for ping re-tries
    count = 0

    while (count < 3):

        # lets check if the site is available
        param = '-n' if platform.system().lower() == 'windows' else '-c'
        if subprocess.call(['ping', param, '1', site['ip_address']]) == 0:

            # ship data to remote site
            push_iblis = "rsync " + "-r $WORKSPACE/iBLIS.tar.gz "+ site['username'] + "@" + site[
                'ip_address'] + ":/var/www/html/"
            os.system(push_iblis)
                
             # ship script to extract file
            push_extract_script = "rsync " + "-r $WORKSPACE/extract.sh "+ site['username'] + "@" + site[
                'ip_address'] + ":/var/www/html/"
            os.system(push_extract_script)
            
           
            
             # Run extract script
            run_extract_script = "ssh " + site['username'] + "@" + site['ip_address'] + " 'cd /var/www/html/ && ./extract.sh'"
            os.system(run_extract_script)
            
             # Run setup script
            run_iblis_script = "ssh " + site['username'] + "@" + site['ip_address'] + " 'cd /var/www/html/iBLIS && ./iblis_setup.sh'"
            os.system(run_iblis_script)

            # send sms alert
            for recipient in recipients:
                msg = "Hi there,\n\nDeployment of iBlis to " + site['name'] + " completed succesfully.\n\nThanks!\nEGPAF HIS."
                params = {
                    "api_key": os.getenv('API_KEY'),
                    "recipient": recipient,
                    "message": msg
                }
                alert("http://sms-api.hismalawi.org/v1/sms/send", params)

            count = 3
        else:
            count = count + 1

            # make sure we are sending the alert at the last pint attempt
            if count == 3:
                for recipient in recipients:
                    msg = "Hi there,\n\nDeployment of iBlis for " + site['name'] + " failed to complete after several connection attempts.\n\nThanks!\nEGPAF HIS."
                    params = {
                        "api_key": os.getenv('API_KEY'),
                        "recipient": recipient,
                        "message": msg
                    }
                    alert("http://sms-api.hismalawi.org/v1/sms/send", params)
