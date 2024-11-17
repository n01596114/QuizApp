import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        print("Navigation Controller available: \(navigationController != nil)")

        super.viewDidLoad()
    }
    
    @IBAction func buildQuestionBankTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let questionBankVC = storyboard.instantiateViewController(withIdentifier: "QuestionBankViewController")

        self.present(questionBankVC, animated: true, completion: nil)
    }
    @IBAction func startQuizTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let quizVC = storyboard.instantiateViewController(withIdentifier: "QuizViewController") as! QuizViewController
        self.present(quizVC, animated: true, completion: nil)
    }
}
