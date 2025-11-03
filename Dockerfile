//
//  Dockerfile.swift
//  EphemeralKeyServer
//
//  Created by 엄희랑 on 11/3/25.
//

# ✅ Vapor 서버용 Dockerfile (Render 전용)
FROM swift:6.0-amazonlinux2 AS build
WORKDIR /app

# 패키지 복사 및 빌드
COPY . .
RUN swift build -c release --disable-sandbox

# 런타임 이미지
FROM amazonlinux:2
WORKDIR /run
COPY --from=build /app/.build/release /run
COPY --from=build /app/Public /run/Public
COPY --from=build /app/Resources /run/Resources

# Vapor 서버 실행 포트
EXPOSE 8080

CMD ["./EphemeralKeyServer"]

