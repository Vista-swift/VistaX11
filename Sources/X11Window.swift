//
//  X11Window.swift
//  Vista
//
//  Created by Patrick Horlebein on 15.12.15.
//  Copyright © 2015 Piay Softworks. All rights reserved.
//

import Foundation
import VistaCommon
import CX11.Xlib
import CX11.X
import CGLX.Glx
import CGLX.Glu

var d: _XPrivDisplay = nil

public class X11Window {
    
    var w: Window
    
    var s: UnsafeMutablePointer<Screen>
    
    public var onClose: (Void -> Void)?
    
    public var title: String {
        set {
        }
        get {
            return String()
        }
    }
    
    public var frame: NSRect {
        set {
        }
        get {
            return NSRect()
        }
    }
    
    public init(withRect frame: NSRect,
                delegate: WindowDelegate,
                kernel: OpenGLKernel,
                onClose: (Void -> Void)?) {
                    
        if d == nil {
            d = XOpenDisplay(nil)
            if d == nil {
                fatalError("cannot open display")
            }
        }
                    
        s = XDefaultScreenOfDisplay(d)
        let rootWindow = s.memory.root
        w = XCreateSimpleWindow(d,
                                rootWindow,
                                Int32(frame.origin.x.native),
                                Int32(frame.origin.y.native),
                                UInt32(frame.size.width.native),
                                UInt32(frame.size.height.native),
                                1,
                                s.memory.black_pixel,
                                s.memory.white_pixel)
        XSelectInput(d, w, ExposureMask | KeyPressMask)
        XMapWindow(d, w)
        XFlush(d)
    }
    
    public func makeCurrent() {
        XFillRectangle(d, w, s.memory.default_gc, 20, 20, 10, 10)
    }
    
    public func pollEvents() -> [Event] {
        return []
    }
    
    public func close() {
    }
}
