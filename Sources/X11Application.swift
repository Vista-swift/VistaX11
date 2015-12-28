//
//  X11Application.swift
//  Vista
//
//  Created by Patrick Horlebein on 15.12.15.
//  Copyright © 2015 Piay Softworks. All rights reserved.
//

import Foundation
import VistaCommon
import CGLX.X
import CGLX.Glx

public class X11Application {

    let delegate: ApplicationDelegate

    public init(withDelegate delegate: ApplicationDelegate) {
        self.delegate = delegate
    }

    public func run() {
        delegate.applicationDidFinishLaunching()
    }

    public func terminate() {
        //exit(0)
    }

    public func pollEvents() -> X11Events {
        return X11Events()
    }
}

public class X11Events: GeneratorType, SequenceType {

    public typealias Element = VIEvent

    public func generate() -> X11Events {
        return self
    }

    public func next() -> Element? {
	let e = UnsafeMutablePointer<_XEvent>.alloc(1)
	XNextEvent(d, e)
        return nil
    }
}
