# ===============================
# ✅ EphemeralKeyServer (Render 배포용 완성 버전)
# ===============================

# 1️⃣ 빌드 단계 — Swift로 Vapor 서버 빌드
FROM swift:6.0-amazonlinux2 AS build
WORKDIR /app

# 모든 프로젝트 파일 복사 후 빌드
COPY . .
RUN swift build -c release --disable-sandbox

# 2️⃣ 런타임 단계 — 빌드된 서버 실행
FROM amazonlinux:2
WORKDIR /run

# ✅ 릴리즈된 실행 파일만 복사 (리소스 폴더 제외)
COPY --from=build /app/.build/release /run

# ✅ 서버 실행 포트
EXPOSE 8080

# ✅ Vapor 서버 실행 명령
CMD ["./EphemeralKeyServer"]


