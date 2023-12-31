//
//  ContentView.swift
//  SwiftSend
//
//  Created by Dump on 2023/8/9.
//

import SwiftUI

struct ContentView: View {
    @State private var isImporting: Bool = false
    @State private var selectedFile: URL?
    @State private var showDownloadView = false
    let WIDTH: Double = UIScreen.main.bounds.width
    let HEIGHT: Double = UIScreen.main.bounds.height
    var Image_Size: Double {
        if WIDTH/2.62 >= HEIGHT/5.68 {
            return HEIGHT/5.68
        }
        else
        {
            return WIDTH/2.62
        }
    }
    var body: some View {
        NavigationView {
            VStack {
//                            Text("Screen Width: \(HEIGHT/5.68)")
                VStack {
                    Image("cloud")
                        .resizable()
                        .frame(width: Image_Size, height: Image_Size)
                        .padding()
                    Text("SwiftSend")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .padding()
                        .bold()
//                        .padding(.bottom, HEIGHT/3.125926)
                }
                Spacer()
                VStack {
                    Button {
                        isImporting = true
                    } label: {
                        Text("Send")
//                            .frame(maxWidth: .infinity)
                            .frame(width: WIDTH/1.965)
                    }
                    .font(.title)
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .fileImporter(isPresented: $isImporting, allowedContentTypes: [.image, .audio, .video]) {
                        result in do {
                            let fileURL = try result.get()
                            selectedFile = fileURL
                            // 在这里你可以处理选择的文件，比如上传操作
                        }
                        catch
                        {
                            // 处理错误
                        }
                    }
                    Button {
                        showDownloadView = true
                    } label: {
                        Text("Receive").frame(width: WIDTH/1.965)
                    }
                    .font(.title)
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding()
                    NavigationLink("", destination: DownloadView(), isActive: $showDownloadView)
                        .opacity(0)
                }
            }
        }
    }
    func getFileSize(for fileURL: URL?) -> Double? {
        guard let fileURL = fileURL else {
            return nil
        }

        do {
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: fileURL.path)
            if let fileSize = fileAttributes[FileAttributeKey.size] as? UInt64 {
                let byteCountFormatter = ByteCountFormatter()
                byteCountFormatter.allowedUnits = [.useBytes, .useKB, .useMB, .useGB]
                byteCountFormatter.countStyle = .file
                byteCountFormatter.includesUnit = false
                let fileSizeInBytes = Double(fileSize)
                return fileSizeInBytes / pow(1024, 3) // 将字节转换为 GB
            }
        } catch {
            return nil
        }
        return nil
    }
    func Upload() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
