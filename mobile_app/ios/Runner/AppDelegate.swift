import Flutter
import UIKit
import UniformTypeIdentifiers

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    if let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "KeeperPassClipboard") {
      ClipboardChannel.register(with: registrar)
    }
  }
}

/// The clipboard for KeeperPass (plan Part 14, `ClipboardService` in Dart).
/// A secret stays on this device (no Universal Clipboard) and expires on
/// its own, even if KeeperPass is closed; a clear only removes what
/// KeeperPass itself put there (the pasteboard's change count is the mark).
final class ClipboardChannel: NSObject, FlutterPlugin {
  static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "keeperpass/clipboard", binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(ClipboardChannel(), channel: channel)
  }

  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let arguments = call.arguments as? [String: Any] ?? [:]
    let pasteboard = UIPasteboard.general
    switch call.method {
    case "copy":
      let text = arguments["text"] as? String ?? ""
      if arguments["sensitive"] as? Bool == true {
        var options: [UIPasteboard.OptionsKey: Any] = [.localOnly: true]
        if let seconds = arguments["expiresInSeconds"] as? Int {
          options[.expirationDate] = Date().addingTimeInterval(TimeInterval(seconds))
        }
        pasteboard.setItems([[UTType.utf8PlainText.identifier: text]], options: options)
      } else {
        pasteboard.string = text
      }
      result(String(pasteboard.changeCount))
    case "clearIfOurs":
      if let marker = arguments["marker"] as? String,
        marker == String(pasteboard.changeCount)
      {
        pasteboard.items = []
        result(true)
      } else {
        result(false)
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
