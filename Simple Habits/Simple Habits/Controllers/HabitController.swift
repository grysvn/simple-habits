//
//  HabitController.swift
//  Simple Habits
//
//  Created by Matthew Gray on 7/6/21.
//

import Foundation

typealias HabitListViewModelCompletion = (HabitListViewModel) -> Void

class HabitController {
    private var habitProvider: HabitProviding
    private var habitInstanceProvider: HabitInstanceProviding

    init(
        habitProvider: HabitProviding = TestHabitProvider(),
        habitInstanceProvider: HabitInstanceProviding = TestHabitInstanceProvider()
    ) {
        self.habitProvider = habitProvider
        self.habitInstanceProvider = habitInstanceProvider
    }

    func loadHabitListViewModel(for date: Date = Date(), completion: @escaping HabitListViewModelCompletion) {
        let group = DispatchGroup()
        var habitInstances: [HabitInstance]?
        var habits: [Habit]?
        var error: Error?

        group.enter()
        habitInstanceProvider.getHabitInstances(for: DateUtils.gmtDayString(from: date)) { result in
            switch result {
            case .success(let instances):
                habitInstances = instances
            case .failure(let instancesError):
                error = instancesError
            }
            group.leave()
        }

        guard error == nil else {
            completion(HabitListViewModel(error: error, habits: []))
            return
        }

        group.enter()
        habitProvider.getAllHabits { result in
            switch result {
            case .success(let loadedHabits):
                habits = loadedHabits
            case .failure(let habitsError):
                error = habitsError
            }
            group.leave()
        }

        guard error == nil else {
            completion(HabitListViewModel(error: error, habits: []))
            return
        }

        group.notify(queue: DispatchQueue.main) {
            if
                let habits = habits,
                let habitInstances = habitInstances
            {
                let viewModels = habits.map { habit -> HabitViewModel in
                    let relevantInstance = habitInstances.first { instance in
                        instance.habitId == habit.id
                    }
                    return HabitViewModel(id: habit.id, emoji: habit.emoji, name: habit.name, doneTimes: String(relevantInstance?.doneTimes ?? -1), goalTimes: String(habit.goalTimes))
                }
                completion(HabitListViewModel(error: nil, habits: viewModels))
            }
            else {
                completion(HabitListViewModel(error: HabitError(detail: "error loading habits"), habits: []))
            }
        }
    }
}
