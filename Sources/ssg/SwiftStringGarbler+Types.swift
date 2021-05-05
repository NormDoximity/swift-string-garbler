//
//  SwiftStringGarbler+Types.swift
//  ssg
//
//  Created by Norman Barnard on 5/5/21.
//

import Foundation
import TSCBasic

public struct UserFlags {
    let isVerbose: Bool
}

enum AppError: Error {
    case fileSystem(String)
    case badInputJson
    case dataError(String)
    case badArguments(String)
    case envRequirements(String)
}

public struct PathConfig: Equatable {

    enum ValidationStatus {
        case ok
        case invalid(message: String)
    }

    let environmentPath: String
    let checksumPath: String?
    let outputPath: String
    let templatePath: String?
}

public struct CIRequirements {
    let identifer: String
    let runtimeRequired: [String]
    let requireAll: Bool

    init(identifier: String, runtimeRequired: [String], requireAll: Bool = false) {
        self.identifer = identifier
        self.runtimeRequired = runtimeRequired
        self.requireAll = requireAll
    }

}

// MARK: - extensions

extension PathConfig {
    func isValid(cwd: AbsolutePath) -> ValidationStatus {
        guard environmentPath.absolutePath(relatetiveTo: cwd).existsAsFile() else {
            return .invalid(message: "Environment at \(environmentPath) not found")
        }
        if let templatePath = templatePath {
            guard templatePath.absolutePath(relatetiveTo: cwd).existsAsFile() else {
                return .invalid(message: "Output template at \(templatePath) not found")
            }
        }
        return .ok
    }
}

extension AppError: CustomStringConvertible {
    var description: String {
        switch self {
        case .badInputJson:
            return "Unable to read environmen file as input."
        case .dataError(let message),
             .badArguments(let message),
             .envRequirements(let message),
             .fileSystem(let message):
            return message
        }
    }
}
