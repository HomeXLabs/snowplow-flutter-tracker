import Flutter
import UIKit
import SnowplowTracker

public class SwiftSnowplowFlutterTrackerPlugin: NSObject, FlutterPlugin {
    private var tracker: SPTracker?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "snowplow_flutter_tracker", binaryMessenger: registrar.messenger())
        let instance = SwiftSnowplowFlutterTrackerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initialize":
            onInitialize(call, result)
        case "setSubject":
            onSetSubject(call, result)
        case "trackPageView":
            onTrackPageView(call, result)
        case "trackStructured":
            onTrackStructured(call, result)
        case "trackSelfDescribing":
            onTrackUnstructured(call, result)
        case "trackScreenView":
            onTrackScreenView(call, result)
        case "trackConsentWithdrawn":
            onTrackConsentWithdrawn(call, result)
        case "trackConsentGranted":
            onTrackConsentGranted(call, result)
        case "trackTiming":
            onTrackTiming(call, result)
        case "trackEcommerceTransaction":
            onTrackEcommTransaction(call, result)
        case "trackPushNotification":
            onTrackPushNotification(call, result)
        default:
            result(FlutterMethodNotImplemented)
            return
        }
    }
    
    private func onInitialize(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String: Any]
        let emitter = TrackerUtil.getEmitter(dictionary: arguments?["emitter"] as? [String: Any])
        tracker = TrackerUtil.getTracker(emitter: emitter, dictionary: arguments)
        
        result(nil)
    }
    
    private func onSetSubject(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String: Any]
        
        if (arguments?["userId"] != nil) {
            tracker?.subject.setUserId(arguments?["userId"] as? String)
        }
        if (arguments?["viewportWidth"] != nil && arguments?["viewportHeight"] != nil) {
            tracker?.subject.setViewPortWithWidth(arguments?["viewportWidth"] as! Int, andHeight: arguments?["viewportHeight"] as! Int)
        }
        if (arguments?["screenResolutionWidth"] != nil && arguments?["screenResolutionHeight"] != nil) {
            tracker?.subject.setResolutionWithWidth(arguments?["screenResolutionWidth"] as! Int, andHeight: arguments?["screenResolutionHeight"] as! Int)
        }
        if (arguments?["colorDepth"] != nil) {
            tracker?.subject.setColorDepth(arguments?["colorDepth"] as! Int)
        }
        if (arguments?["timezone"] != nil) {
            tracker?.subject.setTimezone(arguments?["timezone"] as? String)
        }
        if (arguments?["ipAddress"] != nil) {
            tracker?.subject.setIpAddress(arguments?["ipAddress"] as? String)
        }
        if (arguments?["userAgent"] != nil) {
            tracker?.subject.setUseragent(arguments?["userAgent"] as? String)
        }
        if (arguments?["networkUserId"] != nil) {
            tracker?.subject.setNetworkUserId(arguments?["networkUserId"] as? String)
        }
        if (arguments?["domainUserId"] != nil) {
            tracker?.subject.setDomainUserId(arguments?["domainUserId"] as? String)
        }
        
        result(nil)
    }
    
    private func onTrackPageView(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let event = EventUtil.getPageView(dict: call.arguments as? [String: Any])
        tracker?.trackPageViewEvent(event)
        
        result(nil)
    }
    
    private func onTrackStructured(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let event = EventUtil.getStructured(dict: call.arguments as? [String: Any])
        tracker?.trackStructuredEvent(event)
        
        result(nil)
    }
    
    private func onTrackUnstructured(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let event = EventUtil.getUnstructured(dict: call.arguments as? [String: Any])
        tracker?.trackUnstructuredEvent(event)
        
        result(nil)
    }
    
    private func onTrackScreenView(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let event = EventUtil.getScreenView(dict: call.arguments as? [String: Any])
        tracker?.trackScreenViewEvent(event)
        
        result(nil)
    }
    
    private func onTrackConsentWithdrawn(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let event = EventUtil.getConsentWithdrawn(dict: call.arguments as? [String: Any])
        tracker?.trackConsentWithdrawnEvent(event)
        
        result(nil)
    }
    
    private func onTrackConsentGranted(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let event = EventUtil.getConsentGranted(dict: call.arguments as? [String: Any])
        tracker?.trackConsentGrantedEvent(event)
        
        result(nil)
    }
    
    private func onTrackTiming(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let event = EventUtil.getTiming(dict: call.arguments as? [String: Any])
        tracker?.trackTimingEvent(event)
        
        result(nil)
    }
    
    private func onTrackEcommTransaction(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let event = EventUtil.getEcommTransaction(dict: call.arguments as? [String: Any])
        tracker?.trackEcommerceEvent(event)
        
        result(nil)
    }
    
    private func onTrackPushNotification(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let event = EventUtil.getPushNotification(dict: call.arguments as? [String: Any])
        tracker?.trackPushNotificationEvent(event)
        
        result(nil)
    }
}
