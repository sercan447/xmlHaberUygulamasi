//
//  ViewController.swift
//  xmlHaberUygulamasi
//
//  Created by sercan on 12.01.2020.
//  Copyright © 2020 sercan. All rights reserved.
//

import UIKit
import AEXML
import Alamofire
import SDWebImage

class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
   
    

    var titles = [String]()
    var descriptions = [String]()
    var  urls = [String]()
    var newsImagesUrls = [String]()
    
    @IBOutlet weak var mytableViewim: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.mytableViewim.delegate = self
        self.mytableViewim.dataSource = self
        
        Alamofire.request("http://www.trt.net.tr/rss/kultursanat.rss").response { (response) in
            
            guard let xmldta = response.data else {
                print("cekemedi verileri")
                return
            }
            
            print("datam")
            print(xmldta)

            var opt = AEXMLOptions()
            do {
                let xmlDoc = try AEXMLDocument(xml: xmldta, options: opt)
                //print(xmlDoc.root["channel"]["item"]["title"].value!)
                
                if let items = xmlDoc.root["channel"]["item"].all {
                    for item in items {
                        
                         if let title = item["title"].value {
                            self.titles.append(title)
                            print(title)
                        }
                        if let description = item["description"].value {
                            self.descriptions.append(description)
                            print(description)
                        }
                        if let link = item["link"].value {
                             self.urls.append(link)
                            print(link)
                        }
                        
                        let enclosure = item["enclosure"]
                        if let newsImageUrl = enclosure.attributes["url"] {
                              self.newsImagesUrls.append(newsImageUrl)
                            print(newsImageUrl)
                        }
                        print("-----------")
                        
                    }
                    self.mytableViewim.reloadData()
                }
                
                
            }catch {
                print("hatalndık")
            }
        }
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
       return self.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! NewsTableViewCell
        
        cell.titleLabel.text = self.titles[indexPath.row]
        cell.urlLabel.text = self.urls[indexPath.row]
        
        //let imagem = cell.viewWithTag(1) as! UIImageView
        //imagem.sd_setImage(with: URL(string: self.newsImagesUrls[indexPath.row]))
        let _ = SDWebImageDownloader.shared.downloadImage(with:URL(string:self.newsImagesUrls[indexPath.row]),options:[],progress:nil){ (image,data,error,finish )in
            
            DispatchQueue.main.async {
                cell.imagemView.image = image
            }
        }
        
        //cell.textLabel?.text = self.titles[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newsdetailVC = storyboard?.instantiateViewController(withIdentifier: "newsDetailVC") as! NewsDetailsViewController
            newsdetailVC.newDetail = self.descriptions[indexPath.row]
        
        self.present(newsdetailVC,animated:true, completion: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        
        
    }
    
    

}

