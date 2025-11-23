import http from 'k6/http';
import { sleep, check } from 'k6';

export let options = {
    vus: 40,
    duration: '60s',
};

export default function () {

    // 1. Browse course list (course-service, MVC)
    let list = http.get('http://course-service:9091/v1/courses');
    check(list, { "courses ok": r => r.status === 200 });

    sleep(0.2);

    // 2. Browse course info (course-service)
    let info = http.get('http://course-service:9091/v1/courses/course-info?courseId=1');
    check(info, { "course-info ok": r => r.status === 200 });

    sleep(0.2);

    // 3. Create enrollment (virtual threads)
    const payload = JSON.stringify({
        courseNames: ["java"],
        address: {
            city: "Berlin",
            street: "Street",
            house: 1,
            apartment: 1
        }
    });

    let enroll = http.post(
        'http://enrollment-service:9092/v1/course-enrollments',
        payload,
        { headers: { 'Content-Type': 'application/json' } }
    );

    check(enroll, { "enroll ok": r => r.status === 201 || r.status === 200 });

    sleep(0.3);

    // 4. Feedback (feedback-service, MVC)
    let feedback = http.post(
        'http://feedback-service:9093/v1/feedbacks',
        JSON.stringify({
            courseId: 1,
            comment: "great course",
            rate: 5
        }),
        { headers: { 'Content-Type': 'application/json' } }
    );

    check(feedback, { "feedback ok": r => r.status < 500 });

    sleep(0.3);
}
