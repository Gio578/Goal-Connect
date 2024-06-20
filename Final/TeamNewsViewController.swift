//
//  TeamNewsViewController.swift
//  Final
//
//  Created by Giovanni Rivera on 12/4/23.
//

import UIKit

struct NewsItem {
    let title: String
    let subtitle: String
    let imageName: String
}

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
}

class TeamNewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var featuredNewsImage: UIImageView!
    @IBOutlet weak var featuredTitle: UILabel!
    @IBOutlet weak var featuredSubTitle: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var newsItems: [NewsItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        featuredTitle.text = "USA Falls to Netherlands 1 - 3"
        featuredSubTitle.text = "2022 World Cup"
        
        newsItems = [
            NewsItem(title: "USA Defeats Iran 1 - 0", subtitle: "2022 World Cup", imageName: "usavsiran"),
            NewsItem(title: "USA and England Draw 0 - 0", subtitle: "2022 World Cup", imageName: "usavsengland"),
            NewsItem(title: "USA and Wales Draw 1 - 1", subtitle: "2022 World Cup", imageName: "usavswales"),
        ]
        
        tableView.dataSource = self
        tableView.delegate = self
                
        if let featuredItem = newsItems.first {
            featuredNewsImage.image = UIImage(named: featuredItem.imageName)
        }
                
        tableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
                    fatalError("Could not dequeue NewsTableViewCell")
        }
        let newsItem = newsItems[indexPath.row]
        cell.titleLabel.text = newsItem.title
        cell.subtitleLabel.text = newsItem.subtitle
        cell.newsImageView.image = UIImage(named: newsItem.imageName)
        return cell
    }
}
