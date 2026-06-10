# TOSO Deployment

## Create a VM in OpenStack

* use `tol-it-prod` OpenStack project
* name: `toso`
* image: `noble-WTSI-docker_451799_132f227f`
* flavour: `m2.small` with 23G memory and 53G disk.
* security group: allow `ssh` and `web` but need more ports to be open due to both frontend and backend Docker container use other ports like 8008 and 8009 etc.
* assign a floating IP `172.27.20.198` or something else.
* remember which ssh key being used.
* default user will be `ubuntu`.
* add other users' ssh key to the server.

Probably any VM should be fine as long as having Docker installed.

## Initial Deployment

* Reference document: https://docs.google.com/document/d/1gb-fSr412zPKQILfZp7pO4PpeGjdOx0cErYpcOix2BQ/edit?tab=
* ssh to the VM.
```
# make a directory under user's home directory
mkdir ols4
cd /home/ubuntu/ols4

# checkout the code
git clone https://github.com/Tree-of-Sex/ontotools-docker.git
cd ontotools-docker/
git checkout toso

# start services
export REACT_APP_APIURL=http://172.27.20.198:8009/
nohup bash runols4.sh toso > logs_runols4.txt 2>&1 </dev/null & 

# monitor the starting process 
tail -f logs_runols4.txt

# when ready check the service directly from VM
# frontend
http://172.27.20.198:8008/
# backend
http://172.27.20.198:8009/api/v2/ontologies
```

## DNS mapping

Create two DNS entries via Sanger Web SiteManager:
* toso.tol.sanger.ac.uk -> 172.27.20.198:8008
* toso-api.tol.sanger.ac.uk -> 172.27.20.198:8009

Then:
* API: https://toso-api.tol.sanger.ac.uk/api/v2/ontologies
* Frontend: https://toso.tol.sanger.ac.uk/

## Redeployment

```
ssh ubuntu@172.27.20.198

# reload the data and services
# arond 2-3 mins
cd /home/ubuntu/ols4/ontotools-docker
 ./pull_and_redeploy.sh

# check logs
cd /home/ubuntu/ols4/ontotools-docker/deploy_logs
```
