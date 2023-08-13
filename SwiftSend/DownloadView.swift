import SwiftUI

struct DownloadView: View {
    @State private var V_Code: String = ""
    var body: some View {
        Text("请输入取件码")
            .font(.largeTitle)
        TextField("", text: $V_Code)
//            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 200)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 2) // 设置边框颜色为蓝色
            )
    }
}
