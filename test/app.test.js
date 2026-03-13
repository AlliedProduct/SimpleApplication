const request = require('supertest');
const assert = require('assert');
const app = require('../app');

describe('Simple Application', function () {
  it('return the home page', async function () {
    const response = await request(app).get('/');
    assert.strictEqual(response.status, 200);
    assert.match(response.text, /Simple Application/);
  });

  it('return a health ping', async function () {
    const response = await request(app).get('/health');
    assert.strictEqual(response.status, 200);
    assert.deepStrictEqual(response.body, { status: 'ok' });
  });
});
