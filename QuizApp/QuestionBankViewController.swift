import UIKit

class QuestionBankViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var questionBank: [QuizQuestion] {
        get { QuestionBankManager.shared.questionBank }
        set { QuestionBankManager.shared.questionBank = newValue }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addQuestion))
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func addQuestion() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let builderVC = storyboard.instantiateViewController(withIdentifier: "QuestionBuilderViewController") as! QuestionBuilderViewController
        builderVC.saveQuestion = { [weak self] question in
            self?.questionBank.append(question)
            self?.tableView.reloadData()
        }
        self.present(builderVC, animated: true, completion: nil)
    }
}

extension QuestionBankViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionBank.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
        cell.textLabel?.text = questionBank[indexPath.row].question
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedQuestion = questionBank[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let builderVC = storyboard.instantiateViewController(withIdentifier: "QuestionBuilderViewController") as! QuestionBuilderViewController
        
        builderVC.isUpdating = true
        builderVC.questionToUpdate = selectedQuestion
        builderVC.saveQuestion = { [weak self] question in
            self?.questionBank[indexPath.row] = question
            self?.tableView.reloadData()
        }
        
        self.present(builderVC, animated: true, completion: nil)
    }
}
