//
//  NewsDetailsViewController.swift
//  xmlHaberUygulamasi
//
//  Created by sercan on 13.01.2020.
//  Copyright © 2020 sercan. All rights reserved.
//

import UIKit

class NewsDetailsViewController: UIViewController {

    var newDetail : String?
    
    @IBOutlet weak var textViewDetay: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textViewDetay.text = newDetail
    }
    
    override func didReceiveMemoryWarning() {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
