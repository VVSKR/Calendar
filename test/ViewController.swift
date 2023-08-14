import UIKit
import JTAppleCalendar

class ViewController: UIViewController {

    private lazy var calendarView: JTACMonthView = {
        let calendarView = JTACMonthView()
//        calendarView.backgroundColor = .certainWhite
//        calendarView.minimumLineSpacing = Consts.lineSpacing / 2
//        calendarView.minimumInteritemSpacing = 0
        calendarView.sectionInset = .zero
        calendarView.scrollDirection = .vertical
        calendarView.cellSize = 50
//        calendarView.contentInset.bottom = calendarContentInset.bottom // TODO: VS FIX
        calendarView.showsVerticalScrollIndicator = false
        calendarView.alwaysBounceVertical = false
        calendarView.scrollingMode = .none
        calendarView.allowsMultipleSelection = true
        calendarView.allowsRangedSelection = true

        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self

        calendarView.register(DateCell.self, forCellWithReuseIdentifier: DateCell.reuseIdentifier)
        calendarView.register(HeaderDateCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderDateCell.reuseIdentifier)
//        calendarView.register(FooterDateCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterDateCell.reuseIdentifier)
        return calendarView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(calendarView)
        calendarView.backgroundColor = .lightGray
        calendarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            calendarView.heightAnchor.constraint(equalToConstant: 400)
        ])
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
    }
}

extension ViewController: JTACMonthViewDataSource {
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"

        let startDate = formatter.date(from: "2023 05 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
}

extension ViewController: JTACMonthViewDelegate {

    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: DateCell.reuseIdentifier, for: indexPath) as! DateCell
        if cellState.dateBelongsTo == .thisMonth {
            cell.label.text = cellState.text
        } else {
            cell.label.text = ""
        }
        cell.backgroundColor = .darkGray
        return cell
    }

    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = cell as! DateCell
        cell.backgroundColor = .darkGray
        cell.label.text = cellState.text
    }

    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let headerUntyped = calendar.dequeueReusableJTAppleSupplementaryView(
            withReuseIdentifier: HeaderDateCell.reuseIdentifier,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            for: indexPath
        )
        guard let header = headerUntyped as? HeaderDateCell else {
            return JTACMonthReusableView()
        }
        header.backgroundColor = .gray
        return header
    }

    func calendarHeaderSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        .init(defaultSize: 50, months: [70 : [.jul]])
    }

    func calendar(_ calendar: JTACMonthView, footerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let footerUntyped = calendar.dequeueReusableJTAppleSupplementaryView(
            withReuseIdentifier: FooterDateCell.reuseIdentifier,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            for: indexPath
        )

        guard let footer = footerUntyped as? FooterDateCell else {
            return JTACMonthReusableView()
        }
        footer.backgroundColor = .green
        return footer
    }

    func calendarFooterSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        .init(defaultSize: 50, months: [100 : [.jul]])
    }
}




