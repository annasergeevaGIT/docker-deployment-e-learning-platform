import http from 'k6/http';

const BASE = __ENV.BASE_URL || 'http://enrollment-service:9092';

export const options = {
    scenarios: {
        spike: {
            executor: 'ramping-arrival-rate',
            timeUnit: '1s',

            startRate: 200,
            preAllocatedVUs: 300,
            maxVUs: 2000,

            stages: [
                { target: 200,  duration: '2m' },
                { target: 2000, duration: '10s' },
                { target: 2000, duration: '50s' },
                { target: 200,  duration: '2m' },
            ],
        },
    },
};

export default function () {
    http.post(
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
}
