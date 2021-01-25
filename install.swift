
import Foundation

let templatePath = "\(FileManager.default.homeDirectoryForCurrentUser.path)/Library/Developer/Xcode/Templates/"

let projectDir = "Project Templates/"
let moduleDir = "File Templates/"

let sourceProjectPath = "\(FileManager.default.currentDirectoryPath)/\(projectDir)"
let sourceModulePath = "\(FileManager.default.currentDirectoryPath)/\(moduleDir)"

let projectTemplatePath = "\(templatePath)/\(projectDir)"
let moduleTemplatePath = "\(templatePath)/\(moduleDir)"

func makeDir(path: String) {
    try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
}

func moveTemplate(fromPath: String, toPath: String) throws {
    let toURL = URL(fileURLWithPath:toPath)
    try FileManager.default.removeItem(at: toURL)
    try FileManager.default.copyItem(atPath: fromPath, toPath: toPath)
}

do {
    print("Install Project templates at \(projectTemplatePath)")
    makeDir(path: projectTemplatePath)
    try moveTemplate(fromPath: sourceProjectPath, toPath: projectTemplatePath)

    print("Install Module templates at \(moduleTemplatePath)")
    makeDir(path: moduleTemplatePath)
    try moveTemplate(fromPath: sourceModulePath, toPath: moduleTemplatePath)
    
    print("All templates have been successfully installed.")
} catch let error as NSError {
    print("Could not install the templates. Reason: \(error.localizedFailureReason ?? "")")
}
