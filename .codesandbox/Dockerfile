FROM node:18-bullseye

WORKDIR /app

COPY package*.json ./

RUN npm ci --production=false

COPY . .

RUN npm run build

EXPOSE 4321

ENV HOST=0.0.0.0
ENV PORT=4321
ENV NODE_ENV=production

HEALTHCHECK --interval=30s --timeout=3s --start-period=40s \
  CMD node -e "require('http').get('http://localhost:4321/health', (r) => {if(r.statusCode===200) process.exit(0); process.exit(1)})"

CMD ["npm", "start"]
