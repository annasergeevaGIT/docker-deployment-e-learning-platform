import http from 'k6/http';

const BASE = __ENV.BASE_URL;
const TOKEN_URL = __ENV.TOKEN_URL;

export const options = {
    scenarios: {
        spike: {
            executor: 'ramping-arrival-rate',
            timeUnit: '1s',

            startRate: 200,          // normal load (~stress level)
            preAllocatedVUs: 300,
            maxVUs: 2000,

            stages: [
                { target: 200,  duration: '2m' },  // steady baseline
                { target: 2000, duration: '10s' }, // instant spike
                { target: 2000, duration: '50s' }, // hold saturation
                { target: 200,  duration: '2m' },  // recovery
            ],

            exec: 'enroll',
        },
    },
};

let TOKEN;

export function setup() {
    const res = http.post(TOKEN_URL, {
        username: 'jane',
        password: 'password',
        grant_type: 'password',
        client_id: 'cloud-java-gateway',
        client_secret: 'RleFn4MVPDKtGTXIZv4Opyfuwfx2fFLL'
    });

    TOKEN = res.json('access_token');
    return { token: TOKEN };
}

export function enroll(data) {
    http.post(`${BASE}/v1/course-enrollments`,
        JSON.stringify({
            courseNames: ['One','Two','Three'],
            address: { city:'x', street:'y', house:1, apartment:1 }
        }),
        { headers: { Authorization:`Bearer ${data.token}`, 'Content-Type':'application/json' } }
    );
}