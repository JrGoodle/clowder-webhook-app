import Foundation

func runCoverageScript(buildNumber: String, commit: String) {
    let task = Process()
    let currentPath = FileManager.default.currentDirectoryPath
    task.launchPath = "\(currentPath)/script/clowder-coverage.sh"
    task.arguments = [buildNumber, commit]
    task.launch()
}
