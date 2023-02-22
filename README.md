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

To find admin username and password for Couchbase UI login, look for cb-example secret for Administrator password.

Note: Various assumptions are made as part of Couchbase setup
```
Namespace: Couchbase
Cluster Name: cb-example
Bucket Name: cb-bucket
Users: cb-user, sync-gateway-user
Groups: cb-group, sync-gateway-group
```

Insert Sample Data in cb-bucket._default._default using UI and sampledata.json in repo.
Use following command if not using UI
```
cbimport json --format list -c http://cb-route-couchbase.apps.<cluster url> -u <login> -p <password> -b 'cb-bucket' --scope-collection-exp "_default._default" -g "#UUID#" 
```

Create Primary Index
```
CREATE PRIMARY INDEX `adv_id_default_prim` ON `cb-bucket`._default._default
```

Write query to get data

```
select * from `cb-bucket`._default._default where address.city like '%Boston%'
```

Curl command to run from a pod/container
```
curl -v http://cb-example.couchbase.svc.cluster.local:8093/query/service      -d 'statement=select  * from `cb-bucket`._default._default where address.city is not null'      -u Administrator:<found from secret>

 curl -v http://localhost:8093/query/service      -d 'statement=SELECT address.city
                   FROM `cb-bucket`._default._default LIMIT 1
        & creds=[{"user": "admin:Administrator", "pass": "password"}]'


```

Look for "results" in the response body for data. 
```
{
"requestID": "dcd0f9e0-4fe0-4433-b819-6f46f469bc9a",
"signature": {"*":"*"},
"results": [
{"_default":{"address":{"city":"Boston, MA","street":"120 Harbor Blvd.","zipcode":"02115"},"custid":"C37","name":"T. Henry","rating":750}},
{"_default":{"address":{"city":"St. Louis, MO","street":"360 Mountain Ave.","zipcode":"63101"},"custid":"C31","name":"B. Pruitt"}},
{"_default":{"address":{"city":"St. Louis, MO","street":"150 Market St.","zipcode":"63101"},"custid":"C41","name":"R. Dodge","rating":640}},
{"_default":{"address":{"city":"Boston, MA","street":"420 Green St.","zipcode":"02115"},"custid":"C35","name":"J. Roberts","rating":565}},
{"_default":{"address":{"city":"St. Louis, MO","street":"201 Main St.","zipcode":"63101"},"custid":"C13","name":"T. Cody","rating":750}},
{"_default":{"address":{"city":"Rome, Italy","street":"Via del Corso"},"custid":"C47","name":"S. Logan","rating":625}},
{"_default":{"address":{"city":"Hanover, MA","street":"690 River St.","zipcode":"02340"},"custid":"C25","name":"M. Sinclair","rating":690}}
],
"status": "success",
"metrics": {"elapsedTime": "2.500088ms","executionTime": "2.450757ms","resultCount": 7,"resultSize": 937,"serviceLoad": 1}
}
```
