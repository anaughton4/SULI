# Goals for Today



# Notes
* Command to create a subscription request to the mongo database:
  * curl -i -X POST "http://localhost:6060/nnwdaf-eventssubscription/v1/subscriptions" \
--header 'Content-Type: application/json' \
--data '{
    "eventSubscriptions": [{
        "event": "UE_MOBILITY",
        "notificationMethod": "DIRECT"
    }],
    "notificationURI": "http://192.168.71.135:8080/callback"
}'

* docker exec -it oai-nwdaf-database mongosh mongodb://127.0.0.1:27017 --eval "show dbs"





# What I did Today
* Figured out how to gather SMF and AMF data through python.