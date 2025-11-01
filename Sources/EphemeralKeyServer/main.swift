import Vapor

// MARK: - 라우트 설정
func routes(_ app: Application) throws {
    // GET /session → OpenAI 임시 세션키 발급
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

// MARK: - 서버 실행 코드 (비동기 호환, 비-@main 버전)
do {
    var env = try Environment.detect()
    try LoggingSystem.bootstrap(from: &env)
    
    let app = try await Application.make(env)
    defer { app.shutdown() }
    
    try routes(app)
    try await app.execute()
    
} catch {
    print("❌ 서버 실행 중 오류 발생:", error)
}

