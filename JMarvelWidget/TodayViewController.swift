//
//  TodayViewController.swift
//  JMarvelWidget
//
//  Created by Joao Marcos Ribeiro Araujo on 21/02/20.
//  Copyright © 2020 JoaoMarcos. All rights reserved.
//

import Kingfisher
import NotificationCenter
import UIKit

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet private weak var character1View: UIView!
    @IBOutlet private weak var character2View: UIView!
    @IBOutlet private weak var character3View: UIView!
    @IBOutlet private weak var name1Label: UILabel!
    @IBOutlet private weak var name2Label: UILabel!
    @IBOutlet private weak var name3Label: UILabel!
    @IBOutlet private weak var main1Image: UIImageView!
    @IBOutlet private weak var main2Image: UIImageView!
    @IBOutlet private weak var main3Image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    private func loadData() {
        let dataBase = LocalDatabaseManager()
        dataBase.configure()

        let results = dataBase.objects(CharacterRealm.self)

        for result in results {
            name1Label.text = result.name
            if let url = URL(string: result.imageURL ?? "") {
                main1Image.kf.setImage(with: url)
            }
        }
    }
}
