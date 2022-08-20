FROM node AS builder
WORKDIR /build
COPY . .
WORKDIR /build/link-shortener-frontend
RUN npm i && npm i -g @angular/cli
RUN ng build --configuration production --base-href /home/ --output-path ./../link-shortener-backend/dist


FROM node AS End_stage
WORKDIR /server
COPY --from=builder /build/link-shortener-backend .
RUN npm install --omit=dev
CMD ["node","server.js"]