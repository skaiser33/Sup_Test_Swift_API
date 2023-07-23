// main.swift
import Foundation
import AlgoliaSearchClient

let algoliaAppId: ApplicationID = ApplicationID(rawValue: ProcessInfo.processInfo.environment["ALGOLIA_APP_ID"] ?? "NO APP ID")
let algoliaApiKey: APIKey = APIKey(rawValue: ProcessInfo.processInfo.environment["ALGOLIA_ADMIN_API"] ?? "NO API KEY")

// A simple record for your index
struct Record: Encodable {
  let objectID: ObjectID
  let name: String
}

// Add the client to the dependencies of your targets; index is only created if a record is saved
print(algoliaAppId, algoliaApiKey)
let client = SearchClient(appID: algoliaAppId, apiKey: algoliaApiKey)
let index = client.index(withName: "swift_index")

// Create a new index and add a record
let record: Record = .init(objectID: "1", name: "test_record")
let indexing: ()? = try? index.saveObject(record).wait()

// Search the index and print the results
let results = try index.search(query: "test_record")
print(results.hits[0])
