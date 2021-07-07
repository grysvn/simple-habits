//
//  HabitProviding.swift
//  Simple Habits
//
//  Created by Matthew Gray on 7/6/21.
//

import Foundation

typealias HabitCompletion = (Result<[Habit], Error>) -> Void

protocol HabitProviding {
    func getAllHabits(_ completion: HabitCompletion)
    func addHabit(request: CreateHabitRequest, _ completion: HabitCompletion)
    func removeHabit(uuid: UUID, _ completion: HabitCompletion)
}

struct HabitError: Error {
    let detail: String
}

class TestHabitProvider: HabitProviding {

    static var habitId1 = UUID()
    static var habitId2 = UUID()

    var habits: [Habit]

    init() {
        habits = [
            Habit(id: TestHabitProvider.habitId1, name: "Drink Water", emoji: "💦", goalTimes: 1),
            Habit(id: TestHabitProvider.habitId2, name: "Make Money", emoji: "🤑", goalTimes: 1)
        ]
    }

    func getAllHabits(_ completion: HabitCompletion) {
        completion(.success(self.habits))
    }

    func addHabit(request: CreateHabitRequest, _ completion: HabitCompletion) {
        habits.append(request.toHabit())

        getAllHabits(completion)
    }

    func removeHabit(uuid: UUID, _ completion: HabitCompletion) {
        habits.removeAll { h in
            h.id == uuid
        }

        getAllHabits(completion)
    }
}
