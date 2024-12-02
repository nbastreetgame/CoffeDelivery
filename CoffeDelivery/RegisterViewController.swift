import UIKit

class RegisterViewController: UIViewController {
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "ButtonColor")
        
        button.setTitle("Регистрация", for: .normal)
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
    private let repeatPasswordTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray6
        view.addSubview(registerButton)
        view.addSubview(passwordTextField)
        view.addSubview(emailTextField)
        view.addSubview(repeatPasswordTextField)
        
        setupRegister()
        setupLayout()
        configureTextFields() // Настройка текстовых полей
        addNavigationBarSeparator()
        
        self.registerButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func setupRegister() {
        navigationItem.title = "Регистрация"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(named: "ViewColor") as Any
        ]
    }
    
    private func setupLayout() {
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        repeatPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // textField constraints
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 243),
            emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 47),
            emailTextField.widthAnchor.constraint(equalToConstant: 339),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50),
            passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 47),
            passwordTextField.widthAnchor.constraint(equalToConstant: 339),
            
            repeatPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 47),
            repeatPasswordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            repeatPasswordTextField.widthAnchor.constraint(equalToConstant: 339),
            
            
            // register button constraints
            registerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            registerButton.bottomAnchor.constraint(equalTo: repeatPasswordTextField.bottomAnchor, constant: 176),
            registerButton.widthAnchor.constraint(equalToConstant: 338),
            registerButton.heightAnchor.constraint(equalToConstant: 47)
        ])
    }
    
    //MARK: - Configure TextFields
    func configureTextFields() {
        // Configure email, password and repeat password text fields
        configureTextField(emailTextField, placeholder: "Введите ваш email", isSecureTextEntry: false, returnKeyType: .next)
        configureTextField(passwordTextField, placeholder: "Введите ваш пароль", isSecureTextEntry: true, returnKeyType: .done)
        configureTextField(repeatPasswordTextField, placeholder: "Повторите ваш пароль", isSecureTextEntry: true, returnKeyType: .done)
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
        textField.delegate = self
        textField.layer.borderColor = UIColor(named: "ViewColor")?.cgColor
        textField.layer.borderWidth = 2.0
    }
    
    //MARK: - Validate password
    func validatePassword(_ password: String?) -> Bool {
        guard let password = password else { return false }
        
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        
        return passwordPred.evaluate(with: password)
    }
    
    func showAlerMessage(_ message: String) {
        let alert = UIAlertController(title: "InvalidPassword",
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alert, animated: true)
    }
    
    @objc func didTapButton() {
        guard let password = passwordTextField.text, password == repeatPasswordTextField.text else {
            showAlerMessage("Пароли не совпдают!")
            
            return
        }
        
        let vc = SignInViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Line UINavigationBar
    private func addNavigationBarSeparator() {
        let separator = UIView()
        separator.backgroundColor = UIColor.lightGray
        
        navigationController?.navigationBar.addSubview(separator)
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: navigationController!.navigationBar.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: navigationController!.navigationBar.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: navigationController!.navigationBar.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}

//MARK: - UITextField Delegate
extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            // Изменено: Переход с email на password при нажатии Return на поле email
            passwordTextField.becomeFirstResponder()
            return true
        } else if textField == passwordTextField {
            if validatePassword(textField.text) {
                textField.resignFirstResponder()
                return true
            } else {
                showAlerMessage("Вы ввели меньше 6 символов")
                return false
            }
        }
        return true
    }
    //MARK: - Ограничения по количеству символов в заполнении пароля
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordTextField || textField == repeatPasswordTextField {
            let currentText = textField.text ?? ""
            
            guard let stringRange = Range(range,  in: currentText) else {
                return false
            }
            
            let updateText = currentText.replacingCharacters(in: stringRange, with: string)
            return updateText.count <= 20
        }
        
        return true
    }
    
}
