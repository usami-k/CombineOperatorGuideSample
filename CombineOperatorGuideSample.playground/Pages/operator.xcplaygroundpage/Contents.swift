import Combine

let subject = PassthroughSubject<String, Never>()

final class SomeObject {
    var value: String = "" {
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
            .map { $0 + "!" }
            .assign(to: \.value, on: object)
            .store(in: &subscriptions)
    }
}

let receiver = Receiver()
subject.send("あ")
subject.send("い")
subject.send("う")
subject.send("え")
subject.send("お")
