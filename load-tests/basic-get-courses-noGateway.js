import http from 'k6/http';
import { sleep, check } from 'k6';

export let options = {
    vus: 50, //concurrent users
    duration: '30s', //each VU repeatedly executes the test scenario total requests ≈ 50 × iterations_per_second × 30
};

export default function () {
    const res = http.get(
        'http://enrollment-service:9092/v1/course-enrollments?from=0&size=50&sortBy=DATE_ASC',
        {
            headers: { 'X-User-Name': 'max' }
        }
    );

    check(res, {
        "status 200": r => r.status === 200,
    });

    sleep(1);
}
