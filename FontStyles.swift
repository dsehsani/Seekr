/*
 File Name: FontStyles.swift
    
 File Description: Creates new fonts to the font module. Please reference these.
 
*/

import Foundation
import SwiftUI

extension Font {
    
    static var navTitle: Font {
        return Font.custom("Inter-Bold", size: 24)
    }
    
    static var buttonText: Font {
        return Font.custom("Inter-SemiBold", size: 15)
    }
    
}
