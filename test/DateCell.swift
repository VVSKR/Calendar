import JTAppleCalendar
import UIKit

class DateCell: JTAppleCell {
    @IBOutlet var dateLabel: UILabel!
    
}


class HeaderDateCell: JTAppleCell {

    static var reuseIdentifier: String {
        "HeaderDateCell"
    }
}
