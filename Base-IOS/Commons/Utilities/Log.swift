//
//  Log.swift
//  
//
//  Created by Le Duc Canh on 1/13/19.
//  Copyright © 2019 Le Duc Canh. All rights reserved.
//

import UIKit

// Print log
func Log(_ message: String,
         file: String = #file,
         line: Int = #line) {
    let fileURL = NSURL(fileURLWithPath: file)
    let fileName = fileURL.deletingPathExtension?.lastPathComponent ?? ""
    print("\(fileName)[L\(line)]:\(message)")
}
