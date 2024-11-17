import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var currentQuestionIndex: Int = 0
    var selectedAnswerIndex: Int? = nil
    var correctAnswersCount: Int = 0
    var totalQuestions: Int {
        return questionBank.count
    }

    var questionBank: [QuizQuestion] {
        return QuestionBankManager.shared.questionBank
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        correctAnswersCount = 0
        setupUI()
        loadQuestion()
    }
    
    func setupUI() {
        progressBar.progress = 0.0
        updateProgress()
    }
    
    func loadQuestion() {
        guard questionBank.count > 0, currentQuestionIndex >= 0, currentQuestionIndex < questionBank.count else { return }
        
        let question = questionBank[currentQuestionIndex]
        questionLabel.text = question.question
        
        var answers = question.incorrectAnswers + [question.correctAnswer]
        answers.shuffle()
        
        answerButton1.setTitle(answers[0], for: .normal)
        answerButton2.setTitle(answers[1], for: .normal)
        answerButton3.setTitle(answers[2], for: .normal)
        answerButton4.setTitle(answers[3], for: .normal)
        
        resetAnswerButtonImages()
    }
    
    func resetAnswerButtonImages() {
        let buttons = [answerButton1, answerButton2, answerButton3, answerButton4]
        for button in buttons {
            button?.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        
        if let index = selectedAnswerIndex {
            let selectedButton = buttons[index]
            selectedButton?.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        }
    }
    
    func updateProgress() {
        guard questionBank.count > 0 else { return }
        let progress = Float(currentQuestionIndex + 1) / Float(questionBank.count)
        progressBar.setProgress(progress, animated: true)
    }
    
    func calculateAverageScore() -> Float {
        return Float(correctAnswersCount) / Float(totalQuestions) * 100
    }
    
    func showResult() {
        let averageScore = calculateAverageScore()
        let alert = UIAlertController(title: "Quiz Finished", message: "Your score: \(averageScore)%\nCorrect answers: \(correctAnswersCount)/\(totalQuestions)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        let buttons = [answerButton1, answerButton2, answerButton3, answerButton4]
        if let index = buttons.firstIndex(of: sender) {
            selectedAnswerIndex = index
            resetAnswerButtonImages()

            let selectedAnswer = buttons[index]?.title(for: .normal) ?? ""
            let correctAnswer = questionBank[currentQuestionIndex].correctAnswer
            
            if selectedAnswer == correctAnswer {
                correctAnswersCount += 1
            }
        }
    }

    @IBAction func previousButtonTapped(_ sender: UIButton) {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            selectedAnswerIndex = nil
            loadQuestion()
            updateProgress()
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if currentQuestionIndex < questionBank.count - 1 {
            currentQuestionIndex += 1
            selectedAnswerIndex = nil
            loadQuestion()
            updateProgress()
        } else {
            showResult() // Show result after last question
        }
    }
}
