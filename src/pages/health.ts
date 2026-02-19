export const GET = () => {
  return new Response(JSON.stringify({
    status: 'ok',
    timestamp: new Date().toISOString(),
    version: '0.0.3',
    adapter: 'node',
    port: 4321
  }), {
    status: 200,
    headers: {
      'Content-Type': 'application/json'
    }
  });
};
