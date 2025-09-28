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
    
    func get(with p0: LocalizableKey) -> String {
        return cuckoo_manager.call(
            "get(with p0: LocalizableKey) -> String",
            parameters: (p0),
            escapingParameters: (p0),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.get(with: p0)
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
        
        func get<M1: Cuckoo.Matchable>(with p0: M1) -> Cuckoo.ProtocolStubFunction<(LocalizableKey), String> where M1.MatchedType == LocalizableKey {
            let matchers: [Cuckoo.ParameterMatcher<(LocalizableKey)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockLocalizationController.self,
                method: "get(with p0: LocalizableKey) -> String",
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
        
        
        @discardableResult
        func get<M1: Cuckoo.Matchable>(with p0: M1) -> Cuckoo.__DoNotUse<(LocalizableKey), String> where M1.MatchedType == LocalizableKey {
            let matchers: [Cuckoo.ParameterMatcher<(LocalizableKey)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "get(with p0: LocalizableKey) -> String",
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
    
    func get(with p0: LocalizableKey) -> String {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
}




// MARK: - Mocks generated from file: '../Sources/Domain/Controller/LogController.swift'

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




// MARK: - Mocks generated from file: '../Sources/Domain/Controller/PreferencesController.swift'

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




// MARK: - Mocks generated from file: '../Sources/Domain/Controller/RQESController.swift'

import Cuckoo
import RqesKit
import Foundation
@testable import EudiRQESUi

class MockRQESController: RQESController, Cuckoo.ProtocolMock, @unchecked Sendable {
    typealias MocksType = RQESController
    typealias Stubbing = __StubbingProxy_RQESController
    typealias Verification = __VerificationProxy_RQESController

    // Original typealiases

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any RQESController)?

    func enableDefaultImplementation(_ stub: any RQESController) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    
    func getServiceAuthorizationUrl() async throws -> URL {
        return try await cuckoo_manager.callThrows(
            "getServiceAuthorizationUrl() async throws -> URL",
            parameters: (),
            escapingParameters: (),
errorType: Error.self,            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.getServiceAuthorizationUrl()
        )
    }
    
    func authorizeService(_ p0: String) async throws -> RQESServiceAuthorized {
        return try await cuckoo_manager.callThrows(
            "authorizeService(_ p0: String) async throws -> RQESServiceAuthorized",
            parameters: (p0),
            escapingParameters: (p0),
errorType: Error.self,            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.authorizeService(p0)
        )
    }
    
    func authorizeCredential(_ p0: String) async throws -> RQESServiceCredentialAuthorized {
        return try await cuckoo_manager.callThrows(
            "authorizeCredential(_ p0: String) async throws -> RQESServiceCredentialAuthorized",
            parameters: (p0),
            escapingParameters: (p0),
errorType: Error.self,            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.authorizeCredential(p0)
        )
    }
    
    func signDocuments(_ p0: String) async throws -> [Document] {
        return try await cuckoo_manager.callThrows(
            "signDocuments(_ p0: String) async throws -> [Document]",
            parameters: (p0),
            escapingParameters: (p0),
errorType: Error.self,            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.signDocuments(p0)
        )
    }
    
    func getCredentialsList() async throws -> [CredentialInfo] {
        return try await cuckoo_manager.callThrows(
            "getCredentialsList() async throws -> [CredentialInfo]",
            parameters: (),
            escapingParameters: (),
errorType: Error.self,            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.getCredentialsList()
        )
    }
    
    func getCredentialAuthorizationUrl(credentialInfo p0: CredentialInfo, documents p1: [Document]) async throws -> URL {
        return try await cuckoo_manager.callThrows(
            "getCredentialAuthorizationUrl(credentialInfo p0: CredentialInfo, documents p1: [Document]) async throws -> URL",
            parameters: (p0, p1),
            escapingParameters: (p0, p1),
errorType: Error.self,            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.getCredentialAuthorizationUrl(credentialInfo: p0, documents: p1)
        )
    }

    struct __StubbingProxy_RQESController: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        func getServiceAuthorizationUrl() -> Cuckoo.ProtocolStubThrowingFunction<(), URL,Error> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockRQESController.self,
                method: "getServiceAuthorizationUrl() async throws -> URL",
                parameterMatchers: matchers
            ))
        }
        
        func authorizeService<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.ProtocolStubThrowingFunction<(String), RQESServiceAuthorized,Error> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRQESController.self,
                method: "authorizeService(_ p0: String) async throws -> RQESServiceAuthorized",
                parameterMatchers: matchers
            ))
        }
        
        func authorizeCredential<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.ProtocolStubThrowingFunction<(String), RQESServiceCredentialAuthorized,Error> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRQESController.self,
                method: "authorizeCredential(_ p0: String) async throws -> RQESServiceCredentialAuthorized",
                parameterMatchers: matchers
            ))
        }
        
        func signDocuments<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.ProtocolStubThrowingFunction<(String), [Document],Error> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRQESController.self,
                method: "signDocuments(_ p0: String) async throws -> [Document]",
                parameterMatchers: matchers
            ))
        }
        
        func getCredentialsList() -> Cuckoo.ProtocolStubThrowingFunction<(), [CredentialInfo],Error> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockRQESController.self,
                method: "getCredentialsList() async throws -> [CredentialInfo]",
                parameterMatchers: matchers
            ))
        }
        
        func getCredentialAuthorizationUrl<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(credentialInfo p0: M1, documents p1: M2) -> Cuckoo.ProtocolStubThrowingFunction<(CredentialInfo, [Document]), URL,Error> where M1.MatchedType == CredentialInfo, M2.MatchedType == [Document] {
            let matchers: [Cuckoo.ParameterMatcher<(CredentialInfo, [Document])>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRQESController.self,
                method: "getCredentialAuthorizationUrl(credentialInfo p0: CredentialInfo, documents p1: [Document]) async throws -> URL",
                parameterMatchers: matchers
            ))
        }
    }

    struct __VerificationProxy_RQESController: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        
        @discardableResult
        func getServiceAuthorizationUrl() -> Cuckoo.__DoNotUse<(), URL> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "getServiceAuthorizationUrl() async throws -> URL",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func authorizeService<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.__DoNotUse<(String), RQESServiceAuthorized> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "authorizeService(_ p0: String) async throws -> RQESServiceAuthorized",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func authorizeCredential<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.__DoNotUse<(String), RQESServiceCredentialAuthorized> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "authorizeCredential(_ p0: String) async throws -> RQESServiceCredentialAuthorized",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func signDocuments<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.__DoNotUse<(String), [Document]> where M1.MatchedType == String {
            let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "signDocuments(_ p0: String) async throws -> [Document]",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func getCredentialsList() -> Cuckoo.__DoNotUse<(), [CredentialInfo]> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "getCredentialsList() async throws -> [CredentialInfo]",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func getCredentialAuthorizationUrl<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(credentialInfo p0: M1, documents p1: M2) -> Cuckoo.__DoNotUse<(CredentialInfo, [Document]), URL> where M1.MatchedType == CredentialInfo, M2.MatchedType == [Document] {
            let matchers: [Cuckoo.ParameterMatcher<(CredentialInfo, [Document])>] = [wrap(matchable: p0) { $0.0 }, wrap(matchable: p1) { $0.1 }]
            return cuckoo_manager.verify(
                "getCredentialAuthorizationUrl(credentialInfo p0: CredentialInfo, documents p1: [Document]) async throws -> URL",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
    }
}

class RQESControllerStub:RQESController, @unchecked Sendable {


    
    func getServiceAuthorizationUrl() async throws -> URL {
        return DefaultValueRegistry.defaultValue(for: (URL).self)
    }
    
    func authorizeService(_ p0: String) async throws -> RQESServiceAuthorized {
        return DefaultValueRegistry.defaultValue(for: (RQESServiceAuthorized).self)
    }
    
    func authorizeCredential(_ p0: String) async throws -> RQESServiceCredentialAuthorized {
        return DefaultValueRegistry.defaultValue(for: (RQESServiceCredentialAuthorized).self)
    }
    
    func signDocuments(_ p0: String) async throws -> [Document] {
        return DefaultValueRegistry.defaultValue(for: ([Document]).self)
    }
    
    func getCredentialsList() async throws -> [CredentialInfo] {
        return DefaultValueRegistry.defaultValue(for: ([CredentialInfo]).self)
    }
    
    func getCredentialAuthorizationUrl(credentialInfo p0: CredentialInfo, documents p1: [Document]) async throws -> URL {
        return DefaultValueRegistry.defaultValue(for: (URL).self)
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
    
    var resolver: Resolver {
        get {
            return cuckoo_manager.getter(
                "resolver",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.resolver
            )
        }
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
        
        var resolver: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDIGraphType,Resolver> {
            return .init(manager: cuckoo_manager, name: "resolver")
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
        
        var resolver: Cuckoo.VerifyReadOnlyProperty<Resolver> {
            return .init(manager: cuckoo_manager, name: "resolver", callMatcher: callMatcher, sourceLocation: sourceLocation)
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
    
    var resolver: Resolver {
        get {
            return DefaultValueRegistry.defaultValue(for: (Resolver).self)
        }
    }
    
    var assembler: Assembler {
        get {
            return DefaultValueRegistry.defaultValue(for: (Assembler).self)
        }
    }


    
    func load() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
}




// MARK: - Mocks generated from file: '../Sources/Domain/Entities/DocumentData.swift'

import Cuckoo
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Domain/Entities/Error/EudiRQESUiError.swift'

import Cuckoo
import Foundation
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Domain/Entities/Localization/LocalizableKey.swift'

import Cuckoo
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Domain/Entities/QTSPData.swift'

import Cuckoo
import RqesKit
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Domain/Entities/SessionData.swift'

import Cuckoo
import RqesKit
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Domain/Extension/Assembler+Extensions.swift'

import Cuckoo
import Swinject
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Domain/Extension/Document+Extensions.swift'

import Cuckoo
import Foundation
import RqesKit
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Domain/Extension/Resolver+Extensions.swift'

import Cuckoo
import Swinject
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Domain/Extension/String+Extensions.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Domain/Interactor/RQESInteractor.swift'

import Cuckoo
import Foundation
import RqesKit
@testable import EudiRQESUi

class MockRQESInteractor: RQESInteractor, Cuckoo.ProtocolMock, @unchecked Sendable {
    typealias MocksType = RQESInteractor
    typealias Stubbing = __StubbingProxy_RQESInteractor
    typealias Verification = __VerificationProxy_RQESInteractor

    // Original typealiases

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any RQESInteractor)?

    func enableDefaultImplementation(_ stub: any RQESInteractor) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    
    func signDocument() async throws -> Document? {
        return try await cuckoo_manager.callThrows(
            "signDocument() async throws -> Document?",
            parameters: (),
            escapingParameters: (),
errorType: Error.self,            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.signDocument()
        )
    }
    
    func getSession() async -> SessionData? {
        return await cuckoo_manager.call(
            "getSession() async -> SessionData?",
            parameters: (),
            escapingParameters: (),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.getSession()
        )
    }
    
    func getQTSps() async -> [QTSPData] {
        return await cuckoo_manager.call(
            "getQTSps() async -> [QTSPData]",
            parameters: (),
            escapingParameters: (),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.getQTSps()
        )
    }
    
    func fetchCredentials() async throws -> Result<[CredentialInfo], any Error> {
        return try await cuckoo_manager.callThrows(
            "fetchCredentials() async throws -> Result<[CredentialInfo], any Error>",
            parameters: (),
            escapingParameters: (),
errorType: Error.self,            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.fetchCredentials()
        )
    }
    
    func updateQTSP(_ p0: QTSPData?) async {
        return await cuckoo_manager.call(
            "updateQTSP(_ p0: QTSPData?) async",
            parameters: (p0),
            escapingParameters: (p0),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.updateQTSP(p0)
        )
    }
    
    func updateDocument(_ p0: URL) async {
        return await cuckoo_manager.call(
            "updateDocument(_ p0: URL) async",
            parameters: (p0),
            escapingParameters: (p0),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.updateDocument(p0)
        )
    }
    
    func createRQESService(_ p0: QTSPData) async throws {
        return try await cuckoo_manager.callThrows(
            "createRQESService(_ p0: QTSPData) async throws",
            parameters: (p0),
            escapingParameters: (p0),
errorType: Error.self,            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.createRQESService(p0)
        )
    }
    
    func saveCertificate(_ p0: CredentialInfo) async {
        return await cuckoo_manager.call(
            "saveCertificate(_ p0: CredentialInfo) async",
            parameters: (p0),
            escapingParameters: (p0),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.saveCertificate(p0)
        )
    }
    
    func openAuthrorizationURL() async throws -> URL {
        return try await cuckoo_manager.callThrows(
            "openAuthrorizationURL() async throws -> URL",
            parameters: (),
            escapingParameters: (),
errorType: Error.self,            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.openAuthrorizationURL()
        )
    }
    
    func openCredentialAuthrorizationURL() async throws -> URL {
        return try await cuckoo_manager.callThrows(
            "openCredentialAuthrorizationURL() async throws -> URL",
            parameters: (),
            escapingParameters: (),
errorType: Error.self,            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: await __defaultImplStub!.openCredentialAuthrorizationURL()
        )
    }

    struct __StubbingProxy_RQESInteractor: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        func signDocument() -> Cuckoo.ProtocolStubThrowingFunction<(), Document?,Error> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockRQESInteractor.self,
                method: "signDocument() async throws -> Document?",
                parameterMatchers: matchers
            ))
        }
        
        func getSession() -> Cuckoo.ProtocolStubFunction<(), SessionData?> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockRQESInteractor.self,
                method: "getSession() async -> SessionData?",
                parameterMatchers: matchers
            ))
        }
        
        func getQTSps() -> Cuckoo.ProtocolStubFunction<(), [QTSPData]> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockRQESInteractor.self,
                method: "getQTSps() async -> [QTSPData]",
                parameterMatchers: matchers
            ))
        }
        
        func fetchCredentials() -> Cuckoo.ProtocolStubThrowingFunction<(), Result<[CredentialInfo], any Error>,Error> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockRQESInteractor.self,
                method: "fetchCredentials() async throws -> Result<[CredentialInfo], any Error>",
                parameterMatchers: matchers
            ))
        }
        
        func updateQTSP<M1: Cuckoo.OptionalMatchable>(_ p0: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(QTSPData?)> where M1.OptionalMatchedType == QTSPData {
            let matchers: [Cuckoo.ParameterMatcher<(QTSPData?)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRQESInteractor.self,
                method: "updateQTSP(_ p0: QTSPData?) async",
                parameterMatchers: matchers
            ))
        }
        
        func updateDocument<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(URL)> where M1.MatchedType == URL {
            let matchers: [Cuckoo.ParameterMatcher<(URL)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRQESInteractor.self,
                method: "updateDocument(_ p0: URL) async",
                parameterMatchers: matchers
            ))
        }
        
        func createRQESService<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.ProtocolStubNoReturnThrowingFunction<(QTSPData),Error> where M1.MatchedType == QTSPData {
            let matchers: [Cuckoo.ParameterMatcher<(QTSPData)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRQESInteractor.self,
                method: "createRQESService(_ p0: QTSPData) async throws",
                parameterMatchers: matchers
            ))
        }
        
        func saveCertificate<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CredentialInfo)> where M1.MatchedType == CredentialInfo {
            let matchers: [Cuckoo.ParameterMatcher<(CredentialInfo)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRQESInteractor.self,
                method: "saveCertificate(_ p0: CredentialInfo) async",
                parameterMatchers: matchers
            ))
        }
        
        func openAuthrorizationURL() -> Cuckoo.ProtocolStubThrowingFunction<(), URL,Error> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockRQESInteractor.self,
                method: "openAuthrorizationURL() async throws -> URL",
                parameterMatchers: matchers
            ))
        }
        
        func openCredentialAuthrorizationURL() -> Cuckoo.ProtocolStubThrowingFunction<(), URL,Error> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockRQESInteractor.self,
                method: "openCredentialAuthrorizationURL() async throws -> URL",
                parameterMatchers: matchers
            ))
        }
    }

    struct __VerificationProxy_RQESInteractor: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        
        @discardableResult
        func signDocument() -> Cuckoo.__DoNotUse<(), Document?> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "signDocument() async throws -> Document?",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func getSession() -> Cuckoo.__DoNotUse<(), SessionData?> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "getSession() async -> SessionData?",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func getQTSps() -> Cuckoo.__DoNotUse<(), [QTSPData]> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "getQTSps() async -> [QTSPData]",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func fetchCredentials() -> Cuckoo.__DoNotUse<(), Result<[CredentialInfo], any Error>> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "fetchCredentials() async throws -> Result<[CredentialInfo], any Error>",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func updateQTSP<M1: Cuckoo.OptionalMatchable>(_ p0: M1) -> Cuckoo.__DoNotUse<(QTSPData?), Void> where M1.OptionalMatchedType == QTSPData {
            let matchers: [Cuckoo.ParameterMatcher<(QTSPData?)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "updateQTSP(_ p0: QTSPData?) async",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func updateDocument<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.__DoNotUse<(URL), Void> where M1.MatchedType == URL {
            let matchers: [Cuckoo.ParameterMatcher<(URL)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "updateDocument(_ p0: URL) async",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func createRQESService<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.__DoNotUse<(QTSPData), Void> where M1.MatchedType == QTSPData {
            let matchers: [Cuckoo.ParameterMatcher<(QTSPData)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "createRQESService(_ p0: QTSPData) async throws",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func saveCertificate<M1: Cuckoo.Matchable>(_ p0: M1) -> Cuckoo.__DoNotUse<(CredentialInfo), Void> where M1.MatchedType == CredentialInfo {
            let matchers: [Cuckoo.ParameterMatcher<(CredentialInfo)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "saveCertificate(_ p0: CredentialInfo) async",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func openAuthrorizationURL() -> Cuckoo.__DoNotUse<(), URL> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "openAuthrorizationURL() async throws -> URL",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func openCredentialAuthrorizationURL() -> Cuckoo.__DoNotUse<(), URL> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "openCredentialAuthrorizationURL() async throws -> URL",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
    }
}

class RQESInteractorStub:RQESInteractor, @unchecked Sendable {


    
    func signDocument() async throws -> Document? {
        return DefaultValueRegistry.defaultValue(for: (Document?).self)
    }
    
    func getSession() async -> SessionData? {
        return DefaultValueRegistry.defaultValue(for: (SessionData?).self)
    }
    
    func getQTSps() async -> [QTSPData] {
        return DefaultValueRegistry.defaultValue(for: ([QTSPData]).self)
    }
    
    func fetchCredentials() async throws -> Result<[CredentialInfo], any Error> {
        return DefaultValueRegistry.defaultValue(for: (Result<[CredentialInfo], any Error>).self)
    }
    
    func updateQTSP(_ p0: QTSPData?) async {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    func updateDocument(_ p0: URL) async {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    func createRQESService(_ p0: QTSPData) async throws {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    func saveCertificate(_ p0: CredentialInfo) async {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    func openAuthrorizationURL() async throws -> URL {
        return DefaultValueRegistry.defaultValue(for: (URL).self)
    }
    
    func openCredentialAuthrorizationURL() async throws -> URL {
        return DefaultValueRegistry.defaultValue(for: (URL).self)
    }
}




// MARK: - Mocks generated from file: '../Sources/Infrastructure/Config/EudiRQESUiConfig.swift'

import Cuckoo
import Foundation
import RqesKit
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
    
    public var rssps: [QTSPData] {
        get {
            return cuckoo_manager.getter(
                "rssps",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.rssps
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
    
    public var theme: ThemeProtocol {
        get {
            return cuckoo_manager.getter(
                "theme",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.theme
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
        
        var rssps: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockEudiRQESUiConfig,[QTSPData]> {
            return .init(manager: cuckoo_manager, name: "rssps")
        }
        
        var translations: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockEudiRQESUiConfig,[String: [LocalizableKey: String]]> {
            return .init(manager: cuckoo_manager, name: "translations")
        }
        
        var theme: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockEudiRQESUiConfig,ThemeProtocol> {
            return .init(manager: cuckoo_manager, name: "theme")
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
        
        var rssps: Cuckoo.VerifyReadOnlyProperty<[QTSPData]> {
            return .init(manager: cuckoo_manager, name: "rssps", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var translations: Cuckoo.VerifyReadOnlyProperty<[String: [LocalizableKey: String]]> {
            return .init(manager: cuckoo_manager, name: "translations", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var theme: Cuckoo.VerifyReadOnlyProperty<ThemeProtocol> {
            return .init(manager: cuckoo_manager, name: "theme", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var printLogs: Cuckoo.VerifyReadOnlyProperty<Bool> {
            return .init(manager: cuckoo_manager, name: "printLogs", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
    }
}

public class EudiRQESUiConfigStub:EudiRQESUiConfig, @unchecked Sendable {
    
    public var rssps: [QTSPData] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([QTSPData]).self)
        }
    }
    
    public var translations: [String: [LocalizableKey: String]] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String: [LocalizableKey: String]]).self)
        }
    }
    
    public var theme: ThemeProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (ThemeProtocol).self)
        }
    }
    
    public var printLogs: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
    }


}




// MARK: - Mocks generated from file: '../Sources/Infrastructure/EudiRQESUi.swift'

import Cuckoo
import UIKit
import RqesKit
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Infrastructure/Theme/ColorManager.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi

public class MockColorManagerProtocol: ColorManagerProtocol, Cuckoo.ProtocolMock, @unchecked Sendable {
    public typealias MocksType = ColorManagerProtocol
    public typealias Stubbing = __StubbingProxy_ColorManagerProtocol
    public typealias Verification = __VerificationProxy_ColorManagerProtocol

    // Original typealiases

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any ColorManagerProtocol)?

    public func enableDefaultImplementation(_ stub: any ColorManagerProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    
    public var background: Color {
        get {
            return cuckoo_manager.getter(
                "background",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.background
            )
        }
    }
    
    public var surfaceContriner: Color {
        get {
            return cuckoo_manager.getter(
                "surfaceContriner",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.surfaceContriner
            )
        }
    }
    
    public var error: Color {
        get {
            return cuckoo_manager.getter(
                "error",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.error
            )
        }
    }
    
    public var onSurface: Color {
        get {
            return cuckoo_manager.getter(
                "onSurface",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.onSurface
            )
        }
    }
    
    public var onSurfaceVariant: Color {
        get {
            return cuckoo_manager.getter(
                "onSurfaceVariant",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.onSurfaceVariant
            )
        }
    }
    
    public var primaryMain: Color {
        get {
            return cuckoo_manager.getter(
                "primaryMain",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.primaryMain
            )
        }
    }
    
    public var success: Color {
        get {
            return cuckoo_manager.getter(
                "success",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.success
            )
        }
    }
    
    public var tertiary: Color {
        get {
            return cuckoo_manager.getter(
                "tertiary",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.tertiary
            )
        }
    }
    
    public var warning: Color {
        get {
            return cuckoo_manager.getter(
                "warning",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.warning
            )
        }
    }
    
    public var secondary: Color {
        get {
            return cuckoo_manager.getter(
                "secondary",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.secondary
            )
        }
    }
    
    public var onPrimary: Color {
        get {
            return cuckoo_manager.getter(
                "onPrimary",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.onPrimary
            )
        }
    }
    
    public var black: Color {
        get {
            return cuckoo_manager.getter(
                "black",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.black
            )
        }
    }


    public struct __StubbingProxy_ColorManagerProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var background: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockColorManagerProtocol,Color> {
            return .init(manager: cuckoo_manager, name: "background")
        }
        
        var surfaceContriner: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockColorManagerProtocol,Color> {
            return .init(manager: cuckoo_manager, name: "surfaceContriner")
        }
        
        var error: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockColorManagerProtocol,Color> {
            return .init(manager: cuckoo_manager, name: "error")
        }
        
        var onSurface: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockColorManagerProtocol,Color> {
            return .init(manager: cuckoo_manager, name: "onSurface")
        }
        
        var onSurfaceVariant: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockColorManagerProtocol,Color> {
            return .init(manager: cuckoo_manager, name: "onSurfaceVariant")
        }
        
        var primaryMain: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockColorManagerProtocol,Color> {
            return .init(manager: cuckoo_manager, name: "primaryMain")
        }
        
        var success: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockColorManagerProtocol,Color> {
            return .init(manager: cuckoo_manager, name: "success")
        }
        
        var tertiary: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockColorManagerProtocol,Color> {
            return .init(manager: cuckoo_manager, name: "tertiary")
        }
        
        var warning: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockColorManagerProtocol,Color> {
            return .init(manager: cuckoo_manager, name: "warning")
        }
        
        var secondary: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockColorManagerProtocol,Color> {
            return .init(manager: cuckoo_manager, name: "secondary")
        }
        
        var onPrimary: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockColorManagerProtocol,Color> {
            return .init(manager: cuckoo_manager, name: "onPrimary")
        }
        
        var black: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockColorManagerProtocol,Color> {
            return .init(manager: cuckoo_manager, name: "black")
        }
    }

    public struct __VerificationProxy_ColorManagerProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        var background: Cuckoo.VerifyReadOnlyProperty<Color> {
            return .init(manager: cuckoo_manager, name: "background", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var surfaceContriner: Cuckoo.VerifyReadOnlyProperty<Color> {
            return .init(manager: cuckoo_manager, name: "surfaceContriner", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var error: Cuckoo.VerifyReadOnlyProperty<Color> {
            return .init(manager: cuckoo_manager, name: "error", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var onSurface: Cuckoo.VerifyReadOnlyProperty<Color> {
            return .init(manager: cuckoo_manager, name: "onSurface", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var onSurfaceVariant: Cuckoo.VerifyReadOnlyProperty<Color> {
            return .init(manager: cuckoo_manager, name: "onSurfaceVariant", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var primaryMain: Cuckoo.VerifyReadOnlyProperty<Color> {
            return .init(manager: cuckoo_manager, name: "primaryMain", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var success: Cuckoo.VerifyReadOnlyProperty<Color> {
            return .init(manager: cuckoo_manager, name: "success", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var tertiary: Cuckoo.VerifyReadOnlyProperty<Color> {
            return .init(manager: cuckoo_manager, name: "tertiary", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var warning: Cuckoo.VerifyReadOnlyProperty<Color> {
            return .init(manager: cuckoo_manager, name: "warning", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var secondary: Cuckoo.VerifyReadOnlyProperty<Color> {
            return .init(manager: cuckoo_manager, name: "secondary", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var onPrimary: Cuckoo.VerifyReadOnlyProperty<Color> {
            return .init(manager: cuckoo_manager, name: "onPrimary", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var black: Cuckoo.VerifyReadOnlyProperty<Color> {
            return .init(manager: cuckoo_manager, name: "black", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
    }
}

public class ColorManagerProtocolStub:ColorManagerProtocol, @unchecked Sendable {
    
    public var background: Color {
        get {
            return DefaultValueRegistry.defaultValue(for: (Color).self)
        }
    }
    
    public var surfaceContriner: Color {
        get {
            return DefaultValueRegistry.defaultValue(for: (Color).self)
        }
    }
    
    public var error: Color {
        get {
            return DefaultValueRegistry.defaultValue(for: (Color).self)
        }
    }
    
    public var onSurface: Color {
        get {
            return DefaultValueRegistry.defaultValue(for: (Color).self)
        }
    }
    
    public var onSurfaceVariant: Color {
        get {
            return DefaultValueRegistry.defaultValue(for: (Color).self)
        }
    }
    
    public var primaryMain: Color {
        get {
            return DefaultValueRegistry.defaultValue(for: (Color).self)
        }
    }
    
    public var success: Color {
        get {
            return DefaultValueRegistry.defaultValue(for: (Color).self)
        }
    }
    
    public var tertiary: Color {
        get {
            return DefaultValueRegistry.defaultValue(for: (Color).self)
        }
    }
    
    public var warning: Color {
        get {
            return DefaultValueRegistry.defaultValue(for: (Color).self)
        }
    }
    
    public var secondary: Color {
        get {
            return DefaultValueRegistry.defaultValue(for: (Color).self)
        }
    }
    
    public var onPrimary: Color {
        get {
            return DefaultValueRegistry.defaultValue(for: (Color).self)
        }
    }
    
    public var black: Color {
        get {
            return DefaultValueRegistry.defaultValue(for: (Color).self)
        }
    }


}




// MARK: - Mocks generated from file: '../Sources/Infrastructure/Theme/ThemeManager.swift'

import Cuckoo
@testable import EudiRQESUi

public class MockThemeProtocol: ThemeProtocol, Cuckoo.ProtocolMock, @unchecked Sendable {
    public typealias MocksType = ThemeProtocol
    public typealias Stubbing = __StubbingProxy_ThemeProtocol
    public typealias Verification = __VerificationProxy_ThemeProtocol

    // Original typealiases

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any ThemeProtocol)?

    public func enableDefaultImplementation(_ stub: any ThemeProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    
    public var color: ColorManagerProtocol {
        get {
            return cuckoo_manager.getter(
                "color",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.color
            )
        }
    }
    
    public var font: TypographyManagerProtocol {
        get {
            return cuckoo_manager.getter(
                "font",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.font
            )
        }
    }


    public struct __StubbingProxy_ThemeProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var color: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockThemeProtocol,ColorManagerProtocol> {
            return .init(manager: cuckoo_manager, name: "color")
        }
        
        var font: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockThemeProtocol,TypographyManagerProtocol> {
            return .init(manager: cuckoo_manager, name: "font")
        }
    }

    public struct __VerificationProxy_ThemeProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        var color: Cuckoo.VerifyReadOnlyProperty<ColorManagerProtocol> {
            return .init(manager: cuckoo_manager, name: "color", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var font: Cuckoo.VerifyReadOnlyProperty<TypographyManagerProtocol> {
            return .init(manager: cuckoo_manager, name: "font", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
    }
}

public class ThemeProtocolStub:ThemeProtocol, @unchecked Sendable {
    
    public var color: ColorManagerProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (ColorManagerProtocol).self)
        }
    }
    
    public var font: TypographyManagerProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (TypographyManagerProtocol).self)
        }
    }


}




// MARK: - Mocks generated from file: '../Sources/Infrastructure/Theme/TypographyManager.swift'

import Cuckoo
import Foundation
import SwiftUI
@testable import EudiRQESUi

public class MockTypographyManagerProtocol: TypographyManagerProtocol, Cuckoo.ProtocolMock, @unchecked Sendable {
    public typealias MocksType = TypographyManagerProtocol
    public typealias Stubbing = __StubbingProxy_TypographyManagerProtocol
    public typealias Verification = __VerificationProxy_TypographyManagerProtocol

    // Original typealiases

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any TypographyManagerProtocol)?

    public func enableDefaultImplementation(_ stub: any TypographyManagerProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    
    public var displayLarge: TypographyStyle {
        get {
            return cuckoo_manager.getter(
                "displayLarge",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.displayLarge
            )
        }
    }
    
    public var displayMedium: TypographyStyle {
        get {
            return cuckoo_manager.getter(
                "displayMedium",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.displayMedium
            )
        }
    }
    
    public var displaySmall: TypographyStyle {
        get {
            return cuckoo_manager.getter(
                "displaySmall",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.displaySmall
            )
        }
    }
    
    public var headlineLarge: TypographyStyle {
        get {
            return cuckoo_manager.getter(
                "headlineLarge",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.headlineLarge
            )
        }
    }
    
    public var headlineMedium: TypographyStyle {
        get {
            return cuckoo_manager.getter(
                "headlineMedium",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.headlineMedium
            )
        }
    }
    
    public var headlineSmall: TypographyStyle {
        get {
            return cuckoo_manager.getter(
                "headlineSmall",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.headlineSmall
            )
        }
    }
    
    public var titleLarge: TypographyStyle {
        get {
            return cuckoo_manager.getter(
                "titleLarge",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.titleLarge
            )
        }
    }
    
    public var titleMedium: TypographyStyle {
        get {
            return cuckoo_manager.getter(
                "titleMedium",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.titleMedium
            )
        }
    }
    
    public var titleSmall: TypographyStyle {
        get {
            return cuckoo_manager.getter(
                "titleSmall",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.titleSmall
            )
        }
    }
    
    public var bodyLarge: TypographyStyle {
        get {
            return cuckoo_manager.getter(
                "bodyLarge",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.bodyLarge
            )
        }
    }
    
    public var bodyMedium: TypographyStyle {
        get {
            return cuckoo_manager.getter(
                "bodyMedium",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.bodyMedium
            )
        }
    }
    
    public var bodySmall: TypographyStyle {
        get {
            return cuckoo_manager.getter(
                "bodySmall",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.bodySmall
            )
        }
    }
    
    public var labelLarge: TypographyStyle {
        get {
            return cuckoo_manager.getter(
                "labelLarge",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.labelLarge
            )
        }
    }
    
    public var labelMedium: TypographyStyle {
        get {
            return cuckoo_manager.getter(
                "labelMedium",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.labelMedium
            )
        }
    }
    
    public var labelSmall: TypographyStyle {
        get {
            return cuckoo_manager.getter(
                "labelSmall",
                superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
                defaultCall: __defaultImplStub!.labelSmall
            )
        }
    }


    public struct __StubbingProxy_TypographyManagerProtocol: Cuckoo.StubbingProxy {
        private let cuckoo_manager: Cuckoo.MockManager
    
        public init(manager: Cuckoo.MockManager) {
            self.cuckoo_manager = manager
        }
        
        var displayLarge: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTypographyManagerProtocol,TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "displayLarge")
        }
        
        var displayMedium: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTypographyManagerProtocol,TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "displayMedium")
        }
        
        var displaySmall: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTypographyManagerProtocol,TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "displaySmall")
        }
        
        var headlineLarge: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTypographyManagerProtocol,TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "headlineLarge")
        }
        
        var headlineMedium: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTypographyManagerProtocol,TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "headlineMedium")
        }
        
        var headlineSmall: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTypographyManagerProtocol,TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "headlineSmall")
        }
        
        var titleLarge: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTypographyManagerProtocol,TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "titleLarge")
        }
        
        var titleMedium: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTypographyManagerProtocol,TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "titleMedium")
        }
        
        var titleSmall: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTypographyManagerProtocol,TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "titleSmall")
        }
        
        var bodyLarge: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTypographyManagerProtocol,TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "bodyLarge")
        }
        
        var bodyMedium: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTypographyManagerProtocol,TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "bodyMedium")
        }
        
        var bodySmall: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTypographyManagerProtocol,TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "bodySmall")
        }
        
        var labelLarge: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTypographyManagerProtocol,TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "labelLarge")
        }
        
        var labelMedium: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTypographyManagerProtocol,TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "labelMedium")
        }
        
        var labelSmall: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockTypographyManagerProtocol,TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "labelSmall")
        }
    }

    public struct __VerificationProxy_TypographyManagerProtocol: Cuckoo.VerificationProxy {
        private let cuckoo_manager: Cuckoo.MockManager
        private let callMatcher: Cuckoo.CallMatcher
        private let sourceLocation: Cuckoo.SourceLocation
    
        public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
            self.cuckoo_manager = manager
            self.callMatcher = callMatcher
            self.sourceLocation = sourceLocation
        }
        
        var displayLarge: Cuckoo.VerifyReadOnlyProperty<TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "displayLarge", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var displayMedium: Cuckoo.VerifyReadOnlyProperty<TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "displayMedium", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var displaySmall: Cuckoo.VerifyReadOnlyProperty<TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "displaySmall", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var headlineLarge: Cuckoo.VerifyReadOnlyProperty<TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "headlineLarge", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var headlineMedium: Cuckoo.VerifyReadOnlyProperty<TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "headlineMedium", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var headlineSmall: Cuckoo.VerifyReadOnlyProperty<TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "headlineSmall", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var titleLarge: Cuckoo.VerifyReadOnlyProperty<TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "titleLarge", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var titleMedium: Cuckoo.VerifyReadOnlyProperty<TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "titleMedium", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var titleSmall: Cuckoo.VerifyReadOnlyProperty<TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "titleSmall", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var bodyLarge: Cuckoo.VerifyReadOnlyProperty<TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "bodyLarge", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var bodyMedium: Cuckoo.VerifyReadOnlyProperty<TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "bodyMedium", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var bodySmall: Cuckoo.VerifyReadOnlyProperty<TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "bodySmall", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var labelLarge: Cuckoo.VerifyReadOnlyProperty<TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "labelLarge", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var labelMedium: Cuckoo.VerifyReadOnlyProperty<TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "labelMedium", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
        
        var labelSmall: Cuckoo.VerifyReadOnlyProperty<TypographyStyle> {
            return .init(manager: cuckoo_manager, name: "labelSmall", callMatcher: callMatcher, sourceLocation: sourceLocation)
        }
    }
}

