import http from 'k6/http';
import { check } from 'k6';

const BASE = __ENV.BASE_URL || 'http://localhost:9092';

export const options = {
    scenarios: {
        baseline: {
            executor: 'constant-vus',
            vus: 200,
            duration: '5m',
        },
    },
};

export default function () {
    const res = http.post(
        `${BASE}/v1/course-enrollments`,
        JSON.stringify({
            courseNames: ['One', 'Two', 'Three'],
            address: { city: 'x', street: 'y', house: 1, apartment: 1 },
        }),
        {
            headers: {
                'Content-Type': 'application/json',
                'X-User-Name': 'jane',
            },
        }
    );

    check(res, { 'created': (r) => r.status === 201 });
}
