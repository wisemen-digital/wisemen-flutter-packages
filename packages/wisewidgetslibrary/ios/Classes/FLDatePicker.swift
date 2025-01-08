import Flutter
import UIKit

@available(iOS 13.4, *)
class FLDatePicker: NSObject, FlutterPlatformView {
    private var _view: UIDatePicker
    private var channel: FlutterMethodChannel?
    private var backgroundColor: UIColor?
    private var textColor: UIColor?

    static let inDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter
    }()

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        let argsDict = args as! Dictionary<String, Any>;
        let picker = UIDatePicker(frame: frame)
        picker.preferredDatePickerStyle = .inline
        picker.datePickerMode = UIDatePicker.Mode(rawValue: argsDict["mode"] as! Int)!
        if let dateStr = argsDict["date"] as? String {
            picker.date = FLDatePicker.inDateFormatter.date(from: dateStr) ?? Date()
        }
        if let dateStr = argsDict["minimumDate"] as? String {
            picker.minimumDate = FLDatePicker.inDateFormatter.date(from: dateStr) ?? Date()
        }
        if let dateStr = argsDict["maximumDate"] as? String {
            picker.maximumDate = FLDatePicker.inDateFormatter.date(from: dateStr) ?? Date()
        }
        if let tintColorStr = argsDict["tintColor"] as? String {
            picker.tintColor = UIColor(hexString: tintColorStr)
        }
        if let localeStr = argsDict["locale"] as? String {
            picker.locale = Locale(identifier: localeStr)
        }
        if let fontSize = argsDict["fontSize"] as? CGFloat {
            if let lblView = picker.subviews.first?.subviews.first?.subviews[1] {
                lblView.setValue(UIFont.systemFont(ofSize: fontSize), forKey: "font")
            }
        }
        if let textColorStr = argsDict["textColor"] as? String  {
            if let lblView = picker.subviews.first?.subviews.first?.subviews[1] {
                textColor = UIColor(hexString: textColorStr)
                lblView.setValue(textColor, forKey: "textColor")
            }
        }
        picker.sizeToFit()
        _view = picker
        channel = FlutterMethodChannel(name: "FLDatePicker/\(viewId)", binaryMessenger: messenger!);
        super.init()
        picker.addTarget(self, action: #selector(onChanged), for: .valueChanged)
        picker.addTarget(self, action: #selector(onEndEdit), for: .editingDidEnd)
        channel?.setMethodCallHandler({ call, reault in
            if call.method == "setDate" {
                if let date = call.arguments as? String {
                    self._view.date = FLDatePicker.inDateFormatter.date(from: date) ?? Date()
                }
            }
            if call.method == "setMinDate" {
                if let dateStr = call.arguments as? String {
                    self._view.minimumDate = FLDatePicker.inDateFormatter.date(from: dateStr) ?? Date()
                }
            }
        })

    }

    @objc func onEndEdit(_ sender: UIDatePicker) {
        if textColor != nil, let lblView = sender.subviews.first?.subviews.first?.subviews[1] {
            lblView.setValue(textColor, forKey: "textColor");
        }
    }

    @objc func onChanged(_ sender: UIDatePicker) {
        let dateStr = FLDatePicker.inDateFormatter.string(from: sender.date)
        channel?.invokeMethod("onChanged", arguments: dateStr)
        if backgroundColor != nil, let bgView = sender.subviews.first?.subviews.first?.subviews.first {
            bgView.backgroundColor = backgroundColor
        }
    }

    func view() -> UIView {
        return _view
    }
}
