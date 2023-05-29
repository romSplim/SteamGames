//
//  testData.swift
//  SteamGames
//
//  Created by ramil on 29.05.2023.
//

import Foundation

enum TestData {
    static let title = "lkleng lnkgnkngkn kgnkgneklgeklnenk gneklngle rngklengklnegl kenlgknerlkg nelkgnen grkeng"
    static let description = "You use this method to decouple the need to display a view controller from the process of actually presenting that view controller onscreen. Using this method, a view controller does not need to know whether it is embedded inside a navigation controller or split-view controller. It calls the same method for both. In a regular environment, the UISplitViewController class overrides this method and installs vc as its detail view controller; in a compact environment, the split view controller’s implementation of this method calls show(_:sender:) instead.The default implementation of this method calls the targetViewController(forAction:sender:) method to locate an object in the view controller hierarchy that overrides this method. It then calls the method on that target object, which displays the view controller in an appropriate way. If the targetViewController(forAction:sender:) method returns nil, this method uses the window’s root view controller to present vc modally. You can override this method in custom view controllers to display vc yourself. Use this method to display vc in a secondary context. For example, a container view controller might use this method to replace its secondary child. Your implementation should adapt its behavior for both regular and compact environments."
    
}
