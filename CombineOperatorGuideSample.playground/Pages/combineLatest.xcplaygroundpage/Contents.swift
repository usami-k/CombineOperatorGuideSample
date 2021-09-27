import Combine

let subjectX = PassthroughSubject<String, Never>()
let subjectY = PassthroughSubject<String, Never>()

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
        subjectX
            .combineLatest(subjectY)
            .map { valueX, valueY in
                "X:" + valueX + " Y:" + valueY
            }
            .assign(to: \.value, on: object)
            .store(in: &subscriptions)
    }
}

let receiver = Receiver()
subjectX.send("1")
subjectX.send("2")
subjectY.send("c")
subjectY.send("d")
subjectX.send("5")
