# KeyboardLayoutGuide
⌨️ An alternative approach to handling keyboard in iOS


```swift
import UIKit
import KeyboardLayoutGuide

class ViewController: UIViewController {

    // 1. Create a keyboard helper.
    let keyboard = Keyboard()

    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 2. Initialize the layout guide in my view.
        keyboard.setUpLayoutGuide(inView: view)

        // 3. Constrain your button to the keyboard top Anchor
        // the way you would do natively :)
        button.bottomAnchor.constraint(equalTo: keyboard.topAnchor).isActive = true
    }
}
```
