// MARK: - Mocks generated from file: '../Sources/Domain/Controller/LocalizationController.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi

class MockLocalizationController: LocalizationController, Cuckoo.ProtocolMock, @unchecked Sendable {
    typealias MocksType = LocalizationController
    typealias Stubbing = __StubbingProxy_LocalizationController
    typealias Verification = __VerificationProxy_LocalizationController

    // Original typealiases

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any LocalizationController)?

    func enableDefaultImplementation(_ stub: any LocalizationController) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    
    func get(with p0: LocalizableKey, args p1: [String]) -> String {
        return cuckoo_manager.call(
            "get(with p0: LocalizableKey, args p1: [String]) -> String",
            parameters: (p0, p1),
            escapingParameters: (p0, p1),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.get(with: p0, args: p1)
        )
    }
    
    func get(with p0: LocalizableKey, args p1: [String]) -> LocalizedStringKey {
        return cuckoo_manager.call(
            "get(with p0: LocalizableKey, args p1: [String]) -> LocalizedStringKey",
            parameters: (p0, p1),
            escapingParameters: (p0, p1),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.get(with: p0, args: p1)
        )
    }

    struct __StubbingProxy_LocalizationController: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        func get<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(with p0: M1, args p1: M2) -> Cuckoo.ProtocolStubFunction<(LocalizableKey, [String]), String> where M1.MatchedType == LocalizableKey, M2.MatchedType == [String] {
            let matchers: [Cuckoo.ParameterMatcher<(LocalizableKey, [String])>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockLocalizationController.self,
                method: "get(with p0: LocalizableKey, args p1: [String]) -> String",
                parameterMatchers: matchers
            ))
        }
        
        func get<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(with p0: M1, args p1: M2) -> Cuckoo.ProtocolStubFunction<(LocalizableKey, [String]), LocalizedStringKey> where M1.MatchedType == LocalizableKey, M2.MatchedType == [String] {
            let matchers: [Cuckoo.ParameterMatcher<(LocalizableKey, [String])>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockLocalizationController.self,
                method: "get(with p0: LocalizableKey, args p1: [String]) -> LocalizedStringKey",
                parameterMatchers: matchers
            ))
        }
    }

    struct __VerificationProxy_LocalizationController: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        
        @discardableResult
        func get<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(with p0: M1, args p1: M2) -> Cuckoo.__DoNotUse<(LocalizableKey, [String]), String> where M1.MatchedType == LocalizableKey, M2.MatchedType == [String] {
            let matchers: [Cuckoo.ParameterMatcher<(LocalizableKey, [String])>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }]
            return cuckoo_manager.verify(
                "get(with p0: LocalizableKey, args p1: [String]) -> String",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func get<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(with p0: M1, args p1: M2) -> Cuckoo.__DoNotUse<(LocalizableKey, [String]), LocalizedStringKey> where M1.MatchedType == LocalizableKey, M2.MatchedType == [String] {
            let matchers: [Cuckoo.ParameterMatcher<(LocalizableKey, [String])>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }]
            return cuckoo_manager.verify(
                "get(with p0: LocalizableKey, args p1: [String]) -> LocalizedStringKey",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
    }
}

class LocalizationControllerStub:LocalizationController, @unchecked Sendable {


    
    func get(with p0: LocalizableKey, args p1: [String]) -> String {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
    func get(with p0: LocalizableKey, args p1: [String]) -> LocalizedStringKey {
        return DefaultValueRegistry.defaultValue(for: (LocalizedStringKey).self)
    }
}




// MARK: - Mocks generated from file: '../Sources/Domain/DI/Graph/DIGraph.swift'

import Cuckoo
import Swinject
@testable import EudiRQESUi

class MockDIGraphType: DIGraphType, Cuckoo.ProtocolMock, @unchecked Sendable {
    typealias MocksType = DIGraphType
    typealias Stubbing = __StubbingProxy_DIGraphType
    typealias Verification = __VerificationProxy_DIGraphType

    // Original typealiases

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any DIGraphType)?

