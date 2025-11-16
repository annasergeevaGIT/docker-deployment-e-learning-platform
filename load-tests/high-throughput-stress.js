import http from 'k6/http';
import { check } from 'k6';

export let options = {
    stages: [
        { duration: '20s', target: 200 },
        { duration: '40s', target: 800 },
        { duration: '20s', target: 1500 },
        { duration: '10s', target: 0 },
    ]
};

export default function () {
    const res = http.get('http://gateway-service:9099/v1/courses');
    check(res, { "status 200": r => r.status === 200 });
}
//Push system until it breaks
//Reveals event-loop saturation (reactive) or thread explosion (virtual threads)