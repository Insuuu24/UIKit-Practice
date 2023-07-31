

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let dateCalenderView = UICalendarView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        //$0.wantsDateDecorations = true  // 기본값은 true이고 달력 Custom 하기 위해 설정해야 하는 속성
        $0.locale = Locale(identifier: Locale.current.identifier)
        $0.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        $0.fontDesign = .rounded
        $0.tintColor = .systemTeal
        
        
    }
    
    var selectedDate: DateComponents? = nil
    
    
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        dateCalenderView.delegate = self
        
        setupLayout()
        
    }

    
    
    
    // MARK: - Setup Layout
    
    func setupLayout() {
        
        view.addSubview(dateCalenderView)
        dateCalenderView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(300)
        }
    }
    

    
    
    // MARK: - Method & Action
    
    fileprivate func setCalendar() {
        dateCalenderView.delegate = self

        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        dateCalenderView.selectionBehavior = dateSelection
    }
    
    func reloadDateView(date: Date?) {
        if date == nil { return }
        let calendar = Calendar.current
        dateCalenderView.reloadDecorations(forDateComponents: [calendar.dateComponents([.day, .month, .year], from: date!)], animated: true)
    }
    
    
    
}


    // MARK: - UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate


extension ViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {

    // UICalendarView
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        if let selectedDate = selectedDate, selectedDate == dateComponents {
            return .customView {
                let label = UILabel()
                label.text = "🐶"
                label.textAlignment = .center
                return label
            }
        }
        return nil
    }
    
    // 달력에서 날짜 선택했을 경우
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        selection.setSelected(dateComponents, animated: true)
        selectedDate = dateComponents
        reloadDateView(date: Calendar.current.date(from: dateComponents!))
    }



}
