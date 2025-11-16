import http from 'k6/http';
import { sleep, check } from 'k6';

export let options = {
    vus: 30,
    duration: '45s',
};

export default function () {
    const payload = JSON.stringify({
        userId: 123,
        moduleNames: ["java", "spring", "cloud"]
    });

    const params = {
        headers: { 'Content-Type': 'application/json' }
    };

    let res = http.post('http://gateway-service:9099/v1/enrollments', payload, params);

    check(res, {
        "status OK/Created": r => r.status === 200 || r.status === 201,
    });

    sleep(1);
}
