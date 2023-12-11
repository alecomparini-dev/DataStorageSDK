//  Created by Alessandro Comparini on 11/12/23.
//

import Foundation

public enum DataStorageError: Error {
    case objectMustBeNSManagedObject
    case createError(_ message: String)
}
