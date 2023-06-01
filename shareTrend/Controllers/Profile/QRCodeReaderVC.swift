//
//  QRCodeReaderVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 21.05.2022.
//

import AVFoundation
import UIKit
import Lottie

protocol ScannerDelegate {
    func found(code: String)
}

class QRCodeReaderVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var scanDelege: ScannerDelegate?
    private var animationView: AnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()

        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
//        view.addSubview(customView)
        captureSession.startRunning()
        animationView = .init(name: "qrscanner")
        animationView!.frame = view.bounds
         // 3. Set animation content mode
        animationView!.contentMode = .scaleAspectFit
         // 4. Set animation loop mode
        animationView!.loopMode = .loop
         // 5. Adjust animation speed
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
         // 6. Play animation
        animationView!.play()
    }

    func failed() {
        let ac = UIAlertController(title: "Scanning not supported".localized(), message: "Your device does not support scanning a code from an item. Please use a device with a camera.".localized(), preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok".localized(), style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            scanDelege?.found(code: stringValue)
        }
        navigationController?.popViewController(animated: true)
    }

    func found(code: String) {
        print(code)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
