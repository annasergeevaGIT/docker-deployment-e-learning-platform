import http from 'k6/http';
import { sleep, check } from 'k6';

export let options = {
    vus: 50,
    duration: '30s',
};

export default function () {
    const res = http.get('http://gateway-service:9099/v1/courses');

    check(res, {
        "status 200": r => r.status === 200,
    });

    sleep(1);
}
