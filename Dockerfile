# The app (API and its React client) for Cloud Run.
# The server bundle imports vite at startup (server/vite.ts), so dev dependencies stay installed.
FROM node:24-slim
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci && npm cache clean --force
COPY . .
# The client reads these at build time
ARG VITE_GRADPLACIFYR_LOGIN_URL=https://gradplacifyr.nidanos.com/login
ARG VITE_API_URL=https://aimcqtest.nidanos.com
RUN npm run build
ENV NODE_ENV=production
USER node
CMD ["node", "dist/index.js"]
