//
//  AppDelegate.swift
//  OSCKitDemo
//
//  Created by Sam Smallman on 06/05/2021.
//

import Cocoa
import OSCKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!
    @IBOutlet weak var oscAnnotationTextField: NSTextField!
    @IBOutlet weak var sendButton: NSButton!
    @IBOutlet var textView: NSTextView!
    
    // MARK:  OSC UDP Server
//    private let udpServer = OSCUdpServer(port: 3001)
    
    // MARK: OSC UDP Client
//    private let udpClient = OSCUdpClient(host: "192.168.1.25", port: 3002)
    
    // MARK: OSC UDP Peer
//    private let udpPeer = OSCUdpPeer(host: "192.168.1.25", port: 3001, hostPort: 3002)
    
    // MARK: OSC TCP SLIP Server
//    private let tcpSLIPServer = OSCTcpServer(port: 3001, streamFraming: .SLIP)
    
    // MARK: OSC TCP SLIP Server
//    private let tcpPLHServer = OSCTcpServer(port: 3001, streamFraming: .PLH)
    
    // MARK: OSC TCP SLIP Client
//    private let tcpSLIPClient = OSCTcpClient(host: "192.168.1.25", port: 3001, streamFraming: .SLIP)
    
    // MARK: OSC TCP PLH Client
//    private let tcpPLHClient = OSCTcpClient(host: "192.168.1.25", port: 3001, streamFraming: .PLH)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // MARK:  OSC UDP Server
//         udpServer.delegate = self
        
        // MARK: OSC UDP Client
//        udpClient.delegate = self
        
        // MARK: OSC UDP Peer
//        udpPeer.delegate = self
        
        // MARK: OSC TCP SLIP Server
//        tcpSLIPServer.delegate = self
        
        // MARK: OSC TCP PLH Server
//        tcpPLHServer.delegate = self
        
        // MARK: OSC TCP SLIP Client
//        tcpSLIPClient.delegate = self
        
        // MARK: OSC TCP PLH Client
//        tcpPLHClient.delegate = self
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func sendButtonDidClick(_ sender: Any) {
        guard let message = OSCAnnotation.message(for: oscAnnotationTextField.stringValue, style: .spaces)
        else { return }

        // MARK: OSC UDP Peer
//        try? udpPeer.send(message)
            
        // MARK: OSC UDP Client
//        try? udpClient.send(message)
        
        // MARK: OSC TCP SLIP Server
//        tcpSLIPServer.send(message)
        
        // MARK: OSC TCP PLH Server
//        tcpPLHServer.send(message)
        
        // MARK: OSC TCP SLIP Client
//        try? tcpSLIPClient.send(message)
        
        // MARK: OSC TCP PLH Client
//        try? tcpPLHClient.send(message)

    }
    
    @IBAction func startButtonDidClick(_ sender: Any) {
        // MARK:  OSC UDP Server
//        try? udpServer.startListening()
        
        // MARK: OSC UDP Peer
//        try? udpPeer.startRunning()
        
        // MARK: OSC TCP SLIP Server
//        try? tcpSLIPServer.startListening()
        
        // MARK: OSC TCP PLH Server
//        try? tcpPLHServer.startListening()
        
        // MARK: OSC TCP SLIP Client
//        try? tcpSLIPClient.connect()
        
        // MARK: OSC TCP PLH Client
//        try? tcpPLHClient.connect()
        
    }
    
    @IBAction func stopButtonDidClick(_ sender: Any) {
        // MARK:  OSC UDP Server
//        udpServer.stopListening()
        
        // MARK:  OSC UDP Peer
//        udpPeer.stopRunning()
        
        // MARK: OSC TCP SLIP Server
//        tcpSLIPServer.stopListening()
        
        // MARK: OSC TCP PLH Server
//        tcpPLHServer.stopListening()
        
        // MARK: OSC TCP SLIP Client
//        tcpSLIPClient.disconnect()
        
        // MARK: OSC TCP PLH Client
//        tcpPLHClient.disconnect()
    }
}

// MARK:  OSC UDP Server
extension AppDelegate: OSCUdpServerDelegate {

    func server(_ server: OSCUdpServer, didReceivePacket packet: OSCPacket, fromHost host: String, port: UInt16) {
        guard let message = packet as? OSCMessage else { return }
        let annotation = OSCAnnotation.annotation(for: message, style: .spaces, type: true)
        DispatchQueue.main.async {
            self.textView.string += "Rx: \(annotation)\r"
        }
    }

    func server(_ server: OSCUdpServer, socketDidCloseWithError error: Error?) {
        print(error?.localizedDescription ?? "Socket Closed")
    }

    func server(_ server: OSCUdpServer, didReadData data: Data, with error: Error) {
        print(error.localizedDescription)
    }
    
}

extension AppDelegate: OSCUdpClientDelegate {
    
