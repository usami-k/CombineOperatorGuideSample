import Combine

let subject = PassthroughSubject<Int, Never>()

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
            .filter { $0 % 2 == 1 }
            .assign(to: \.value, on: object)
            .store(in: &subscriptions)
    }
}

let receiver = Receiver()
subject.send(1)
subject.send(2)
subject.send(3)
subject.send(4)
subject.send(5)
