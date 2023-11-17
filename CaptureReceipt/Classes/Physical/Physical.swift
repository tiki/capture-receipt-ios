/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in the root directory.
 */

import Foundation
import BlinkReceipt
import AVKit

/// A Swift class representing physical receipt scanning functionality.
public class Physical {
    
    private static var scanCallback: PhysicalScanCallbacks? = nil
    
    /// Initiates a receipt scanning process using the device's camera.
    func scan(scanCallback: PhysicalScanCallbacks) {
        Physical.scanCallback = scanCallback
        let scanResultsDelegate = UIApplication.shared.windows.first!.rootViewController!
        
        let mediaType = AVMediaType.video
        let authStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
        let scanOptions = BRScanOptions()
        scanOptions.detectDuplicates = true
        scanOptions.storeUserFrames = true
        scanOptions.jpegCompressionQuality = 100
        scanOptions.detectLogo = true
        
        if authStatus == .authorized {
            DispatchQueue.main.async {
                BRScanManager.shared().startStaticCamera(
                    from: scanResultsDelegate,
                    cameraType: .uxStandard,
                    scanOptions: BRScanOptions(),
                    with: scanResultsDelegate)
            }
        } else {
            AVCaptureDevice.requestAccess(for: mediaType) { granted in
                if granted {
                    DispatchQueue.main.async {
                        BRScanManager.shared().startStaticCamera(
                            from: scanResultsDelegate,
                            cameraType: .uxStandard,
                            scanOptions: BRScanOptions(),
                            with: scanResultsDelegate)
                    }
                } else {
                    scanCallback.onError(NSError(domain: "No camera access", code: -1))
                    Physical.scanCallback = nil
                }
            }
        }
    }
    
    internal static func scanResult(_ receipt: Receipt){
        scanCallback?.onResult(receipt)
        scanCallback = nil
    }
    
    internal static func scanCancelled(){
        scanCallback?.onCancel()
        scanCallback = nil
    }
    
    internal static func scanError(_ error: Error){
        scanCallback?.onError(error)
        scanCallback = nil
    }
}