public class TypographyManagerProtocolStub:TypographyManagerProtocol, @unchecked Sendable {
    
    public var displayLarge: TypographyStyle {
        get {
            return DefaultValueRegistry.defaultValue(for: (TypographyStyle).self)
        }
    }
    
    public var displayMedium: TypographyStyle {
        get {
            return DefaultValueRegistry.defaultValue(for: (TypographyStyle).self)
        }
    }
    
    public var displaySmall: TypographyStyle {
        get {
            return DefaultValueRegistry.defaultValue(for: (TypographyStyle).self)
        }
    }
    
    public var headlineLarge: TypographyStyle {
        get {
            return DefaultValueRegistry.defaultValue(for: (TypographyStyle).self)
        }
    }
    
    public var headlineMedium: TypographyStyle {
        get {
            return DefaultValueRegistry.defaultValue(for: (TypographyStyle).self)
        }
    }
    
    public var headlineSmall: TypographyStyle {
        get {
            return DefaultValueRegistry.defaultValue(for: (TypographyStyle).self)
        }
    }
    
    public var titleLarge: TypographyStyle {
        get {
            return DefaultValueRegistry.defaultValue(for: (TypographyStyle).self)
        }
    }
    
    public var titleMedium: TypographyStyle {
        get {
            return DefaultValueRegistry.defaultValue(for: (TypographyStyle).self)
        }
    }
    
