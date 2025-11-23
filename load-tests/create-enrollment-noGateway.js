import http from 'k6/http';
import { sleep, check } from 'k6';

export let options = {
    vus: 30,
    duration: '45s',
};

export default function () {
    const payload = JSON.stringify({
        courseNames: ["One", "Two", "Three"],
        address: {
            city: "Moscow",
            street: "Street",
            house: 1,
            apartment: 1
        }
    });

    const params = {
        headers: { 'Content-Type': 'application/json' ,
            'X-User-Name': 'max'}
    };

    let res = http.post('http://enrollment-service:9092/v1/course-enrollments', payload, params);

    check(res, {
        "status OK/Created": r => r.status === 200 || r.status === 201,
    });

    sleep(1);
}
