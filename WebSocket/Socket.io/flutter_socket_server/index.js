import dotenv from 'dotenv';
import express from 'express';
import http from 'http';
import { Server } from 'socket.io';
import apiRoutes from './routes/api.js';
import { socketHandler } from './socket/handlers.js';
import logger from './utils/logger.js';
import { errorHandler } from './middlewares/errorHandler.js';

dotenv.config();

const PORT = process.env.PORT || 8200;
const CORS_ORIGIN = process.env.CORS_ORIGIN || '*';

const app = express();
const server = http.createServer(app);
const io = new Server(server, {
    cors: {
        origin: CORS_ORIGIN,
    }
});

// API 라우터 등록
app.use('/api', apiRoutes);

// 에러 핸들러 등록
app.use(errorHandler);

// 소켓 연결 처리
io.on('connection', (socket) => {
    logger.info('클라이언트 연결됨: ', socket.id);
    socketHandler(io, socket);
})

// 서버 시작
server.listen(PORT, () => {
    logger.info(`서버 실행 중: http://localhost:${PORT}`);
});
