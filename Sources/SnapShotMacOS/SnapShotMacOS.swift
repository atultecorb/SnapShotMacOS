import Foundation
import AVKit
import AVFoundation


public class ScreenCapture {
   // static let shareInstance = ScreenCapture()
    
  //  init() {}
    
    public var captureImage = NSImage()
    
    public init(captureImage: NSImage = NSImage()) {
        self.captureImage = captureImage
    }
    
    public func TakeScreensShots(folderName: String)-> NSImage?{
        
        var displayCount: UInt32 = 0;
        var result = CGGetActiveDisplayList(0, nil, &displayCount)
        if (result != CGError.success) {
            print("error: \(result)")
            return nil
        }
        let allocated = Int(displayCount)
        let activeDisplays = UnsafeMutablePointer<CGDirectDisplayID>.allocate(capacity: allocated)
        result = CGGetActiveDisplayList(displayCount, activeDisplays, &displayCount)
        
        if (result != CGError.success) {
            print("error: \(result)")
            return nil
        }
           
        for i in 1...displayCount {
            let unixTimestamp = CreateTimeStamp()
            let fileUrl = URL(fileURLWithPath: folderName + "\(unixTimestamp)" + "_" + "\(i)" + ".jpg", isDirectory: true)
            let screenShot:CGImage = CGDisplayCreateImage(activeDisplays[Int(i-1)])!
            let bitmapRep = NSBitmapImageRep(cgImage: screenShot)
            let jpegData = bitmapRep.representation(using: NSBitmapImageRep.FileType.jpeg, properties: [:])!
           // let sc = ScreenCapture()
            return NSImage(data: jpegData)!
           // captureImage = NSImage(data: jpegData)!
        }
        return nil
    }
    
     func CreateTimeStamp() -> Int32
    {
        return Int32(Date().timeIntervalSince1970)
    }
}
