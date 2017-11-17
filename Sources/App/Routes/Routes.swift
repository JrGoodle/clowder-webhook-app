import Foundation
import Vapor

extension Droplet {
    func setupRoutes() throws {
        post("coverage") { req in
            print("\(req.data)")
            fflush(stdout)
            guard let payloadJSON = req.data["payload"]?.string,
                let data = payloadJSON.data(using: .utf8)
            else {
                throw Abort.badRequest
            }
            
            print("Payload JSON: \(payloadJSON)")
            fflush(stdout)
            
            let decoder = JSONDecoder()
            do {
                let payload = try decoder.decode(TravisPayload.self, from: data)
                guard let buildNumber = payload.number,
                    let status = payload.status,
                    let commit = payload.commit
                else {
                    return "Required variables not found"
                }
                if status == 0 {
                    runCoverageScript(buildNumber: buildNumber, commit: commit)
                } else {
                    print("Travis CI build failed")
                    fflush(stdout)
                    return "Travis CI build failed"
                }
            } catch {
                print("error trying to convert data from JSON")
                fflush(stdout)
                print(error)
                fflush(stdout)
                throw error
            }
            
            return "Successfully handled webhook"
        }
    }
}
