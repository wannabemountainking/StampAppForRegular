//
//  UserDetailView.swift
//  StampAppForRegular
//
//  Created by YoonieMac on 3/3/26.
//

import SwiftUI


// 상세 보기 화면
struct UserDetailView: View {
    @Environment(\.horizontalSizeClass) var deviceSize
    @ObservedObject var vm: StampViewModel
    
    private var isiPhone: Bool { deviceSize == .compact }
    
    var body: some View {
        NavigationStack {
            if isiPhone {
                
            } else {
                
            }
        }
    }
}

#Preview {
    UserDetailView(vm: StampViewModel(provider: StampProvider.shared))
}
