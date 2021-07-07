//
//  Habit.swift
//  Simple Habits
//
//  Created by Matthew Gray on 7/6/21.
//

import Foundation

struct Habit: Identifiable {
    var id: UUID
    let name: String
    let emoji: String
    let goalTimes: Int
}
