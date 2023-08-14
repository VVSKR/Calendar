import JTAppleCalendar
import UIKit

class DateCell: JTACDayCell {

    static var reuseIdentifier: String {
        "DateCell"
    }

    lazy var label: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        label.frame = bounds

    }
}


class HeaderDateCell: JTACMonthReusableView {

    static var reuseIdentifier: String {
        "HeaderDateCell"
    }
}


class FooterDateCell: JTACMonthReusableView {

    static var reuseIdentifier: String {
        "FooterDateCell"
    }
}
