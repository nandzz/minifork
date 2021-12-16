//
//  Alias.swift
//  Minifork
//
//  Created by Felipe Fernandes on 15/12/21.
//

import Foundation

public typealias NetworkCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> Void
public typealias ServiceCompletion = (Result<Data?, Error>) -> Void
public typealias RepositoryCompletionResponse<T> = (Result<T, Error>) -> Void
public typealias RepositoryCompletionVoid = (Result<Void, Error>) -> Void
