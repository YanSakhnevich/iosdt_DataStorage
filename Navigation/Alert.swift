import UIKit

struct Alert {
    private static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .actionSheet
        )
        alert.addAction(UIAlertAction(
            title: "Ok",
            style: .default,
            handler: {action in print("Good, you taped OK button")})
        )
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .destructive,
            handler: {action in print("You taped on CANCEL button, see you soon")})
        )
       
        vc.present(alert, animated: true)
    }
    
    static func showIncompleteFormAlert(on vc: UIViewController) {
        showBasicAlert(on: vc,
                       with: "Incomplete form",
                       message: "Please fill out all fields in the form"
        )
    }
}
