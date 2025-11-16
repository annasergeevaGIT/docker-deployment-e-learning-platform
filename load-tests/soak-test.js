import http from 'k6/http';
import { sleep } from 'k6';

export let options = {
    vus: 50,
    duration: '20m'
};

export default function () {
    http.get('http://gateway-service:9099/v1/courses');
    sleep(0.5);
}

//10–60 min load
//Detect memory leaks, thread buildup, connection leaks