    func client(_ client: OSCUdpClient, didSendPacket packet: OSCPacket, fromHost host: String?, port: UInt16?) {
        guard let message = packet as? OSCMessage else { return }
        let annotation = OSCAnnotation.annotation(for: message, style: .spaces, type: true)
        DispatchQueue.main.async {
            self.textView.string += "Tx: \(annotation)\r"
        }
    }
    
    func client(_ client: OSCUdpClient, didNotSendPacket packet: OSCPacket, fromHost host: String?, port: UInt16?, error: Error?) {
        print(error?.localizedDescription ?? "Didn't Send Packet")
    }
    
    func client(_ client: OSCUdpClient, socketDidCloseWithError error: Error) {
        print(error.localizedDescription)
    }
    
}

extension AppDelegate: OSCUdpPeerDelegate {
    
    func peer(_ peer: OSCUdpPeer, didReceivePacket packet: OSCPacket, fromHost host: String, port: UInt16) {
        guard let message = packet as? OSCMessage else { return }
        let annotation = OSCAnnotation.annotation(for: message, style: .spaces, type: true)
        DispatchQueue.main.async {
            self.textView.string += "Rx: \(annotation)\r"
        }
    }

    func peer(_ peer: OSCUdpPeer, didReadData data: Data, with error: Error) {
        print(error.localizedDescription)
    }

    func peer(_ peer: OSCUdpPeer, didSendPacket packet: OSCPacket, fromHost host: String?, port: UInt16?) {
        guard let message = packet as? OSCMessage else { return }
        let annotation = OSCAnnotation.annotation(for: message, style: .spaces, type: true)
        DispatchQueue.main.async {
            self.textView.string += "Tx: \(annotation)\r"
        }
    }

    func peer(_ peer: OSCUdpPeer, didNotSendPacket packet: OSCPacket, fromHost host: String?, port: UInt16?, error: Error?) {
        print(error?.localizedDescription ?? "Didn't Send Packet")
    }

    func peer(_ peer: OSCUdpPeer, socketDidCloseWithError error: Error?) {
        print(error?.localizedDescription ?? "Socket Closed")
    }
    
}

extension AppDelegate: OSCTcpServerDelegate {
    
    func server(_ server: OSCTcpServer, didConnectToClientWithHost host: String, port: UInt16) {
        print("Client Connected: \(host):\(port)")
    }
    
    func server(_ server: OSCTcpServer, didDisconnectFromClientWithHost host: String, port: UInt16) {
        print("Client Disconnect: \(host):\(port)")
    }
    
    func server(_ server: OSCTcpServer, didReceivePacket packet: OSCPacket, fromHost host: String, port: UInt16) {
        guard let message = packet as? OSCMessage else { return }
        let annotation = OSCAnnotation.annotation(for: message, style: .spaces, type: true)
        DispatchQueue.main.async {
            self.textView.string += "Rx: \(annotation)\r"
        }
    }
    
    func server(_ server: OSCTcpServer, didSendPacket packet: OSCPacket, toClientWithHost host: String, port: UInt16) {
        guard let message = packet as? OSCMessage else { return }
        let annotation = OSCAnnotation.annotation(for: message, style: .spaces, type: true)
        DispatchQueue.main.async {
            self.textView.string += "Tx: \(annotation)\r"
        }
    }
    
    func server(_ server: OSCTcpServer, socketDidCloseWithError error: Error?) {
        print(error?.localizedDescription ?? "Socket Closed")
    }
    
    func server(_ server: OSCTcpServer, didReadData data: Data, with error: Error) {
        print(error.localizedDescription)
    }
    
}

extension AppDelegate: OSCTcpClientDelegate {
    
    func client(_ client: OSCTcpClient, didConnectTo host: String, port: UInt16) {
        print("Connected To: \(host):\(port)")
    }
    
    func client(_ client: OSCTcpClient, didDisconnectWith error: Error?) {
        print(error?.localizedDescription ?? "Disconnected")
    }
    
    func client(_ client: OSCTcpClient, didSendPacket packet: OSCPacket) {
        guard let message = packet as? OSCMessage else { return }
        let annotation = OSCAnnotation.annotation(for: message, style: .spaces, type: true)
        DispatchQueue.main.async {
            self.textView.string += "Tx: \(annotation)\r"
        }
    }
    
    func client(_ client: OSCTcpClient, didReceivePacket packet: OSCPacket) {
        guard let message = packet as? OSCMessage else { return }
        let annotation = OSCAnnotation.annotation(for: message, style: .spaces, type: true)
        DispatchQueue.main.async {
            self.textView.string += "Rx: \(annotation)\r"
        }
    }
    
    func client(_ client: OSCTcpClient, didReadData data: Data, with error: Error) {
        print(error.localizedDescription)
    }
    
}

