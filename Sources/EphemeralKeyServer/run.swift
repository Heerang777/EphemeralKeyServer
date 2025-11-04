import Vapor

@main
struct Run {
    static func main() async throws {
        // 1️⃣ 앱 생성
        let app = try await Application.make(.detect())
        defer { Task { await app.shutdown() } }

        // 2️⃣ Render 외부 접근 허용
        app.http.server.configuration.hostname = "0.0.0.0"
        app.http.server.configuration.port = 8080

        // 3️⃣ routes.swift에서 정의한 라우트 연결
        try routes(app)

        // 4️⃣ 서버 실행
        try await app.execute()
    }
}


