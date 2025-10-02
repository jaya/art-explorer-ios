//
//  Department.swift
//  art-explorer
//
//  Created by Pedro Freddi on 17/06/25.
//

struct GetDepartmentsResponse: Codable {
    let departments: [Department]
}

struct Department: Codable {
    let departmentId: Int
    let displayName: String
}
