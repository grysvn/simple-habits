//
//  CreateHabitRequest.swift
//  Simple Habits
//
//  Created by Matthew Gray on 7/6/21.
//

import Foundation

struct CreateHabitRequest {
    let name: String
    let emoji: String
    let goalTimes: Int
}

extension CreateHabitRequest {
    func toHabit() -> Habit {
        return Habit(id: UUID(), name: self.name, emoji: self.emoji, goalTimes: self.goalTimes)
    }
}
