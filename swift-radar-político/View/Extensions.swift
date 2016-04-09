//
//  Extensions.swift
//  swift-radar-político
//
//  Created by Ulysses on 4/9/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import Foundation
extension UIView {
    
    func cropToCircle(){
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.clipsToBounds = true
    }
    
    func roundCorner(){
        self.layer.cornerRadius = 6.0
        self.clipsToBounds = true
    }
    
    func highlightCorner(){
        self.layer.borderColor = UIColor.greenColor().CGColor
        self.layer.borderWidth = 1.0
    }
    
    func unhighlightCorner(){
        self.layer.borderWidth = 0.0
    }
    
}

extension NSDate{
    
    func getFormatedDateString()->String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()
        return dateFormatter.stringFromDate(self)
    }
}

extension String {
    
    func calculateHeightForString(fontSize:CGFloat, screnSize:CGSize, padding:CGFloat) -> CGFloat{
        let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(fontSize)]
        let attrString:NSAttributedString? = NSAttributedString(string: self, attributes: attributes)
        
        let rect:CGRect = attrString!.boundingRectWithSize(CGSizeMake(screnSize.width-padding,CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context:nil )
        
        let requredSize:CGRect = rect
        return requredSize.height
    }
    
}