    public var titleSmall: TypographyStyle {
        get {
            return DefaultValueRegistry.defaultValue(for: (TypographyStyle).self)
        }
    }
    
    public var bodyLarge: TypographyStyle {
        get {
            return DefaultValueRegistry.defaultValue(for: (TypographyStyle).self)
        }
    }
    
    public var bodyMedium: TypographyStyle {
        get {
            return DefaultValueRegistry.defaultValue(for: (TypographyStyle).self)
        }
    }
    
    public var bodySmall: TypographyStyle {
        get {
            return DefaultValueRegistry.defaultValue(for: (TypographyStyle).self)
        }
    }
    
    public var labelLarge: TypographyStyle {
        get {
            return DefaultValueRegistry.defaultValue(for: (TypographyStyle).self)
        }
    }
    
    public var labelMedium: TypographyStyle {
        get {
            return DefaultValueRegistry.defaultValue(for: (TypographyStyle).self)
        }
    }
    
    public var labelSmall: TypographyStyle {
        get {
            return DefaultValueRegistry.defaultValue(for: (TypographyStyle).self)
        }
    }


}




// MARK: - Mocks generated from file: '../Sources/Presentation/Architecture/ViewModel.swift'

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




// MARK: - Mocks generated from file: '../Sources/Presentation/Entities/CredentialDataUIModel.swift'

