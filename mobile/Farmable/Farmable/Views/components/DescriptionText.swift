//
//  DescriptionText.swift
//  Farmable
//
//  Created by HeeJu Kim on 3/9/24.
//

import Foundation
import SwiftUI

struct DescriptionText: View {
    let description: String
    let value: String?
    
    var body: some View {
        HStack {
            Text(description)
                .font(.system(size: 16))
                .foregroundColor(.gray)
            Text(value ?? "")
                .font(.system(size: 18))
                .foregroundColor(.black)
        }
    }
}
