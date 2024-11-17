import UIKit

class QuestionBuilderViewController: UIViewController {
    
    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var correctAnswerField: UITextField!
    @IBOutlet weak var incorrectAnswer1Field: UITextField!
    @IBOutlet weak var incorrectAnswer2Field: UITextField!
    @IBOutlet weak var incorrectAnswer3Field: UITextField!
    
    var saveQuestion: ((QuizQuestion) -> Void)?
    var isUpdating = false
    var questionToUpdate: QuizQuestion?
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        if isUpdating {
                doneButton.setTitle("Save", for: .normal)
            } else {
                doneButton.setTitle("Done", for: .normal)
            }
    }
    
    func setupView() {
        if isUpdating, let question = questionToUpdate {
            questionField.text = question.question
            correctAnswerField.text = question.correctAnswer
            incorrectAnswer1Field.text = question.incorrectAnswers[0]
            incorrectAnswer2Field.text = question.incorrectAnswers[1]
            incorrectAnswer3Field.text = question.incorrectAnswers[2]
            
            // Set placeholders for update
            questionField.placeholder = "Update your question"
            correctAnswerField.placeholder = "Update correct answer"
            incorrectAnswer1Field.placeholder = "Update first incorrect answer"
            incorrectAnswer2Field.placeholder = "Update second incorrect answer"
            incorrectAnswer3Field.placeholder = "Update third incorrect answer"
        } else {
            // Set placeholders for add
            questionField.placeholder = "Enter a question"
            correctAnswerField.placeholder = "Enter correct answer"
            incorrectAnswer1Field.placeholder = "Enter first incorrect answer"
            incorrectAnswer2Field.placeholder = "Enter second incorrect answer"
            incorrectAnswer3Field.placeholder = "Enter third incorrect answer"
        }
    }

    
    @IBAction func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func doneTapped() {
        guard let question = questionField.text,
              let correct = correctAnswerField.text,
              let incorrect1 = incorrectAnswer1Field.text,
              let incorrect2 = incorrectAnswer2Field.text,
              let incorrect3 = incorrectAnswer3Field.text else { return }
        
        let newQuestion = QuizQuestion(question: question, correctAnswer: correct, incorrectAnswers: [incorrect1, incorrect2, incorrect3])
        saveQuestion?(newQuestion)
        dismiss(animated: true, completion: nil)
    }
}