    func enableDefaultImplementation(_ stub: any DIGraphType) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    
    var assembler: Assembler {
        get {
            return cuckoo_manager.getter(
                "assembler",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.assembler
            )
        }
    }

    
    func lazyLoad(with p0: [Assembly]) {
        return cuckoo_manager.call(
            "lazyLoad(with p0: [Assembly])",
            parameters: (p0),
            escapingParameters: (p0),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.lazyLoad(with: p0)
        )
    }

    struct __StubbingProxy_DIGraphType: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var assembler: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDIGraphType,Assembler> {
            return .init(manager: cuckoo_manager, name: "assembler")
        }
        
        func lazyLoad<M1: Cuckoo.Matchable>(with p0: M1) -> Cuckoo.ProtocolStubNoReturnFunction<([Assembly])> where M1.MatchedType == [Assembly] {
            let matchers: [Cuckoo.ParameterMatcher<([Assembly])>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockDIGraphType.self,
                method: "lazyLoad(with p0: [Assembly])",
                parameterMatchers: matchers
            ))
        }
    }

    struct __VerificationProxy_DIGraphType: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        var assembler: Cuckoo.VerifyReadOnlyProperty<Assembler> {
            return .init(manager: cuckoo_manager, name: "assembler", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        @discardableResult
        func lazyLoad<M1: Cuckoo.Matchable>(with p0: M1) -> Cuckoo.__DoNotUse<([Assembly]), Void> where M1.MatchedType == [Assembly] {
            let matchers: [Cuckoo.ParameterMatcher<([Assembly])>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "lazyLoad(with p0: [Assembly])",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
    }
}

class DIGraphTypeStub:DIGraphType, @unchecked Sendable {
    
    var assembler: Assembler {
        get {
            return DefaultValueRegistry.defaultValue(for: (Assembler).self)
        }
    }


    
    func lazyLoad(with p0: [Assembly]) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
}




// MARK: - Mocks generated from file: '../Sources/Domain/Entities/Error/EudiRQESUiError.swift'

import Cuckoo
import Foundation
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Domain/Entities/Localization/LocalizableKey.swift'

import Cuckoo
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Domain/Extension/Resolver+Extensions.swift'

import Cuckoo
import Swinject
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Domain/Extension/String+Extensions.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Infrastructure/Config/EudiRQESUiConfig.swift'

import Cuckoo
import Foundation
@testable import EudiRQESUi

public class MockEudiRQESUiConfig: EudiRQESUiConfig, Cuckoo.ProtocolMock, @unchecked Sendable {
    public typealias MocksType = EudiRQESUiConfig
    public typealias Stubbing = __StubbingProxy_EudiRQESUiConfig
    public typealias Verification = __VerificationProxy_EudiRQESUiConfig

    // Original typealiases

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any EudiRQESUiConfig)?

    public func enableDefaultImplementation(_ stub: any EudiRQESUiConfig) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    
    public var qtsps: [URL] {
        get {
            return cuckoo_manager.getter(
                "qtsps",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.qtsps
            )
        }
    }
    
    public var translations: [String: [LocalizableKey: String]] {
        get {
            return cuckoo_manager.getter(
                "translations",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.translations
            )
        }
    }


    public struct __StubbingProxy_EudiRQESUiConfig: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var qtsps: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockEudiRQESUiConfig,[URL]> {
            return .init(manager: cuckoo_manager, name: "qtsps")
        }
        
        var translations: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockEudiRQESUiConfig,[String: [LocalizableKey: String]]> {
            return .init(manager: cuckoo_manager, name: "translations")
        }
    }

    public struct __VerificationProxy_EudiRQESUiConfig: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        var qtsps: Cuckoo.VerifyReadOnlyProperty<[URL]> {
            return .init(manager: cuckoo_manager, name: "qtsps", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var translations: Cuckoo.VerifyReadOnlyProperty<[String: [LocalizableKey: String]]> {
            return .init(manager: cuckoo_manager, name: "translations", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
    }
}

public class EudiRQESUiConfigStub:EudiRQESUiConfig, @unchecked Sendable {
    
    public var qtsps: [URL] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([URL]).self)
        }
    }
    
    public var translations: [String: [LocalizableKey: String]] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String: [LocalizableKey: String]]).self)
        }
    }


}




// MARK: - Mocks generated from file: '../Sources/Infrastructure/EudiRQESUi.swift'

import Cuckoo
import UIKit
@testable import EudiRQESUi

