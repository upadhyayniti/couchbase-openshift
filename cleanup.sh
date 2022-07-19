oc -n couchbase delete CouchbaseCluster --all
oc -n couchbase delete subscriptions couchbase-enterprise-certified
oc -n couchbase delete operatorgroups couchbase-operatorgroup
oc delete project couchbase

