import Foundation
import SwiftData

@Model
final class UmrahSession {
    var date: Date
    var lapDurations: [Double]
    var roundDurations: [Double]
    var totalDuration: Double

    init(date: Date, lapDurations: [Double], roundDurations: [Double], totalDuration: Double) {
        self.date = date
        self.lapDurations = lapDurations
        self.roundDurations = roundDurations
        self.totalDuration = totalDuration
    }

    var tawafTotal: Double { lapDurations.reduce(0, +) }
    var saiTotal: Double { roundDurations.reduce(0, +) }
    var avgLap: Double { lapDurations.isEmpty ? 0 : tawafTotal / Double(lapDurations.count) }
    var avgRound: Double { roundDurations.isEmpty ? 0 : saiTotal / Double(roundDurations.count) }

    func formatDuration(_ interval: Double) -> String {
        let m = Int(interval) / 60
        let s = Int(interval) % 60
        return String(format: "%d:%02d", m, s)
    }
}
