import http from 'k6/http';
import { check } from 'k6';

const BASE = __ENV.BASE_URL || 'http://enrollment-service:9092';

export const options = {
    scenarios: {
        stress: {
            executor: 'constant-arrival-rate',
            rate: 600,
            timeUnit: '1s',
            duration: '5m',
            preAllocatedVUs: 200,
            maxVUs: 800,
        },
    },

    thresholds: {
        http_req_failed: ['rate<0.05'],
        http_req_duration: ['p(99)<3000'],
    },
};

export default function () {
    const body = JSON.stringify({
        courseNames: ['One', 'Two', 'Three'],
        address: {
            city: 'Moscow',
            street: 'Street',
            house: 1,
            apartment: 1,
        },
    });

    const res = http.post(`${BASE}/v1/course-enrollments`, body, {
        headers: {
            'Content-Type': 'application/json',
            'X-User-Name': 'jane',
        },
    });

    check(res, {
        'status 201': (r) => r.status === 201,
    });
}
