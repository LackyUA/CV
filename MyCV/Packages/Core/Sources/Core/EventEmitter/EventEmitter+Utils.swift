//
//  EventEmitter+Utils.swift
//  Core
//
//  Created by Andrii Vysotskyi on 09.07.2025.
//

extension EventEmitter {

    /// Starts observing events emitted by this emitter.
    ///
    /// The handler is called for each incoming event until the returned token is deallocated.
    public func on(@_inheritActorContext handler: @Sendable @escaping (Event) async -> Void) -> AnyObject {
        let task = Task {
            for await event in events {
                await handler(event)
            }
        }
        return TaskCancellable(task: task)
    }
}

private final class TaskCancellable: Sendable {

    init(task: Task<Void, Never>) {
        self.task = task
    }

    deinit {
        task.cancel()
    }

    let task: Task<Void, Never>
}
