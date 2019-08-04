/// Абстрактный класс для события.
open class Event<Input> {

    /// Тип для замыкания события.
    public typealias Closure = (Input) -> Void

    internal init() { }

    /// Добавляет нового слушателя для события.
    /// Слушатель добавляется `безопасно` - по ключу.
    /// В качестве ключа по-умолчанию берется путь до файла из которого был вызыван метод.
    /// - Warning: Внутри одного файла для одного события нельзя добавлять несколько слушателей без явного указания ключа.
    ///     В противном случае события будут перезаписаны.
    ///     Если вам необходимо внутри одного файла добавить больше одного слушателя - используйте собственные ключи
    /// - Parameters:
    ///   - key: Ключ для добавления нового слушателя.
    ///   - listner: Слушатель.
    open func add(key: String = #file, _ listner: @escaping Closure) {
        fatalError("\(#function) should be overriden in child class")
    }

    /// Оповещает всех подписчиков данного события.
    ///
    /// - Parameter input: Данные, которые нужно предать подписчикам.
    open func invoke(with input: Input) {
        fatalError("\(#function) should be overriden in child class")
    }

    /// Оповещает конкретного подписчика.
    ///
    /// - Parameters:
    ///   - input: Данные, которые будут переданы подписчику.
    ///   - key: Ключ подписчика, которого нужно оповестить.
    open func invoke(with input: Input, key: String = #file) {
        fatalError("\(#function) should be overriden in child class")
    }

    /// Удаляет всех подписчиков.
    open func clear() {
        fatalError("\(#function) should be overriden in child class")
    }

    /// Удаляет конкретного подписчика.
    /// Ожидается тот же ключ, что ыл добавлен в `add(by key: String = #file, _ listner: @escaping Closure)`
    ///
    /// - Parameter key: Ключ подписчика. По-умолчанию это `#file` так же как и для `addListener`
    open func remove(key: String = #file) {
        fatalError("\(#function) should be overriden in child class")
    }
}

public extension Event where Input == Void {

    /// Синтаксический сахар. Позоляет вызвать слушателей без передачи параметра если `Input == Void`
    func invoke() {
        self.invoke(with: ())
    }
}
