//
//  ViewController.swift
//  ios-core-data-app
//
//  Created by Alexander Escamilla on 10/31/20.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var score = 0
    @IBOutlet weak var scorelabel: UILabel!
    @IBOutlet weak var scoreSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        scorelabel.text = "\(Int(score))"
        scoreSlider.value = Float(score)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let slidingValue = Int(sender.value)
        score = slidingValue
        scorelabel.text = String(slidingValue)
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        saveData()
    }
    
    
    
    func saveData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        
        newEntity.setValue(Int(scoreSlider.value), forKey: "score")
        do {
            try context.save()
            print("Saved data")
        } catch {
            print("Failed to save data")
        }
    }
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                score = data.value(forKey: "score") as! Int
            }
        } catch {
            print("Failed to load data")
        }
    }


}

