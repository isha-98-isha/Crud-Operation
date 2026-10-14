FROM node:24

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD node -e "fetch('http://127.0.0.1:5000/health').then(r => process.exit(r.status === 200 ? 0 : 1)).catch(() => process.exit(1))"
  
CMD ["node", "server.js"]
