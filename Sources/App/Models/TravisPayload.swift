struct TravisPayload: Codable {
    var commit: String?
    var number: String?
    var status: Int?
    var result: Int?
}
