import Foundation

class QuestionBankManager {
    static let shared = QuestionBankManager()
    private init() {}
    
    var questionBank: [QuizQuestion] = []
}
