struct URLText {
    static let baseURL = "https://69154abb84e8bd126af965b5.mockapi.io/api/v1/workouts"
    static let baseURLForWorkout = "https://69154abb84e8bd126af965b5.mockapi.io/api/v1/workouts?id="
}

struct StatusText {
    static let success = "успех"
    static let error = "ошибка"
    static let badStatusCode = "Ошибка badStatusCode"
    static let codeStatus200 = 200
    static let codeStatus300 = 300
}

struct ErrorTextsPrint {
    static let invalidURL = "Неверный URL"
    static let noData = "Нет данных"
    static let networkError = "Ошибка сети:"
    static let parsingError = "Ошибка парсинга:"
    static let badStatusCode = "Ошибка, плохой статус код:"
}
