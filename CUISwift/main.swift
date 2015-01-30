//
//  main.swift
//  CUISwift
//
//  Created by 山田宏道 on 2015/01/30.
//  Copyright (c) 2015年 Torques Inc. All rights reserved.
//

import Foundation

println("Hello, Swift!")

// NSFileManager

var filemanager	= NSFileManager()
var error : NSError?

// current directory.
var currentDirectory = filemanager.currentDirectoryPath
println("pwd .. \(currentDirectory)")

// files in current directory.
var files : [AnyObject]! = filemanager.contentsOfDirectoryAtPath(".", error: &error)
if( files != nil ){
	for file in files {
		println("file .. \(file)")
	}
}
else{
	println("no files..")
}

// create log text.
// function: format NSDate to String.
func formatDate(date : NSDate, style : String) -> String {
	let dateFormatter = NSDateFormatter()
	dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
	dateFormatter.dateFormat = style
	return  dateFormatter.stringFromDate(date)
}
var logString = "LOG:" + formatDate( NSDate(), "yyyy/MM/dd HH:mm:ss" + "\n" )

// open log file.
var logFilename = "logs.txt"
var pathLog	= currentDirectory.stringByAppendingPathComponent(logFilename)
println("logfile .. \(pathLog)")

if( filemanager.fileExistsAtPath(pathLog) == false ){
	// ファイルがなければ、空のファイルを作成
	println("create brank file")
	filemanager.createFileAtPath(pathLog, contents: NSData(), attributes: nil)
}

var logFileHandle	: NSFileHandle! = NSFileHandle(forWritingAtPath: logFilename)
var dataLog : NSData! = logString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)

// write and close log file.
if( logFileHandle != nil ){
	// seek.
	logFileHandle.seekToEndOfFile()
	
	// write.
	if( dataLog != nil ){
		logFileHandle.writeData(dataLog)
	}
	else{
		println("ERROR: cannot create log text.")
	}
	
	// close.
	logFileHandle.closeFile()
}

