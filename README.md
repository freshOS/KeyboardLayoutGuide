# KeyboardLayoutGuide
⌨️ An alternative approach to handling keyboard in iOS


```swift
import UIKit
import KeyboardLayoutGuide

class ViewController: UIViewController {

    // Create a keyboard layout guide.
    let keyboardLayoutGuide = KeyboardLayoutGuide()

    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the layout guide in the view.
        view.addLayoutGuide(keyboardLayoutGuide)

        // Constrain your button to the keyboardLayoutGuide's top Anchor
        // the way you would do natively :)
        button.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor).isActive = true
    }
}
```
