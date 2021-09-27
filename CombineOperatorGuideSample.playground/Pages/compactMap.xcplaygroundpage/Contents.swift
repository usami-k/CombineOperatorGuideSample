import Combine

let subject = PassthroughSubject<String, Never>()

final class SomeObject {
    var value: Int = -1 {
        didSet {
            print("didSet value:", value)
        }
    }
}

final class Receiver {
    private var subscriptions = Set<AnyCancellable>()
    private let object = SomeObject()

    init() {
        subject
            .compactMap { Int($0) }
            .assign(to: \.value, on: object)
            .store(in: &subscriptions)
    }
}

let receiver = Receiver()
subject.send("1")
subject.send("2")
subject.send("x")
subject.send("4")
subject.send("5")
