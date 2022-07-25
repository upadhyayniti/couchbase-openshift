# Openshift 4.9.x Setup and Deployment

# Prerequisites

The following are necessary to proceed with the setup of this demonstration: 

- An accessible Openshift Cluster with sufficient privileges
    - This setup was tested on a 4.9.x Openshift cluster. 
    - Prior versions of 4.x.x may also work as well, but have not been tested. 
- Make sure the following are installed and added to your PATH: 
    - [openshift client tools - oc - >= v4.6](https://mirror.openshift.com/pub/openshift-v4/clients/ocp/)
    - [ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
    - [python client for openshift - requires python](https://pypi.org/project/openshift/)
    - python

# Setup

The infrastructure to be created will consist of the following components: 


> You will need to have the following namespaces available for use in this demo:

```
couchbase
```

To install an entire ready-made infrastructure: 

```bash
# execute the bash install script
./install.sh

# execute the bash cleanup script to remove
/.cleanup.sh
```

Note: Various assumptions are made as part of Couchbase setup
```
Namespace: Couchbase
Cluster Name: cb-example
Bucket Name: cb-bucket
Users: cb-user, sync-gateway-user
Groups: cb-group, sync-gateway-group
```

