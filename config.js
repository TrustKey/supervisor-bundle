module.exports = [
    "./node_modules/@trustkey/crypto-rng",
    {
        packagePath: "./core",
        servers: [
            {
                server_id: "D000000000000000",
                websocket_endpoint: 'ws://sv0.trustkey.cc:18770',
                tag: 'test',
                priority: 5,
                supervise_constantly: true
            }
        ],
        reconnect_timeout: 1 * 1000,
        mongoDb: {
            server: {
                host: "127.0.0.1",
                port: 27017,
                options: { }
            },
            database: "trustkey"
        }
    },
    "./modules/algorithms",
    "./modules/trustkey_argon2d",
    "./modules/trustkey_first_perfect",
    "./modules/promise",
    "./modules/promise-http-api",
    "./modules/http-server"
];
