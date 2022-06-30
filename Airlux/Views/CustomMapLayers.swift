//
//  AQIMapView.swift
//  Airlux
//
//  Created by Keane Hui on 30/6/2022.
//

import SwiftUI
import WebKit

struct AQIMapView: View {
    var body: some View {
        WebView(fileName: "AQIMap")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
    }
}

struct PollenMapView: View {
    var body: some View {
        WebView(fileName: "PollenMap")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
    }
}

struct WebView: UIViewRepresentable {
    var fileName: String
    
    typealias UIViewType = WKWebView
    
    private let webView = WKWebView()
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        webView.load(fileName)
    }
}

extension WKWebView {
    func load(_ fileName: String) {
        guard !fileName.isEmpty else {
            print("Loading failed. Filename is empty. ")
            return
        }
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "html") else {
            print("Invalid path. ")
            return
        }
        do {
            let htmlString = try String(contentsOfFile: filePath, encoding: .utf8)
            loadHTMLString(htmlString, baseURL: URL(fileURLWithPath: filePath))
        } catch {
            print("WebView error: \(error.localizedDescription)")
        }
    }
}

extension WKWebView {
    override open var safeAreaInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

struct AQIMapView_Previews: PreviewProvider {
    static var previews: some View {
        AQIMapView()
    }
}
