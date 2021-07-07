//
//  HabitInstanceProviding.swift
//  Simple Habits
//
//  Created by Matthew Gray on 7/6/21.
//

import Foundation

typealias HabitInstanceCompletion = (Result<[HabitInstance], Error>) -> Void

protocol HabitInstanceProviding {
    func getHabitInstances(for habitId: UUID, _ completion: HabitInstanceCompletion)
    func getHabitInstances(for day: String, _ completion: HabitInstanceCompletion)
    func createHabitInstanceIfNeeded(for habitId: UUID, on day: String, _ completion: HabitInstanceCompletion)
}

struct HabitInstanceError: Error {
    let detail: String
}

class TestHabitInstanceProvider: HabitInstanceProviding {

    var habitInstances: [HabitInstance]

    init() {
        habitInstances = [
            HabitInstance(habitId: TestHabitProvider.habitId1, day: DateUtils.gmtDayString(from: Date()), doneTimes: 0),
            HabitInstance(habitId: TestHabitProvider.habitId2, day: DateUtils.gmtDayString(from: Date()), doneTimes: 0)
        ]
    }

    func getHabitInstances(for habitId: UUID, _ completion: HabitInstanceCompletion) {
        let instancesForHabit = habitInstances.filter { habitInstance in
            habitInstance.habitId == habitId
        }

        completion(.success(instancesForHabit))
    }

    func getHabitInstances(for day: String, _ completion: HabitInstanceCompletion) {
        let instancesForDay = habitInstances.filter { habitInstance in
            habitInstance.day == day
        }

        completion(.success(instancesForDay))
    }

    func createHabitInstanceIfNeeded(for habitId: UUID, on day: String, _ completion: HabitInstanceCompletion) {
        habitInstances.append(
            HabitInstance(
                habitId: habitId,
                day: day, doneTimes: 0)
        )

        getHabitInstances(for: habitId, completion)
    }
}
