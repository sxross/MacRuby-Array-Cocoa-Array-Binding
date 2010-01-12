//
//  OCTestArrayBinding_AppDelegate.h
//  OCTestArrayBinding
//
//  Created by Steve Ross on 1/11/10.
//  Copyright Calico Web Development 2010 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface OCTestArrayBinding_AppDelegate : NSObject 
{
    NSWindow *window;
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) IBOutlet NSWindow *window;

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:sender;

@end
