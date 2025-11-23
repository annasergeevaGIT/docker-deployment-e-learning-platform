#!/bin/bash

CLIENT_SECRET=RleFn4MVPDKtGTXIZv4Opyfuwfx2fFLL

echo -e "\n*** Submitting requests to Course Service***\n"

echo -e "\n*** Get access_token for alex***\n"
ACCESS_TOKEN=$(curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=alex' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d "client_secret=$CLIENT_SECRET" -d 'scope=openid roles' -s | jq .access_token -r)
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"
printf "\n\n"
curl -X POST http://localhost:9099/v1/courses -H "$AUTH_HEADER" -H 'Content-Type: application/json' -d '{"name": "One","description": "Nice Item One", "price": 10.10, "category": "engineering", "duration": 1000, "difficulty": "beginner", "imageUrl": "http://images.com/one.png", "moduleCollection": {"modules": [{"name": "module one", "duration": 10}, {"name": "module two", "duration": 20}]}}'
printf "\n\n"
curl -X POST http://localhost:9099/v1/courses -H "$AUTH_HEADER" -H 'Content-Type: application/json' -d '{"name": "Two","description": "Nice Item Two", "price": 10.10, "category": "engineering", "duration": 1000, "difficulty": "beginner", "imageUrl": "http://images.com/one.png", "moduleCollection": {"modules": [{"name": "module one", "duration": 10}, {"name": "module two", "duration": 20}]}}'
printf "\n\n"
curl -X POST http://localhost:9099/v1/courses -H "$AUTH_HEADER" -H 'Content-Type: application/json' -d '{"name": "Three","description": "Nice Item Three", "price": 10.10, "category": "engineering", "duration": 1000, "difficulty": "beginner", "imageUrl": "http://images.com/one.png", "moduleCollection": {"modules": [{"name": "module one", "duration": 10}, {"name": "module two", "duration": 20}]}}'
printf "\n\n"

echo -e "\n*** Submitting requests to Enrollments Service ***\n"

echo -e "\n*** Get access_token for jane***\n"
ACCESS_TOKEN=$(curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=jane' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d "client_secret=$CLIENT_SECRET" -d 'scope=openid roles' -s | jq .access_token -r)
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"
printf "\n\n"
curl -X POST http://localhost:9099/v1/course-enrollments -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"courseNames": ["One", "Two", "Three"], "address": { "city": "Moscow", "street": "Street", "house": 1, "apartment": 1}}'
printf "\n\n"
curl -X POST http://localhost:9099/v1/course-enrollments -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"courseNames": ["One", "Two", "Three"], "address": { "city": "Graz", "street": "Street", "house": 1, "apartment": 1}}'
printf "\n\n"
curl -X POST http://localhost:9099/v1/course-enrollments -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"courseNames": ["One", "Two", "Three"], "address": { "city": "Berlin", "street": "Street", "house": 1, "apartment": 1}}'
printf "\n\n"

echo -e "\n*** Get access_token for max***\n"
ACCESS_TOKEN=$(curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=max' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d "client_secret=$CLIENT_SECRET" -d 'scope=openid roles' -s | jq .access_token -r)
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"
printf "\n\n"
curl -X POST http://localhost:9099/v1/course-enrollments -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"courseNames": ["One", "Two", "Three"], "address": { "city": "Rostov", "street": "Street", "house": 1, "apartment": 1}}'
printf "\n\n"
curl -X POST http://localhost:9099/v1/course-enrollments -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"courseNames": ["One", "Two", "Three"], "address": { "city": "Rostov", "street": "Street", "house": 1, "apartment": 1}}'
printf "\n\n"

echo -e "\n*** Submitting requests to Feedback Service ***\n"
printf "\n\n"
curl -X POST http://localhost:9099/v1/feedbacks -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"courseId": 1, "comment": "Comment", "rate": 5}'
printf "\n\n"
curl -X POST http://localhost:9099/v1/feedbacks -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"courseId": 2, "comment": "Comment", "rate": 5}'
printf "\n\n"
curl -X POST http://localhost:9099/v1/feedbacks -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"courseId": 3, "comment": "Comment", "rate": 5}'
printf "\n\n"

echo -e "\n*** Get access_token for jane***\n"
ACCESS_TOKEN=$(curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=jane' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d "client_secret=$CLIENT_SECRET" -d 'scope=openid roles' -s | jq .access_token -r)
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"
printf "\n\n"
curl -X POST http://localhost:9099/v1/feedbacks -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"courseId": 1, "comment": "Comment", "rate": 5}'
printf "\n\n"
curl -X POST http://localhost:9099/v1/feedbacks -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"courseId": 4, "comment": "Comment", "rate": 3}'
printf "\n\n"
curl -X POST http://localhost:9099/v1/feedbacks -H 'Content-Type: application/json' -H "$AUTH_HEADER" -d '{"courseId": 5, "comment": "Comment", "rate": 2}'
printf "\n\n"
curl http://localhost:9099/v1/feedbacks/1
printf "\n\n"
curl "http://localhost:9099/v1/feedbacks/course/1?from=0&size=10&sortBy=date_asc"
printf "\n\n"

echo -e "\n*** Get access_token for max***\n"
ACCESS_TOKEN=$(curl -X POST http://keycloak:8080/realms/cloud-java/protocol/openid-connect/token -d 'username=max' -d 'password=password' -d 'grant_type=password' -d 'client_id=cloud-java-gateway' -d "client_secret=$CLIENT_SECRET" -d 'scope=openid roles' -s | jq .access_token -r)
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"
printf "\n\n"
curl -H "$AUTH_HEADER" "http://localhost:9099/v1/feedbacks/my?from=0&size=10&sortBy=date_asc"
printf "\n\n"
curl -X POST http://localhost:9099/v1/feedbacks/ratings -H 'Content-Type: application/json' -d '{"courseIds": [1,2,3,4,5]}'
printf "\n\n"

echo -e "\n*** Submitting requests to Course Aggregate Service ***\n"
printf "\n\n"
curl http://localhost:9099/v1/course-aggregate/1
printf "\n\n"
curl "http://localhost:9099/v1/course-aggregate?category=ENGINEERING"
printf "\n\n"

