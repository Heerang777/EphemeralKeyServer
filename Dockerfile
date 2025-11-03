# ✅ EphemeralKeyServer - Render용 단일 스테이지 Dockerfile

# Swift가 들어 있는 베이스 이미지 하나만 사용
FROM swift:6.0-amazonlinux2

# 작업 디렉토리
WORKDIR /app

# 프로젝트 전체 복사
COPY . .

# 릴리즈 빌드
RUN swift build -c release --disable-sandbox

# 실행 디렉토리로 이동
WORKDIR /app/.build/release

# Vapor 서버 포트
EXPOSE 8080

# 서버 실행 (Package.swift 제품 이름이 EphemeralKeyServer 라고 가정)
CMD ["./EphemeralKeyServer"]


