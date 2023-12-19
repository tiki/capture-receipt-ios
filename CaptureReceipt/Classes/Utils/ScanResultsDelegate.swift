/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in the root directory.
 */

import UIKit
import BlinkReceipt

/// An extension for the `UIViewController` class to conform to the `BRScanResultsDelegate` protocol.
extension UIViewController: BRScanResultsDelegate{

    /// This method is called when scanning is completed successfully.
    ///
    /// - Parameters:
    ///   - cameraViewController: The `UIViewController` responsible for scanning.
    ///   - scanResults: The scan results obtained from the scanning process.
    public func didFinishScanning(_ cameraViewController: UIViewController, with scanResults: BRScanResults) {
        cameraViewController.dismiss(animated: true, completion: nil)
        Physical.scanResult(Receipt(scanResults: scanResults))
    }
    /// This method is called when scanning is canceled.
    ///
    /// - Parameter cameraViewController: The `UIViewController` responsible for scanning.
    public func didCancelScanning(_ cameraViewController: UIViewController!){
        cameraViewController.dismiss(animated: true, completion: nil)
        Physical.scanCancelled()
    }
    /// This method is called when an error occurs during scanning.
    ///
    /// - Parameter error: The error that occurred during scanning.
    public func scanningErrorOccurred(_ error: Error!){
        Physical.scanError(error)
    }
    
}
