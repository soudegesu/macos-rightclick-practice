//
//  View+RightClick.swift
//  macos-rightclick-practice
//
//  Created by soudegesu on 2022/02/10.
//

import SwiftUI

class RightClickableView : NSView {
  
  let performOnRightMouseDown: () -> Void

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(performOnRightMouseDown: @escaping () -> Void) {
    self.performOnRightMouseDown = performOnRightMouseDown
    super.init(frame: NSRect())
  }
  
  override func mouseUp(with event: NSEvent) {
    superview?.mouseUp(with: event)
  }
  
  override func mouseDown(with event: NSEvent) {
    superview?.mouseDown(with: event)
  }
  
  override func mouseMoved(with event: NSEvent) {
    superview?.mouseMoved(with: event)
  }
  
  override func mouseExited(with event: NSEvent) {
    superview?.mouseExited(with: event)
  }
  
  override func mouseDragged(with event: NSEvent) {
    superview?.mouseDragged(with: event)
  }
  
  override func mouseEntered(with event: NSEvent) {
    superview?.mouseEntered(with: event)
  }
  
  override func rightMouseUp(with event: NSEvent) {
    superview?.rightMouseUp(with: event)
  }
  
  override func rightMouseDown(with theEvent: NSEvent) {
    performOnRightMouseDown()
    superview?.rightMouseDown(with: theEvent)
  }
  
  override func rightMouseDragged(with event: NSEvent) {
    superview?.rightMouseDragged(with: event)
  }
  
  override func otherMouseUp(with event: NSEvent) {
    superview?.otherMouseUp(with: event)
  }
  
  override func otherMouseDown(with event: NSEvent) {
    superview?.otherMouseDown(with: event)
  }
  
  override func otherMouseDragged(with event: NSEvent) {
    superview?.otherMouseDragged(with: event)
  }
}


struct RightClickable: NSViewRepresentable {
  
  let perform: () -> Void
  let frame: NSRect
  
  func makeNSView(context: Context) -> NSView {
    let view = RightClickableView(performOnRightMouseDown: perform)
    view.frame = frame
    let options: NSTrackingArea.Options = [
      .mouseEnteredAndExited,
      .inVisibleRect,
      .activeAlways,
    ]
    let trackingArea = NSTrackingArea(
      rect: frame,
      options: options,
      owner: context.coordinator,
      userInfo: nil
    )
    view.addTrackingArea(trackingArea)
    return view
  }
  
  func updateNSView(_ nsView: NSView, context: Context) {
  }
  
  static func dismantleNSView(_ nsView: NSView, coordinator: Coordinator) {
    nsView.trackingAreas.forEach { nsView.removeTrackingArea($0) }
  }

}

struct RightClickModifier: ViewModifier {
  
  var perform: () -> Void
  
  func body(content: Content) -> some View {
    GeometryReader { proxy in
      ZStack {
        content
        RightClickable(perform: perform, frame: proxy.frame(in: .global))
      }
    }
  }
}

extension View {
  func onRightClick(_ perform: @escaping () -> Void) -> some View {
    modifier(RightClickModifier(perform: perform))
  }
}
