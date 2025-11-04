import Vapor

@main
struct Run {
    static func main() async throws {
        // 🌐 1️⃣ Vapor 환경 감지 및 앱 생성
        let app = try await Application.make(.detect())
        defer { Task { await app.shutdown() } }  // 안전 종료

        // 🌍 2️⃣ Render 외부 접속 허용 (포트/호스트 설정)
        app.http.server.configuration.hostname = "0.0.0.0"
        app.http.server.configuration.port = 8080

        // 🧩 3️⃣ routes.swift에 정의된 라우트 불러오기
        try routes(app)

        // 🚀 4️⃣ 서버 실행 (Swift 6에서는 execute() 사용)
        try await app.execute()
    }
}


