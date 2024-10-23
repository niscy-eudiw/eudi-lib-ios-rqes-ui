// MARK: - Mocks generated from file: 'Sources/Domain/Controller/LocalizationController.swift'

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




// MARK: - Mocks generated from file: 'Sources/Domain/Controller/LogController.swift'

import Cuckoo
@testable import EudiRQESUi

class MockLogController: LogController, Cuckoo.ProtocolMock, @unchecked Sendable {
    typealias MocksType = LogController
    typealias Stubbing = __StubbingProxy_LogController
    typealias Verification = __VerificationProxy_LogController

    // Original typealiases

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any LogController)?

    func enableDefaultImplementation(_ stub: any LogController) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    
    func log(_ p0: Error) {
        return cuckoo_manager.call(
            "log(_ p0: Error)",
            parameters: (p0),
            escapingParameters: (p0),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.log(p0)
        )
    }
    
    func log(_ p0: String) {
        return cuckoo_manager.call(
            "log(_ p0: String)",
            parameters: (p0),
            escapingParameters: (p0),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.log(p0)
        )
    }

    struct __StubbingProxy_LogController: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        func log<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Error)> where M1.MatchedType == Error {
            let matchers: [Cuckoo.ParameterMatcher<(Error)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockLogController.self,
                method: "log(_ p0: Error)",
                parameterMatchers: matchers
            ))
        }
        
        func log<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockLogController.self,
                method: "log(_ p0: String)",
                parameterMatchers: matchers
            ))
        }
    }

    struct __VerificationProxy_LogController: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        
        @discardableResult
        func log<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.__DoNotUse<(Error), Void> where M1.MatchedType == Error {
            let matchers: [Cuckoo.ParameterMatcher<(Error)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "log(_ p0: Error)",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func log<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "log(_ p0: String)",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
    }
}

class LogControllerStub:LogController, @unchecked Sendable {


    
    func log(_ p0: Error) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    func log(_ p0: String) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
}




// MARK: - Mocks generated from file: 'Sources/Domain/Controller/PreferencesController.swift'

import Cuckoo
@testable import EudiRQESUi

class MockPreferencesController: PreferencesController, Cuckoo.ProtocolMock, @unchecked Sendable {
    typealias MocksType = PreferencesController
    typealias Stubbing = __StubbingProxy_PreferencesController
    typealias Verification = __VerificationProxy_PreferencesController

