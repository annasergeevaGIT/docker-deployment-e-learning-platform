import http from 'k6/http';

export let options = {
    stages: [
        { duration: '5s', target: 10 },
        { duration: '2s', target: 1000 },   // massive spike
        { duration: '5s', target: 10 },
        { duration: '5s', target: 0 },
    ]
};

export default function () {
    http.get('http://gateway-service:9099/v1/courses');
}
//Simulates sudden traffic bursts
//testing queueing behavior in reactive apps
//test virtual thread scheduler reactions