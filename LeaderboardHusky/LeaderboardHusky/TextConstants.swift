enum Gender: String {
    case male = "male"
    case female = "female"
}

enum TypeResult: String {
    case count = "0"
    case time = "1"
}

enum LeaderboardText: String {
    case delete = "Удалить"
    case ok = "Ок"
    case addResult = "Добавить результат"
    case space = "\n\n\n"
}

enum LeaderboardAlertField: String {
    case name = "Имя"
    case countRep = "Количество повторов"
    case time = "Время __:__"
}

enum LeaderboardButtonText: String {
    case boy = "Парень"
    case girl = "Девушка"
    case cancel = "Отмена"
    case save = "Сохранить"
    case leaderboard = "Лидерборд"
}

enum LeaderboardPresenterTextMessage: String {
    case noResults = "Пока нет результатов"
    case beFirst = "Будь первым!"
}

enum LeaderboardSegmentControlText: String {
    case boys = "Парени"
    case girls = "Девушки"
}

enum Headlines: String {
    case workouts = "Список тренировок"
    case workout = "Тренировка"
    case leaderboard = "Лидерборд"
}
