import SwiftUI
import AuthenticationServices


struct ContentView: View {
    @StateObject private var ads = ADmanager()
    @State private var err : String = ""
    
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button{
                Task{
                    do{
                        
                        try await AuthenticationView().logout()
                    } catch let e {
                        
                        err = e.localizedDescription
                    }
                }
                } label: {
                    Text("Log Out").padding(8)
                }.buttonStyle(.borderedProminent)
                
                Text(err).foregroundColor(.red).font(.caption)
            
            
            VStack {
                Button {
                    if let rootVC = UIApplication.shared.topViewController(){
                        ads.showAd(from: rootVC)
                    }
                } label: {
                    Text("Press")
                }
                
                BannerAdView()

            }
            .padding()
                
                
            }
            .padding()
    }
}

#Preview {
    ContentView()
}
