import UIKit

class SignInViewController: UIViewController {
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "ButtonColor")
        
        button.setTitle("Вход", for: .normal)
        button.setTitleColor(UIColor(named: "ColorText"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SF UI Display", size: 18)
        
        button.layer.cornerRadius = 24.5
        
        // - установка тени для кнопки
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 3
        
        return button
    }()
    //MARK: - TextFields
    
    private let passwordTextField = UITextField()
    private let emailTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(signInButton)
        view.addSubview(passwordTextField)
        view.addSubview(emailTextField)
        
        signLayout()
        configureTextFields()
        
        navigationItem.title = "Вход"
        navigationController?.navigationBar.tintColor = UIColor(named: "ViewColor")
    }
    
    //MARK: - Setup Constarints
    private func signLayout() {
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 243),
            emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 47),
            emailTextField.widthAnchor.constraint(equalToConstant: 339),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50),
            passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 47),
            passwordTextField.widthAnchor.constraint(equalToConstant: 339),
            
            
            signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signInButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -273),
            signInButton.widthAnchor.constraint(equalToConstant: 338),
            signInButton.heightAnchor.constraint(equalToConstant: 47)
        ])
        
    }
    
    //MARK: - Configure TextFields
    func configureTextFields() {
        // Configure email, password and repeat password text fields
        configureTextField(emailTextField, placeholder: "Введите ваш email", isSecureTextEntry: false, returnKeyType: .next)
        configureTextField(passwordTextField, placeholder: "Введите ваш пароль", isSecureTextEntry: true, returnKeyType: .done)
    }
    //настройка текстовых полей
    func configureTextField(_ textField: UITextField,
                            placeholder: String,
                            isSecureTextEntry: Bool,
                            returnKeyType: UIReturnKeyType) {
        textField.placeholder = placeholder
        textField.textColor = UIColor(named: "ViewColor")
        textField.font = .systemFont(ofSize: 18)
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = isSecureTextEntry
        textField.keyboardType = isSecureTextEntry ? .default : .emailAddress
        textField.returnKeyType = returnKeyType
        textField.layer.cornerRadius = 24.5
        textField.clipsToBounds = true
        textField.layer.borderColor = UIColor(named: "ViewColor")?.cgColor
        textField.layer.borderWidth = 2.0
    }
}
