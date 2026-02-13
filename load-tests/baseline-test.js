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
        baseline: {
            executor: 'constant-vus',
            vus: 200,
            duration: '5m',
            exec: 'enroll',
        },
    },

    thresholds: {
        http_req_failed: ['rate<0.05'],
        http_req_duration: ['p(99)<2000'],
    },
};

export function setup() {
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
    const res = http.post(
        `${BASE}/v1/course-enrollments`,
        JSON.stringify({
            courseNames: ['One', 'Two', 'Three'],
            address: { city: 'x', street: 'y', house: 1, apartment: 1 },
        }),
        {
            headers: {
                Authorization: `Bearer ${data.token}`,
                'Content-Type': 'application/json',
            },
        }
    );

    check(res, { '200': (r) => r.status === 200 });
}

export default function () {}