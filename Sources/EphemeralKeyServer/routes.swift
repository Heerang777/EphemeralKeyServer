//
//  routes.swift
//  EphemeralKeyServer
//
//  Created by 엄희랑 on 11/4/25.
//

import Vapor

// MARK: - 라우트 설정
func routes(_ app: Application) throws {
    app.get("session") { req -> EventLoopFuture<ClientResponse> in
        // 🔸 OpenAI Realtime Session 생성 요청 바디
        let body: [String: Any] = [
            "model": "gpt-4o-realtime-preview-2024-10-01",
            "voice": "alloy"
        ]

        // JSON 데이터 직렬화
        let jsonData = try JSONSerialization.data(withJSONObject: body)

        // 🔹 OpenAI API 요청 생성
        var openAIRequest = ClientRequest()
        openAIRequest.method = .POST
        openAIRequest.url = URI(string: "https://api.openai.com/v1/realtime/sessions")
        openAIRequest.headers.add(name: "Authorization",
                                  value: "Bearer \(Environment.get("OPENAI_API_KEY") ?? "")")
        openAIRequest.headers.add(name: "Content-Type", value: "application/json")
        openAIRequest.body = .init(data: jsonData)

        // 🔸 API 요청 전송
        return req.client.send(openAIRequest)
    }
}


