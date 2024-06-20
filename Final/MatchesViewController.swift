//
//  MatchesViewController.swift
//  Final
//
//  Created by Giovanni Rivera on 12/3/23.
//

import UIKit
import UserNotifications

struct Match {
    var date: String
    var match: String
    var score: String
    var opponentTeam: String
}

class MatchCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var matchLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var opponentFlagImageView: UIImageView!

    func configure(with match: Match) {
        dateLabel.text = match.date
        matchLabel.text = match.match
        scoreLabel.text = "\(match.score)"
        opponentFlagImageView.image = UIImage(named: match.opponentTeam)
    }
    
}

class MatchesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var matches: [Match] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
        matches = [
            Match(date: "Round of 16 - December 3, 2022", match: "Netherlands VS USA", score: "3 - 1", opponentTeam: "netherlands"),
            Match(date: "Group B - November 29, 2022", match: "Iran VS USA", score: "0 - 1", opponentTeam: "iran"),
            Match(date: "Group B - November 25, 2022", match: "England VS USA", score: "0 - 0", opponentTeam: "england"),
            Match(date: "Group B - November 25, 2022", match: "Wales VS USA", score: "1 - 1", opponentTeam: "wales")
        ]
            
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as? MatchCell else {
            fatalError("Unable to dequeue MatchCell")
        }
        let match = matches[indexPath.row]
        cell.configure(with: match)
        return cell
    }
    
    
    
    static func scheduleMatchNotification(for match: Match) {
            let content = UNMutableNotificationContent()
            content.title = "Latest Match Result"
            content.body = "\(match.match): \(match.score)"
            content.sound = UNNotificationSound.default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 8, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
            UNUserNotificationCenter.current().add(request)
        }
}
