import Observation
import Foundation

@Observable
final class UmrahState {
    var isArabic: Bool = false {
        didSet { UserDefaults.standard.set(isArabic, forKey: "isArabic") }
    }
    var isDarkMode: Bool = false {
        didSet { UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode") }
    }
    var textScale: Double = 1.0 {
        didSet { UserDefaults.standard.set(textScale, forKey: "textScale") }
    }
    var strings: AppStrings { AppStrings(isArabic: isArabic) }

    var stage: Int = 0
    var talbiyahStarted: Bool = false
    var wudu: Bool = false
    var locatedBlackStone: Bool = false
    var raisedHand: Bool = false
    var tawafStarted: Bool = false
    var tawafStartTime: Date? = nil
    var lapTimes: [Date] = []
    var currentLap: Int = 0
    var saiStarted: Bool = false
    var saiStartTime: Date? = nil
    var roundTimes: [Date] = []
    var currentRound: Int = 0
    var umrahStartTime: Date? = nil
    var sessionSaved: Bool = false

    var allTawafChecked: Bool { wudu && locatedBlackStone && raisedHand }
    var tawafComplete: Bool { currentLap == 8 }
    var saiComplete: Bool { currentRound == 8 }

    init() {
        isArabic   = UserDefaults.standard.bool(forKey: "isArabic")
        isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        let ts     = UserDefaults.standard.double(forKey: "textScale")
        textScale  = ts > 0 ? ts : 1.0
        load()
    }

    // MARK: — Navigation

    func startUmrah() {
        umrahStartTime = Date()
        stage = 1
        persist()
    }

    func goToStage(_ s: Int) {
        stage = s
        persist()
    }

    func goBack() {
        guard stage > 0 else { return }
        stage -= 1
        persist()
    }

    func goForward() {
        guard stage < 5 else { return }
        stage += 1
        persist()
    }

    // MARK: — Talbiyah

    func setTalbiyahStarted(_ value: Bool) {
        talbiyahStarted = value
        persist()
    }

    // MARK: — Tawaf checklist

    func setWudu(_ value: Bool) { wudu = value; persist() }
    func setLocatedBlackStone(_ value: Bool) { locatedBlackStone = value; persist() }
    func setRaisedHand(_ value: Bool) { raisedHand = value; persist() }

    func startTawaf() {
        tawafStarted = true
        tawafStartTime = Date()
        currentLap = 1
        persist()
    }

    func completeLap() {
        lapTimes.append(Date())
        currentLap = lapTimes.count < 7 ? lapTimes.count + 1 : 8
        persist()
    }

    // MARK: — Sa'i

    func startSai() {
        saiStarted = true
        saiStartTime = Date()
        currentRound = 1
        persist()
    }

    func completeRound() {
        roundTimes.append(Date())
        currentRound = roundTimes.count < 7 ? roundTimes.count + 1 : 8
        persist()
    }

    func markSessionSaved() {
        sessionSaved = true
        persist()
    }

    func reset() {
        stage = 0
        talbiyahStarted = false
        wudu = false; locatedBlackStone = false; raisedHand = false
        tawafStarted = false; tawafStartTime = nil
        lapTimes = []; currentLap = 0
        saiStarted = false; saiStartTime = nil
        roundTimes = []; currentRound = 0
        umrahStartTime = nil; sessionSaved = false
        UserDefaults.standard.removeObject(forKey: "umrahState")
    }

    // MARK: — Metrics

    func formatDuration(_ interval: TimeInterval) -> String {
        let m = Int(interval) / 60
        let s = Int(interval) % 60
        return String(format: "%d:%02d", m, s)
    }

    struct SessionMetrics {
        let durations: [TimeInterval]
        let average: TimeInterval
        let total: TimeInterval
    }

    func tawafMetrics() -> SessionMetrics? {
        guard let start = tawafStartTime, lapTimes.count == 7 else { return nil }
        var durations: [TimeInterval] = []
        var prev = start
        for t in lapTimes {
            durations.append(t.timeIntervalSince(prev))
            prev = t
        }
        let total = lapTimes[6].timeIntervalSince(start)
        return SessionMetrics(durations: durations, average: total / 7, total: total)
    }

    func saiMetrics() -> SessionMetrics? {
        guard let start = saiStartTime, roundTimes.count == 7 else { return nil }
        var durations: [TimeInterval] = []
        var prev = start
        for t in roundTimes {
            durations.append(t.timeIntervalSince(prev))
            prev = t
        }
        let total = roundTimes[6].timeIntervalSince(start)
        return SessionMetrics(durations: durations, average: total / 7, total: total)
    }

    func umrahTotal() -> TimeInterval? {
        guard let start = umrahStartTime, roundTimes.count == 7 else { return nil }
        return roundTimes[6].timeIntervalSince(start)
    }

    // MARK: — Persistence

    func persist() {
        var d: [String: Any] = [:]
        d["stage"] = stage
        d["talbiyahStarted"] = talbiyahStarted
        d["wudu"] = wudu
        d["locatedBlackStone"] = locatedBlackStone
        d["raisedHand"] = raisedHand
        d["tawafStarted"] = tawafStarted
        if let t = tawafStartTime { d["tawafStartTime"] = t.timeIntervalSince1970 }
        d["lapTimes"] = lapTimes.map { $0.timeIntervalSince1970 }
        d["currentLap"] = currentLap
        d["saiStarted"] = saiStarted
        if let t = saiStartTime { d["saiStartTime"] = t.timeIntervalSince1970 }
        d["roundTimes"] = roundTimes.map { $0.timeIntervalSince1970 }
        d["currentRound"] = currentRound
        if let t = umrahStartTime { d["umrahStartTime"] = t.timeIntervalSince1970 }
        d["sessionSaved"] = sessionSaved
        UserDefaults.standard.set(d, forKey: "umrahState")
    }

    private func load() {
        guard let d = UserDefaults.standard.dictionary(forKey: "umrahState") else { return }
        stage                = d["stage"] as? Int ?? 0
        talbiyahStarted      = d["talbiyahStarted"] as? Bool ?? false
        wudu                 = d["wudu"] as? Bool ?? false
        locatedBlackStone    = d["locatedBlackStone"] as? Bool ?? false
        raisedHand           = d["raisedHand"] as? Bool ?? false
        tawafStarted         = d["tawafStarted"] as? Bool ?? false
        if let t = d["tawafStartTime"] as? Double { tawafStartTime = Date(timeIntervalSince1970: t) }
        lapTimes   = (d["lapTimes"] as? [Double] ?? []).map { Date(timeIntervalSince1970: $0) }
        currentLap = d["currentLap"] as? Int ?? 0
        saiStarted = d["saiStarted"] as? Bool ?? false
        if let t = d["saiStartTime"] as? Double { saiStartTime = Date(timeIntervalSince1970: t) }
        roundTimes   = (d["roundTimes"] as? [Double] ?? []).map { Date(timeIntervalSince1970: $0) }
        currentRound = d["currentRound"] as? Int ?? 0
        if let t = d["umrahStartTime"] as? Double { umrahStartTime = Date(timeIntervalSince1970: t) }
        sessionSaved = d["sessionSaved"] as? Bool ?? false
    }
}
