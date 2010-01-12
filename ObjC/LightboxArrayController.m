//
//  LightboxArrayController.m
//  OCTestArrayBinding
//
//  Created by Steve Ross on 1/11/10.
//  Copyright 2010 Calico Web Development. All rights reserved.
//

#import "LightboxArrayController.h"
#import "Lightbox.h"

@implementation LightboxArrayController
- (void) awakeFromNib {
  NSLog(@"initializing");
  Lightbox *theLightbox = [[Lightbox alloc] init];
  theLightbox.title = @"Title 123";
  theLightbox.number = 112233;
  [self addObject:theLightbox];
  theLightbox.title = @"Title 234";
  theLightbox.number = 223344;
  [self addObject:theLightbox];
}
@end
