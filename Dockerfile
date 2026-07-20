# ---------- Build Stage ----------
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# ---------- Runtime Stage ----------
FROM node:18-alpine

WORKDIR /app

ENV NODE_ENV=production

COPY --from=builder /app .

RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup

USER appuser

EXPOSE 3000

CMD ["npm", "start"]
