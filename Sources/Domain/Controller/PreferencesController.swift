/*
 * Copyright (c) 2025 European Commission
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

protocol PreferencesController: Sendable {
  func setValue(_ value: Any?, forKey: Prefs.Key)
  func getString(forKey: Prefs.Key) -> String?
  func getOptionalString(forKey: Prefs.Key) -> String
  func getBool(forKey: Prefs.Key) -> Bool
  func getFloat(forKey: Prefs.Key) -> Float
  func getInt(forKey: Prefs.Key) -> Int
  func remove(forKey: Prefs.Key)
  func getValue(forKey: Prefs.Key) -> Any?
}

final class PreferencesControllerImpl: PreferencesController {
  
  func setValue(_ value: Any?, forKey: Prefs.Key) {
    UserDefaults.standard.setValue(value, forKey: forKey.rawValue)
  }
  
  func getString(forKey: Prefs.Key) -> String? {
    return UserDefaults.standard.string(forKey: forKey.rawValue)
  }
  
  func getOptionalString(forKey: Prefs.Key) -> String {
    return UserDefaults.standard.string(forKey: forKey.rawValue) ?? ""
  }
  
  func getFloat(forKey: Prefs.Key) -> Float {
    return UserDefaults.standard.float(forKey: forKey.rawValue)
  }
  
  func getBool(forKey: Prefs.Key) -> Bool {
    return UserDefaults.standard.bool(forKey: forKey.rawValue)
  }
  
  func remove(forKey: Prefs.Key) {
    UserDefaults.standard.removeObject(forKey: forKey.rawValue)
  }
  
  func getValue(forKey: Prefs.Key) -> Any? {
    return UserDefaults.standard.value(forKey: forKey.rawValue)
  }
  
  func getInt(forKey: Prefs.Key) -> Int {
    return UserDefaults.standard.integer(forKey: forKey.rawValue)
  }
}

struct Prefs {}

extension Prefs {
  enum Key: String {
    case place_holder
  }
}