    // Original typealiases

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any PreferencesController)?

    func enableDefaultImplementation(_ stub: any PreferencesController) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    
    func setValue(_ p0: Any?, forKey p1: Prefs.Key) {
        return cuckoo_manager.call(
            "setValue(_ p0: Any?, forKey p1: Prefs.Key)",
            parameters: (p0, p1),
            escapingParameters: (p0, p1),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.setValue(p0, forKey: p1)
        )
    }
    
    func getString(forKey p0: Prefs.Key) -> String? {
        return cuckoo_manager.call(
            "getString(forKey p0: Prefs.Key) -> String?",
            parameters: (p0),
            escapingParameters: (p0),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.getString(forKey: p0)
        )
    }
    
    func getOptionalString(forKey p0: Prefs.Key) -> String {
        return cuckoo_manager.call(
            "getOptionalString(forKey p0: Prefs.Key) -> String",
            parameters: (p0),
            escapingParameters: (p0),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.getOptionalString(forKey: p0)
        )
    }
    
    func getBool(forKey p0: Prefs.Key) -> Bool {
        return cuckoo_manager.call(
            "getBool(forKey p0: Prefs.Key) -> Bool",
            parameters: (p0),
            escapingParameters: (p0),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.getBool(forKey: p0)
        )
    }
    
    func getFloat(forKey p0: Prefs.Key) -> Float {
        return cuckoo_manager.call(
            "getFloat(forKey p0: Prefs.Key) -> Float",
            parameters: (p0),
            escapingParameters: (p0),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.getFloat(forKey: p0)
        )
    }
    
    func getInt(forKey p0: Prefs.Key) -> Int {
        return cuckoo_manager.call(
            "getInt(forKey p0: Prefs.Key) -> Int",
            parameters: (p0),
            escapingParameters: (p0),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.getInt(forKey: p0)
        )
    }
    
    func remove(forKey p0: Prefs.Key) {
        return cuckoo_manager.call(
            "remove(forKey p0: Prefs.Key)",
            parameters: (p0),
            escapingParameters: (p0),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.remove(forKey: p0)
        )
    }
    
    func getValue(forKey p0: Prefs.Key) -> Any? {
        return cuckoo_manager.call(
            "getValue(forKey p0: Prefs.Key) -> Any?",
            parameters: (p0),
            escapingParameters: (p0),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.getValue(forKey: p0)
        )
    }

    struct __StubbingProxy_PreferencesController: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        func setValue<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable>(_ p0: M1, forKey p1: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(Any?, Prefs.Key)> where M1.OptionalMatchedType == Any, M2.MatchedType == Prefs.Key {
            let matchers: [Cuckoo.ParameterMatcher<(Any?, Prefs.Key)>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreferencesController.self,
                method: "setValue(_ p0: Any?, forKey p1: Prefs.Key)",
                parameterMatchers: matchers
            ))
        }
        
        func getString<M1: Cuckoo.Matchable>(forKey p0: M1) -> Cuckoo.ProtocolStubFunction<(Prefs.Key), String?> where M1.MatchedType == Prefs.Key {
            let matchers: [Cuckoo.ParameterMatcher<(Prefs.Key)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreferencesController.self,
                method: "getString(forKey p0: Prefs.Key) -> String?",
                parameterMatchers: matchers
            ))
        }
        
        func getOptionalString<M1: Cuckoo.Matchable>(forKey p0: M1) -> Cuckoo.ProtocolStubFunction<(Prefs.Key), String> where M1.MatchedType == Prefs.Key {
            let matchers: [Cuckoo.ParameterMatcher<(Prefs.Key)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreferencesController.self,
                method: "getOptionalString(forKey p0: Prefs.Key) -> String",
                parameterMatchers: matchers
            ))
        }
        
        func getBool<M1: Cuckoo.Matchable>(forKey p0: M1) -> Cuckoo.ProtocolStubFunction<(Prefs.Key), Bool> where M1.MatchedType == Prefs.Key {
            let matchers: [Cuckoo.ParameterMatcher<(Prefs.Key)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreferencesController.self,
                method: "getBool(forKey p0: Prefs.Key) -> Bool",
                parameterMatchers: matchers
            ))
        }
        
        func getFloat<M1: Cuckoo.Matchable>(forKey p0: M1) -> Cuckoo.ProtocolStubFunction<(Prefs.Key), Float> where M1.MatchedType == Prefs.Key {
            let matchers: [Cuckoo.ParameterMatcher<(Prefs.Key)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreferencesController.self,
                method: "getFloat(forKey p0: Prefs.Key) -> Float",
                parameterMatchers: matchers
            ))
        }
        
        func getInt<M1: Cuckoo.Matchable>(forKey p0: M1) -> Cuckoo.ProtocolStubFunction<(Prefs.Key), Int> where M1.MatchedType == Prefs.Key {
            let matchers: [Cuckoo.ParameterMatcher<(Prefs.Key)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreferencesController.self,
                method: "getInt(forKey p0: Prefs.Key) -> Int",
                parameterMatchers: matchers
            ))
        }
        
        func remove<M1: Cuckoo.Matchable>(forKey p0: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Prefs.Key)> where M1.MatchedType == Prefs.Key {
            let matchers: [Cuckoo.ParameterMatcher<(Prefs.Key)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreferencesController.self,
                method: "remove(forKey p0: Prefs.Key)",
                parameterMatchers: matchers
            ))
        }
        
        func getValue<M1: Cuckoo.Matchable>(forKey p0: M1) -> Cuckoo.ProtocolStubFunction<(Prefs.Key), Any?> where M1.MatchedType == Prefs.Key {
            let matchers: [Cuckoo.ParameterMatcher<(Prefs.Key)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockPreferencesController.self,
                method: "getValue(forKey p0: Prefs.Key) -> Any?",
                parameterMatchers: matchers
            ))
        }
    }

    struct __VerificationProxy_PreferencesController: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        
        @discardableResult
        func setValue<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable>(_ p0: M1, forKey p1: M2) -> Cuckoo.__DoNotUse<(Any?, Prefs.Key), Void> where M1.OptionalMatchedType == Any, M2.MatchedType == Prefs.Key {
            let matchers: [Cuckoo.ParameterMatcher<(Any?, Prefs.Key)>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }]
            return cuckoo_manager.verify(
                "setValue(_ p0: Any?, forKey p1: Prefs.Key)",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func getString<M1: Cuckoo.Matchable>(forKey p0: M1) -> Cuckoo.__DoNotUse<(Prefs.Key), String?> where M1.MatchedType == Prefs.Key {
            let matchers: [Cuckoo.ParameterMatcher<(Prefs.Key)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "getString(forKey p0: Prefs.Key) -> String?",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func getOptionalString<M1: Cuckoo.Matchable>(forKey p0: M1) -> Cuckoo.__DoNotUse<(Prefs.Key), String> where M1.MatchedType == Prefs.Key {
            let matchers: [Cuckoo.ParameterMatcher<(Prefs.Key)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "getOptionalString(forKey p0: Prefs.Key) -> String",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func getBool<M1: Cuckoo.Matchable>(forKey p0: M1) -> Cuckoo.__DoNotUse<(Prefs.Key), Bool> where M1.MatchedType == Prefs.Key {
            let matchers: [Cuckoo.ParameterMatcher<(Prefs.Key)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "getBool(forKey p0: Prefs.Key) -> Bool",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func getFloat<M1: Cuckoo.Matchable>(forKey p0: M1) -> Cuckoo.__DoNotUse<(Prefs.Key), Float> where M1.MatchedType == Prefs.Key {
            let matchers: [Cuckoo.ParameterMatcher<(Prefs.Key)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "getFloat(forKey p0: Prefs.Key) -> Float",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func getInt<M1: Cuckoo.Matchable>(forKey p0: M1) -> Cuckoo.__DoNotUse<(Prefs.Key), Int> where M1.MatchedType == Prefs.Key {
            let matchers: [Cuckoo.ParameterMatcher<(Prefs.Key)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "getInt(forKey p0: Prefs.Key) -> Int",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func remove<M1: Cuckoo.Matchable>(forKey p0: M1) -> Cuckoo.__DoNotUse<(Prefs.Key), Void> where M1.MatchedType == Prefs.Key {
            let matchers: [Cuckoo.ParameterMatcher<(Prefs.Key)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "remove(forKey p0: Prefs.Key)",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func getValue<M1: Cuckoo.Matchable>(forKey p0: M1) -> Cuckoo.__DoNotUse<(Prefs.Key), Any?> where M1.MatchedType == Prefs.Key {
            let matchers: [Cuckoo.ParameterMatcher<(Prefs.Key)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "getValue(forKey p0: Prefs.Key) -> Any?",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
    }
}

class PreferencesControllerStub:PreferencesController, @unchecked Sendable {


    
    func setValue(_ p0: Any?, forKey p1: Prefs.Key) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    func getString(forKey p0: Prefs.Key) -> String? {
        return DefaultValueRegistry.defaultValue(for: (String?).self)
    }
    
    func getOptionalString(forKey p0: Prefs.Key) -> String {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
    func getBool(forKey p0: Prefs.Key) -> Bool {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
    func getFloat(forKey p0: Prefs.Key) -> Float {
        return DefaultValueRegistry.defaultValue(for: (Float).self)
    }
    
    func getInt(forKey p0: Prefs.Key) -> Int {
        return DefaultValueRegistry.defaultValue(for: (Int).self)
    }
    
    func remove(forKey p0: Prefs.Key) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    func getValue(forKey p0: Prefs.Key) -> Any? {
        return DefaultValueRegistry.defaultValue(for: (Any?).self)
    }
}




// MARK: - Mocks generated from file: 'Sources/Domain/DI/Graph/DIGraph.swift'

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

    
    func load() {
        return cuckoo_manager.call(
            "load()",
            parameters: (),
            escapingParameters: (),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.load()
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
        
        func load() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockDIGraphType.self,
                method: "load()",
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
        func load() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "load()",
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


    
    func load() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
}




// MARK: - Mocks generated from file: 'Sources/Domain/Entities/Error/EudiRQESUiError.swift'

import Cuckoo
import Foundation
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Domain/Entities/Localization/LocalizableKey.swift'

import Cuckoo
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Domain/Extension/Notification+Extension.swift'

import Cuckoo
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Domain/Extension/Resolver+Extensions.swift'

import Cuckoo
import Swinject
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Domain/Extension/String+Extensions.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Domain/Extension/UIApplication+Extensions.swift'

import Cuckoo
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Domain/Extension/View+Extensions.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Infrastructure/Config/EudiRQESUiConfig.swift'

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
    
    public var rssps: [URL] {
        get {
            return cuckoo_manager.getter(
                "rssps",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.rssps
            )
        }
    }
    
    public var redirectUrl: URL? {
        get {
            return cuckoo_manager.getter(
                "redirectUrl",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.redirectUrl
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
    
    public var printLogs: Bool {
        get {
            return cuckoo_manager.getter(
                "printLogs",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.printLogs
            )
        }
    }


    public struct __StubbingProxy_EudiRQESUiConfig: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var rssps: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockEudiRQESUiConfig,[URL]> {
            return .init(manager: cuckoo_manager, name: "rssps")
        }
        
        var redirectUrl: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockEudiRQESUiConfig,URL?> {
            return .init(manager: cuckoo_manager, name: "redirectUrl")
        }
        
        var translations: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockEudiRQESUiConfig,[String: [LocalizableKey: String]]> {
            return .init(manager: cuckoo_manager, name: "translations")
        }
        
        var printLogs: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockEudiRQESUiConfig,Bool> {
            return .init(manager: cuckoo_manager, name: "printLogs")
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
        
        var rssps: Cuckoo.VerifyReadOnlyProperty<[URL]> {
            return .init(manager: cuckoo_manager, name: "rssps", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var redirectUrl: Cuckoo.VerifyReadOnlyProperty<URL?> {
            return .init(manager: cuckoo_manager, name: "redirectUrl", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var translations: Cuckoo.VerifyReadOnlyProperty<[String: [LocalizableKey: String]]> {
            return .init(manager: cuckoo_manager, name: "translations", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var printLogs: Cuckoo.VerifyReadOnlyProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "printLogs", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
    }
}

public class EudiRQESUiConfigStub:EudiRQESUiConfig, @unchecked Sendable {
    
    public var rssps: [URL] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([URL]).self)
        }
    }
    
    public var redirectUrl: URL? {
        get {
            return DefaultValueRegistry.defaultValue(for: (URL?).self)
        }
    }
    
    public var translations: [String: [LocalizableKey: String]] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String: [LocalizableKey: String]]).self)
        }
    }
    
    public var printLogs: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
    }


}




// MARK: - Mocks generated from file: 'Sources/Infrastructure/EudiRQESUi.swift'

import Cuckoo
import UIKit
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Presentation/Architecture/ViewModel.swift'

import Cuckoo
import SwiftUI
import Combine
import Copyable
@testable import EudiRQESUi

class MockViewState: ViewState, Cuckoo.ProtocolMock, @unchecked Sendable {
    typealias MocksType = ViewState
    typealias Stubbing = __StubbingProxy_ViewState
    typealias Verification = __VerificationProxy_ViewState

    // Original typealiases

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any ViewState)?

    func enableDefaultImplementation(_ stub: any ViewState) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }


    struct __StubbingProxy_ViewState: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
    }

    struct __VerificationProxy_ViewState: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
    }
}

class ViewStateStub:ViewState, @unchecked Sendable {


}




// MARK: - Mocks generated from file: 'Sources/Presentation/Router/RouterGraph.swift'

import Cuckoo
import Foundation
import SwiftUI
@testable import EudiRQESUi

class MockRouterGraph<Route: Hashable & Identifiable>: RouterGraph, Cuckoo.ProtocolMock, @unchecked Sendable {
    typealias MocksType = DefaultImplCaller
    typealias Stubbing = __StubbingProxy_RouterGraph
    typealias Verification = __VerificationProxy_RouterGraph

    // Original typealiases

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    class DefaultImplCaller: RouterGraph, @unchecked Sendable {
        private let reference: Any
    
        private let _getter_storage$$path: () -> NavigationPath
        private let _setter_storage$$path: (NavigationPath) -> Void
        var path: NavigationPath {
            get { return _getter_storage$$path() }
            set { _setter_storage$$path(newValue) }
        }
    
        
        init<_CUCKOO$$GENERIC: RouterGraph>(from defaultImpl: UnsafeMutablePointer<_CUCKOO$$GENERIC>, keeping reference: @escaping @autoclosure () -> Any?) where _CUCKOO$$GENERIC.Route == Route {
            self.reference = reference
    
            _getter_storage$$path = { defaultImpl.pointee.path }
            _setter_storage$$path = { defaultImpl.pointee.path = $0 }
            _storage$1$navigateTo = defaultImpl.pointee.navigateTo
            _storage$2$pop = defaultImpl.pointee.pop
            _storage$3$navigateToRoot = defaultImpl.pointee.navigateToRoot
            _storage$4$view = defaultImpl.pointee.view
        }
    

        private let _storage$1$navigateTo: (Route) -> Void
        func navigateTo(_ p0: Route) {
            return _storage$1$navigateTo(p0)
        }

        private let _storage$2$pop: () -> Void
        func pop() {
            return _storage$2$pop()
        }

        private let _storage$3$navigateToRoot: () -> Void
        func navigateToRoot() {
            return _storage$3$navigateToRoot()
        }

        private let _storage$4$view: (Route) -> AnyView
        func view(for p0: Route) -> AnyView {
            return _storage$4$view(p0)
        }
    }

    private var __defaultImplStub: DefaultImplCaller?

    func enableDefaultImplementation<_CUCKOO$$GENERIC: RouterGraph>(_ stub: _CUCKOO$$GENERIC) where _CUCKOO$$GENERIC.Route == Route {
        var mutableStub = stub
        __defaultImplStub = DefaultImplCaller(from: &mutableStub, keeping: mutableStub)
        cuckoo_manager.enableDefaultStubImplementation()
    }

    func enableDefaultImplementation<_CUCKOO$$GENERIC: RouterGraph>(mutating stub: UnsafeMutablePointer<_CUCKOO$$GENERIC>) where _CUCKOO$$GENERIC.Route == Route {
        __defaultImplStub = DefaultImplCaller(from: stub, keeping: nil)
        cuckoo_manager.enableDefaultStubImplementation()
    }
    
    var path: NavigationPath {
        get {
            return cuckoo_manager.getter(
                "path",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.path
            )
        }
        set {
            cuckoo_manager.setter(
                "path",
                value: newValue,
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.path = newValue
            )
        }
    }

    
    func navigateTo(_ p0: Route) {
        return cuckoo_manager.call(
            "navigateTo(_ p0: Route)",
            parameters: (p0),
            escapingParameters: (p0),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.navigateTo(p0)
        )
    }
    
    func pop() {
        return cuckoo_manager.call(
            "pop()",
            parameters: (),
            escapingParameters: (),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.pop()
        )
    }
    
    func navigateToRoot() {
        return cuckoo_manager.call(
            "navigateToRoot()",
            parameters: (),
            escapingParameters: (),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.navigateToRoot()
        )
    }
    
    func view(for p0: Route) -> AnyView {
        return cuckoo_manager.call(
            "view(for p0: Route) -> AnyView",
            parameters: (p0),
            escapingParameters: (p0),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.view(for: p0)
        )
    }

    struct __StubbingProxy_RouterGraph: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var path: Cuckoo.ProtocolToBeStubbedProperty<MockRouterGraph,NavigationPath> {
            return .init(manager: cuckoo_manager, name: "path")
        }
        
        func navigateTo<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Route)> where M1.MatchedType == Route {
            let matchers: [Cuckoo.ParameterMatcher<(Route)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRouterGraph.self,
                method: "navigateTo(_ p0: Route)",
                parameterMatchers: matchers
            ))
        }
        
        func pop() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockRouterGraph.self,
                method: "pop()",
                parameterMatchers: matchers
            ))
        }
        
        func navigateToRoot() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockRouterGraph.self,
                method: "navigateToRoot()",
                parameterMatchers: matchers
            ))
        }
        
        func view<M1: Cuckoo.Matchable>(for p0: M1) -> Cuckoo.ProtocolStubFunction<(Route), AnyView> where M1.MatchedType == Route {
            let matchers: [Cuckoo.ParameterMatcher<(Route)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRouterGraph.self,
                method: "view(for p0: Route) -> AnyView",
                parameterMatchers: matchers
            ))
        }
    }

    struct __VerificationProxy_RouterGraph: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        var path: Cuckoo.VerifyProperty<NavigationPath> {
            return .init(manager: cuckoo_manager, name: "path", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        
        @discardableResult
        func navigateTo<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.__DoNotUse<(Route), Void> where M1.MatchedType == Route {
            let matchers: [Cuckoo.ParameterMatcher<(Route)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "navigateTo(_ p0: Route)",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func pop() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "pop()",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func navigateToRoot() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "navigateToRoot()",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func view<M1: Cuckoo.Matchable>(for p0: M1) -> Cuckoo.__DoNotUse<(Route), AnyView> where M1.MatchedType == Route {
            let matchers: [Cuckoo.ParameterMatcher<(Route)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "view(for p0: Route) -> AnyView",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
    }
}

class RouterGraphStub<Route: Hashable & Identifiable>:RouterGraph, @unchecked Sendable {
    
    var path: NavigationPath {
        get {
            return DefaultValueRegistry.defaultValue(for: (NavigationPath).self)
        }
        set {}
    }


    
    func navigateTo(_ p0: Route) {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    func pop() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    func navigateToRoot() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    func view(for p0: Route) -> AnyView {
        return DefaultValueRegistry.defaultValue(for: (AnyView).self)
    }
}




// MARK: - Mocks generated from file: 'Sources/Presentation/Router/RoutingView.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Presentation/UI/CredentialSelection/CredentialSelectionView.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Presentation/UI/CredentialSelection/CredentialSelectionViewModel.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Presentation/UI/DocumentSelectionView/DocumentSelectionView.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Presentation/UI/DocumentSelectionView/DocumentSelectionViewModel.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Presentation/UI/DocumentView/DocumentView.swift'

import Cuckoo
import SwiftUI
import PDFKit
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Presentation/UI/DocumentView/DocumentViewModel.swift'

import Cuckoo
import SwiftUI
import PDFKit
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Presentation/UI/ServiceSelection/ServiceSelectionView.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Presentation/UI/ServiceSelection/ServiceSelectionViewModel.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Presentation/UI/SignedDocument/SignedDocumentView.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: 'Sources/Presentation/UI/SignedDocument/SignedDocumentViewModel.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi

