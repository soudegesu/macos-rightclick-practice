//
//  ContentView.swift
//  macos-rightclick-practice
//
//  Created by soudegesu on 2022/02/10.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      ZStack {
        Text("Right Click here")
          .foregroundColor(Color.white)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
      }
      .background(Color.black)
      .onRightClick {
        debugPrint("Right Clicked!!")
      }
      .onTapGesture {
        debugPrint("onTap!!")
      }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
