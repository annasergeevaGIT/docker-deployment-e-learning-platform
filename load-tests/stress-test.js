import http from 'k6/http';
import { check } from 'k6';

const BASE = __ENV.BASE_URL || 'http://localhost:9099';
const TOKEN_URL =
    __ENV.TOKEN_URL ||
    'http://localhost:8080/realms/cloud-java/protocol/openid-connect/token';

const CLIENT_ID = 'cloud-java-gateway';
const CLIENT_SECRET = 'RleFn4MVPDKtGTXIZv4Opyfuwfx2fFLL';

export const options = {
    scenarios: {
        stress: {
            executor: 'constant-arrival-rate',
            // startTime: '1m',
            rate: 600,
            timeUnit: '1s',
            duration: '5m',
            preAllocatedVUs: 200,
            maxVUs: 800,
            exec: 'enroll',
        },
    },

    thresholds: {
        http_req_failed: ['rate<0.05'],
        http_req_duration: ['p(99)<3000'],
    },
};

export function setup() {
    // same user as your working curl (jane)
    const res = http.post(TOKEN_URL, {
        username: 'jane',
        password: 'password',
        grant_type: 'password',
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        scope: 'openid roles',
    });

    return { token: res.json('access_token') };
}

export function enroll(data) {
    // EXACT same payload that works in your curl script
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
            Authorization: `Bearer ${data.token}`,
            'Content-Type': 'application/json',
        },
    });

    check(res, {
        'status 201': (r) => r.status === 201,
    });
}
