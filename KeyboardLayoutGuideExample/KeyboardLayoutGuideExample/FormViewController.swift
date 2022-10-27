import KeyboardLayoutGuide
import UIKit

protocol FormViewControllerDelegate: AnyObject {
    func formViewControllerWillDismiss()
}

final class FormViewController: UIViewController {

    @IBOutlet weak var vStack: UIStackView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var elementHeight: NSLayoutConstraint!
    private weak var delegate: FormViewControllerDelegate?

    static func make(delegate: FormViewControllerDelegate) -> FormViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "FormViewController") as! FormViewController
        vc.delegate = delegate
        vc.modalPresentationStyle = .formSheet
        vc.preferredContentSize = CGSize(width: 500, height: 600)
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        Keyboard.shared.presentedViewController = self
        vStack.bottomAnchor.constraint(lessThanOrEqualTo: view.keyboardLayoutGuideNoSafeArea.topAnchor).isActive = true

        view.addGestureRecognizer(UITapGestureRecognizer(target: textField, action: #selector(resignFirstResponder)))
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        delegate?.formViewControllerWillDismiss()
    }

    @IBAction func handlePan(_ pan: UIPanGestureRecognizer) {
        elementHeight.constant = 50 + pan.translation(in: pan.view).y
    }

}
