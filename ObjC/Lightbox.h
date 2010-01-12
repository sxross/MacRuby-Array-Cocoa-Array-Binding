//
//  Lightbox.h
//  OCTestArrayBinding
//
//  Created by Steve Ross on 1/11/10.
//  Copyright 2010 Calico Web Development. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Lightbox : NSObject {
  int number;
  NSString *title;
}
@property(readwrite,assign) int number;
@property(readwrite,copy) NSString* title;
@end
