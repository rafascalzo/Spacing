//
//  CoreDataManager.swift
//  Spacing
//
//  Created by rvsm on 15/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import CoreData

class CoreDataManager: NSObject {
    
    static var shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Spacing")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("""
                    Typical reasons for an error here include:
                    * The parent directory does not exist, cannot be created, or disallows writing.
                    * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                    * The device is out of space.
                    * The store could not be migrated to the current model version.
                    Check the error message to determine what the actual problem was.
                    """)
                print("Unresolved error \(error), \(error.userInfo)", #file, #function, #line)
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var imageResults: NSFetchedResultsController<Image>?
    var videoResults: NSFetchedResultsController<Video>?
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)", #file, #function, #line)
            }
        }
    }
    
    func updateContext() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)", #file, #function, #line)
        }
    }
    
    // MARK: FetchData
    
    func fetchImages() -> Array<Image> {
        let fetchRequest:NSFetchRequest<Image> = Image.fetchRequest()
        let dateSort = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [dateSort]
        
        imageResults = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try imageResults?.performFetch()
        } catch {
            print(error.localizedDescription, #file, #function, #line)
        }
        
        guard let objects = imageResults?.fetchedObjects else { return [] }
        return objects
    }
    
    func save(image: Image) {
        var newImage: NSManagedObject?
        
        let images = fetchImages().filter() { $0.url == image.url }
        
        if !images.isEmpty {
            guard let image = images.first else { return }
            newImage = image
        } else {
            guard let entity = NSEntityDescription.entity(forEntityName: "Image", in: context) else { return }
            newImage = NSManagedObject(entity: entity, insertInto: context)
        }
        
        newImage?.setValue(image.id, forKey: "id")
        newImage?.setValue(image.hd, forKey: "hd")
        newImage?.setValue(image.url, forKey: "url")
        newImage?.setValue(image.date, forKey: "date")
        
        updateContext()
    }

    func fetchVideos() -> Array<Video> {
        let fetchRequest:NSFetchRequest<Video> = Video.fetchRequest()
        let dateSort = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [dateSort]
        
        videoResults = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try videoResults?.performFetch()
        } catch {
            print(error.localizedDescription, #file, #function, #line)
        }
        
        guard let objects = videoResults?.fetchedObjects else { return []}
        return objects
    }
    
    func save(video: Video) {
        var newVideo: NSManagedObject?
        
        let videos = fetchVideos().filter() { $0.url == video.url }
        
        if !videos.isEmpty {
            guard let oldVideo = videos.first else { return }
            newVideo = oldVideo
        } else {
            guard let entity = NSEntityDescription.entity(forEntityName: "Vide", in: context) else { return }
            newVideo = NSManagedObject(entity: entity, insertInto: context)
        }
        
        newVideo?.setValue(video.id, forKey: "id")
        newVideo?.setValue(video.hd, forKey: "hd")
        newVideo?.setValue(video.url, forKey: "url")
        newVideo?.setValue(video.date, forKey: "date")
        
        updateContext()
    }
    
    func delete(object: NSManagedObject) {
        context.delete(object)
        updateContext()
    }
}
