import Vapor

// MARK: - 라우트 설정
func routes(_ app: Application) throws {
    app.get("session") { req -> EventLoopFuture<ClientResponse> in
        let body: [String: Any] = [
            "model": "gpt-4o-realtime-preview-2024-10-01",
            "voice": "alloy"
        ]

        let jsonData = try JSONSerialization.data(withJSONObject: body)

        var openAIRequest = ClientRequest()
        openAIRequest.method = .POST
        openAIRequest.url = URI(string: "https://api.openai.com/v1/realtime/sessions")
        openAIRequest.headers.add(name: "Authorization",
                                  value: "Bearer \(Environment.get("OPENAI_API_KEY") ?? "")")
        openAIRequest.headers.add(name: "Content-Type", value: "application/json")
        openAIRequest.body = .init(data: jsonData)

        return req.client.send(openAIRequest)
    }
}

// MARK: - 서버 실행 코드 (비동기형, Swift 6 완전 호환)
Task {
    do {
        let app = try await Application.make(.detect())
        defer { Task { try? await app.asyncShutdown() } }  // ✅ 안전한 종료 방식

        // Render 외부 접근 허용
        app.http.server.configuration.hostname = "0.0.0.0"
        app.http.server.configuration.port = 8080

        try routes(app)
        try await app.execute()

    } catch {
        print("❌ 서버 실행 중 오류 발생:", error)
    }
}



