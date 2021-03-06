#
# AppDelegate.rb
# TestArrayBinding
#
# Created by Steve Ross on 1/11/10.
# Copyright Calico Web Development 2010. All rights reserved.
#

class AppDelegate
  attr_writer :window

  # Returns the support folder for the application, used to store the Core Data
  # store file.  This code uses a folder named "MyGreatApp" for
  # the content, either in the NSApplicationSupportDirectory location or (if the
  # former cannot be found), the system's temporary directory.
  def applicationSupportFolder
    paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, true)
    basePath = (paths.count > 0) ? paths[0] : NSTemporaryDirectory()
    return basePath.stringByAppendingPathComponent("TestArrayBinding")
  end

  # Creates and returns the managed object model for the application 
  # by merging all of the models found in the application bundle.
  def managedObjectModel
    if @managedObjectModel
      return @managedObjectModel
    end
    
    @managedObjectModel = NSManagedObjectModel.mergedModelFromBundles(nil)
    return @managedObjectModel
  end


  # Returns the persistent store coordinator for the application.  This 
  # implementation will create and return a coordinator, having added the 
  # store for the application to it.  (The folder for the store is created, 
  # if necessary.)
  def persistentStoreCoordinator
    if @persistentStoreCoordinator
      return @persistentStoreCoordinator
    end

    error = Pointer.new_with_type('@')
    
    fileManager = NSFileManager.defaultManager
    applicationSupportFolder = self.applicationSupportFolder
    
    if !fileManager.fileExistsAtPath(applicationSupportFolder, isDirectory:nil)
      fileManager.createDirectoryAtPath(applicationSupportFolder, attributes:nil)
    end
    
    url = NSURL.fileURLWithPath(applicationSupportFolder.stringByAppendingPathComponent("TestArrayBinding.xml"))
    @persistentStoreCoordinator = NSPersistentStoreCoordinator.alloc.initWithManagedObjectModel(self.managedObjectModel)
    if !@persistentStoreCoordinator.addPersistentStoreWithType(NSXMLStoreType, configuration:nil, URL:url, options:nil, error:error)
      NSApplication.sharedApplication.presentError(error[0])
    end

    return @persistentStoreCoordinator
  end

  # Returns the managed object context for the application (which is already
  # bound to the persistent store coordinator for the application.) 
  def managedObjectContext
    return @managedObjectContext if @managedObjectContext
    
    coordinator = self.persistentStoreCoordinator
    if coordinator
      @managedObjectContext = NSManagedObjectContext.alloc.init
      @managedObjectContext.setPersistentStoreCoordinator(coordinator)
    end
    
    return @managedObjectContext
  end

  # Returns the NSUndoManager for the application.  In this case, the manager
  # returned is that of the managed object context for the application.
  def windowWillReturnUndoManager(window)
    return self.managedObjectContext.undoManager
  end

  # Performs the save action for the application, which is to send the save:
  # message to the application's managed object context.  Any encountered errors
  # are presented to the user.
  def saveAction(sender)
    error = Pointer.new_with_type('@')
    if !self.managedObjectContext.save(error)
      NSApplication.sharedApplication.presentError(error[0])
    end
  end

  # Implementation of the applicationShouldTerminate: method, used here to
  # handle the saving of changes in the application managed object context
  # before the application terminates.
  def applicationShouldTerminate(sender)
    error = Pointer.new_with_type('@')
    reply = NSTerminateNow
    
    if self.managedObjectContext
      if self.managedObjectContext.commitEditing
        if self.managedObjectContext.hasChanges and !self.managedObjectContext.save(error)
          # This error handling simply presents error information in a panel with an 
          # "Ok" button, which does not include any attempt at error recovery (meaning, 
          # attempting to fix the error.)  As a result, this implementation will 
          # present the information to the user and then follow up with a panel asking 
          # if the user wishes to "Quit Anyway", without saving the changes.

          # Typically, this process should be altered to include application-specific 
          # recovery steps.  

          errorResult = NSApplication.sharedApplication.presentError(error[0])
          
          if errorResult
            reply = NSTerminateCancel
          else
            alertReturn = NSRunAlertPanel(nil, "Could not save changes while quitting. Quit anyway?" , "Quit anyway", "Cancel", nil)
            if alertReturn == NSAlertAlternateReturn
              reply = NSTerminateCancel
            end
          end
        end
      else
        reply = NSTerminateCancel
      end
    end
    
    return reply
  end

end
