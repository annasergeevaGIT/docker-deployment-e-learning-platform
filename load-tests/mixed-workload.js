import http from 'k6/http';
import { sleep, check } from 'k6';

export let options = {
    vus: 20,
    duration: '30s',
};

export default function () {

    // 1. Browse course list
    let list = http.get('http://gateway-service:9099/v1/courses');
    check(list, { "courses ok": r => r.status === 200 });

    sleep(0.1);

    // 2. Browse course info
    let info = http.get('http://gateway-service:9099/v1/courses/course-info?courseId=1');
    check(info, { "course-info ok": r => r.status === 200 });

    sleep(0.1);

    // 3. Create enrollment
    const payload = JSON.stringify({
        userId: 50,
        moduleNames: ["java"]
    });

    let enroll = http.post('http://gateway-service:9099/v1/enrollments', payload, {
        headers: { 'Content-Type': 'application/json' }
    });

    check(enroll, { "enroll ok": r => r.status === 200 || r.status === 201 });

    sleep(0.1);

    // 4. Feedback (MVC app)
    let feedback = http.post('http://feedback-service:9093/v1/feedback', JSON.stringify({
        userId: 50,
        text: "great course"
    }), { headers: { 'Content-Type': 'application/json' } });

    check(feedback, { "feedback ok": r => r.status < 500 });

    sleep(0.1);
}

//realistic scenario for benchmarking because virtual threads affect MVC services differently, and reactive affects WebFlux services differently, so mixed load shows the real picture
//browse courses, request course info, create an enrollment, ping feedback service (MVC)