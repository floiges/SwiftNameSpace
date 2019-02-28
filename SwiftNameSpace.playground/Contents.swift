import UIKit

var str = "Hello, playground"

// 类型协议
protocol TypeWrapperProtocol {
    associatedtype WrappedType
    var wrappedValue: WrappedType { get }
    init(value: WrappedType)
}

struct NamespaceWrapper<T>: TypeWrapperProtocol {
    let wrappedValue: T
    init(value: WrappedType) {
        self.wrappedValue = value
    }
}

// 命名空间协议
// 代表了支持 namespace形式的扩展
protocol NamespaceWrappable {
    associatedtype WrappperType
    var jx: WrappperType { get }
    static var jx: WrappperType.Type { get }
}

// 提供协议的默认实现
extension NamespaceWrappable {
    var jx: NamespaceWrapper<Self> {
        return NamespaceWrapper(value: self)
    }
    static var jx: NamespaceWrapper<Self>.Type {
        return NamespaceWrapper.self
    }
}

extension UIColor: NamespaceWrappable {}

// 扩展协议
extension TypeWrapperProtocol where WrappedType == UIColor {
    // 用自身颜色生成UIImage
    var image: UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(wrappedValue.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
}

let image = UIColor.blue.jx.image
