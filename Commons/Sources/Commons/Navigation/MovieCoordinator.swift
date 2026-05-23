//
//  SwiftUIView.swift
//  Commons
//
//  Created by Mohamed Makhlouf Ahmed on 23/05/2026.
//

import SwiftUI
import Observation

@Observable
public final class MovieCoordinator {
    public var path = NavigationPath()
    
  public init(path: NavigationPath = NavigationPath()) {
        self.path = path
    }

   public func navigate(to destination: MovieDestination ) {
        path.append(destination)
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}

public enum MovieDestination: Hashable{
 case movieDetails(id: Int)
}
