#!/bin/bash
echo -e "\n*** Submitting requests to Course Service ***\n"

printf "\n\n"
curl -X POST http://localhost:9091/v1/courses -H 'Content-Type: application/json' -d '{"name": "One","description": "Nice Item One", "price": 10.10, "category": "engineering", "duration": 1000, "difficulty": "beginner", "imageUrl": "http://images.com/one.png", "moduleCollection": {"modules": [{"name": "module one", "duration": 10}, {"name": "module two", "duration": 20}]}}'
printf "\n\n"
curl -X POST http://localhost:9091/v1/courses -H 'Content-Type: application/json' -d '{"name": "Two","description": "Nice Item Two", "price": 10.10, "category": "engineering", "duration": 1000, "difficulty": "beginner", "imageUrl": "http://images.com/one.png", "moduleCollection": {"modules": [{"name": "module one", "duration": 10}, {"name": "module two", "duration": 20}]}}'
printf "\n\n"
curl -X POST http://localhost:9091/v1/courses -H 'Content-Type: application/json' -d '{"name": "Three","description": "Nice Item Three", "price": 10.10, "category": "engineering", "duration": 1000, "difficulty": "beginner", "imageUrl": "http://images.com/one.png", "moduleCollection": {"modules": [{"name": "module one", "duration": 10}, {"name": "module two", "duration": 20}]}}'
printf "\n\n"
echo -e "\n*** Submitting requests to Enrollment Service ***\n"
printf "\n\n"
curl -X POST http://localhost:9092/v1/course-enrollments -H 'Content-Type: application/json' -H 'X-User-Name: UserName1' -d '{"courseNames": ["One", "Two", "Three"], "address": { "city": "Moscow", "street": "Street", "house": 1, "apartment": 1}}'
printf "\n\n"
curl -X POST http://localhost:9092/v1/course-enrollments -H 'Content-Type: application/json' -H 'X-User-Name: UserName2' -d '{"courseNames": ["One", "Two", "Three"], "address": { "city": "Kaluga", "street": "Street", "house": 1, "apartment": 1}}'
printf "\n\n"
curl -X POST http://localhost:9092/v1/course-enrollments -H 'Content-Type: application/json' -H 'X-User-Name: UserName3' -d '{"courseNames": ["One", "Two", "Three"], "address": { "city": "Samara", "street": "Street", "house": 1, "apartment": 1}}'
printf "\n\n"
curl -X POST http://localhost:9092/v1/course-enrollments -H 'Content-Type: application/json' -H 'X-User-Name: UserName4' -d '{"courseNames": ["One", "Two", "Three"], "address": { "city": "Rostov", "street": "Street", "house": 1, "apartment": 1}}'
printf "\n\n"
curl -X POST http://localhost:9092/v1/course-enrollments -H 'Content-Type: application/json' -H 'X-User-Name: UserName5' -d '{"courseNames": ["One", "Two", "Three"], "address": { "city": "Rostov", "street": "Street", "house": 1, "apartment": 1}}'
printf "\n\n"
echo -e "\n*** Submitting requests to Feedback Service ***\n"
printf "\n\n"
curl -X POST http://localhost:9093/v1/feedbacks -H 'Content-Type: application/json' -H 'X-User-Name: Alex' -d '{"courseId": 1, "comment": "Comment", "rate": 5}'
printf "\n\n"
curl -X POST http://localhost:9093/v1/feedbacks -H 'Content-Type: application/json' -H 'X-User-Name: Alex' -d '{"courseId": 2, "comment": "Comment", "rate": 5}'
printf "\n\n"
curl -X POST http://localhost:9093/v1/feedbacks -H 'Content-Type: application/json' -H 'X-User-Name: Alex' -d '{"courseId": 3, "comment": "Comment", "rate": 5}'
printf "\n\n"
curl -X POST http://localhost:9093/v1/feedbacks -H 'Content-Type: application/json' -H 'X-User-Name: John' -d '{"courseId": 1, "comment": "Comment", "rate": 5}'
printf "\n\n"
curl -X POST http://localhost:9093/v1/feedbacks -H 'Content-Type: application/json' -H 'X-User-Name: Michael' -d '{"courseId": 1, "comment": "Comment", "rate": 3}'
printf "\n\n"
curl -X POST http://localhost:9093/v1/feedbacks -H 'Content-Type: application/json' -H 'X-User-Name: Max' -d '{"courseId": 1, "comment": "Comment", "rate": 2}'
printf "\n\n"
curl -X POST http://localhost:9093/v1/feedbacks -H 'Content-Type: application/json' -H 'X-User-Name: Phill' -d '{"courseId": 1, "comment": "Comment", "rate": 2}'
printf "\n\n"
curl http://localhost:9093/v1/feedbacks/1
printf "\n\n"
curl -H 'X-User-Name: Alex' "http://localhost:9093/v1/feedbacks/course/1?from=0&size=10&sortBy=date_asc"
printf "\n\n"
curl -H 'X-User-Name: Alex' "http://localhost:9093/v1/feedbacks/my?from=0&size=10&sortBy=date_asc"
printf "\n\n"
curl -X POST http://localhost:9093/v1/feedbacks/ratings -H 'Content-Type: application/json' -d '{"courseIds": [1,2,3,4,5]}'
printf "\n\n"
echo -e "\n*** Submitting requests to Course Aggregate Service ***\n"
printf "\n\n"
curl http://localhost:9094/v1/course-aggregate/1
printf "\n\n"
curl "http://localhost:9094/v1/course-aggregate?category=ENGINEERING"
printf "\n\n"

