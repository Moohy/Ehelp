import Foundation

class Global{
    private init() { }
    static let shared = Global()
    var reports = [ReportViewModel]()
    var users   = [[String:AnyObject]]()
}
