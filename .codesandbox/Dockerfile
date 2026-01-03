FROM node:18-bullseye

WORKDIR /app

COPY package*.json ./

RUN npm ci --production=false

COPY . .

RUN npm run build

EXPOSE 4321

ENV HOST=0.0.0.0
ENV PORT=4321

CMD ["npm", "start"]