import Cuckoo
import RqesKit
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/Extension/UIApplication+Extensions.swift'

import Cuckoo
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/Extension/View+Extensions.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/Modifiers/FastenedDynamicModifier.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/Modifiers/LeftImageModifier.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/Modifiers/ToolBarContent.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/Router/RouterGraph.swift'

import Cuckoo
import Foundation
import SwiftUI
@testable import EudiRQESUi

class MockRouterGraph: RouterGraph, Cuckoo.ProtocolMock, @unchecked Sendable {
    typealias MocksType = RouterGraph
    typealias Stubbing = __StubbingProxy_RouterGraph
    typealias Verification = __VerificationProxy_RouterGraph

    // Original typealiases

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: (any RouterGraph)?

    func enableDefaultImplementation(_ stub: any RouterGraph) {
        __defaultImplStub = stub
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
    
    func nextView(for p0: EudiRQESUi.State) throws -> UIViewController {
        return try cuckoo_manager.callThrows(
            "nextView(for p0: EudiRQESUi.State) throws -> UIViewController",
            parameters: (p0),
            escapingParameters: (p0),
errorType: Error.self,            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.nextView(for: p0)
        )
    }
    
    func clear() {
        return cuckoo_manager.call(
            "clear()",
            parameters: (),
            escapingParameters: (),
            superclassCall: Cuckoo.MockManager.crashOnProtocolSuperclassCall(),
            defaultCall: __defaultImplStub!.clear()
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
        
        func nextView<M1: Cuckoo.Matchable>(for p0: M1) -> Cuckoo.ProtocolStubThrowingFunction<(EudiRQESUi.State), UIViewController,Error> where M1.MatchedType == EudiRQESUi.State {
            let matchers: [Cuckoo.ParameterMatcher<(EudiRQESUi.State)>] = [wrap(matchable: p0) { $0 }]
            return .init(stub: cuckoo_manager.createStub(for: MockRouterGraph.self,
                method: "nextView(for p0: EudiRQESUi.State) throws -> UIViewController",
                parameterMatchers: matchers
            ))
        }
        
        func clear() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return .init(stub: cuckoo_manager.createStub(for: MockRouterGraph.self,
                method: "clear()",
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
        
        
        @discardableResult
        func nextView<M1: Cuckoo.Matchable>(for p0: M1) -> Cuckoo.__DoNotUse<(EudiRQESUi.State), UIViewController> where M1.MatchedType == EudiRQESUi.State {
            let matchers: [Cuckoo.ParameterMatcher<(EudiRQESUi.State)>] = [wrap(matchable: p0) { $0 }]
            return cuckoo_manager.verify(
                "nextView(for p0: EudiRQESUi.State) throws -> UIViewController",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
        
        
        @discardableResult
        func clear() -> Cuckoo.__DoNotUse<(), Void> {
            let matchers: [Cuckoo.ParameterMatcher<Void>] = []
            return cuckoo_manager.verify(
                "clear()",
                callMatcher: callMatcher,
                parameterMatchers: matchers,
                sourceLocation: sourceLocation
            )
        }
    }
}

class RouterGraphStub:RouterGraph, @unchecked Sendable {
    
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
    
    func nextView(for p0: EudiRQESUi.State) throws -> UIViewController {
        return DefaultValueRegistry.defaultValue(for: (UIViewController).self)
    }
    
    func clear() {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
}




// MARK: - Mocks generated from file: '../Sources/Presentation/UI/Component/CardView.swift'

import Cuckoo
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/Component/ContentErrorView.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/Component/ContentHeader/AppIconAndTextView.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/Component/ContentHeader/ContentHeaderView.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/Component/ContentHeader/RelyingPartyView.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/Component/ContentScreenView.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/Component/Dialog/DialogCompat.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/Component/LoadingView.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/Component/SelectionItem/SelectionItemView.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/Component/SelectionItem/selectionItemData.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/Component/WrapButtonView.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/Component/WrapTextView.swift'

import Cuckoo
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/Container/ContainerView.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/CredentialSelection/CredentialSelectionView.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/CredentialSelection/CredentialSelectionViewModel.swift'

import Cuckoo
import SwiftUI
import RqesKit
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/DocumentSelectionView/DocumentSelectionView.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/DocumentSelectionView/DocumentSelectionViewModel.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/DocumentView/DocumentView.swift'

import Cuckoo
import SwiftUI
import PDFKit
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/DocumentView/DocumentViewModel.swift'

import Cuckoo
import SwiftUI
import PDFKit
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/ServiceSelection/ServiceSelectionView.swift'

import Cuckoo
import SwiftUI
import RqesKit
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/ServiceSelection/ServiceSelectionViewModel.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/SignedDocument/SignedDocumentView.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi



// MARK: - Mocks generated from file: '../Sources/Presentation/UI/SignedDocument/SignedDocumentViewModel.swift'

import Cuckoo
import SwiftUI
@testable import EudiRQESUi

