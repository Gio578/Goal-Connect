//
//  TeamStatsViewController.swift
//  Final
//
//  Created by Giovanni Rivera on 11/28/23.
//

import UIKit

struct PlayerStat {
    var playerName: String
    var goals: Int
    var assists: Int
    var yellowCards: Int
    var redCards: Int
}

class PlayerStatsCell: UITableViewCell {
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var goalsLabel: UILabel!
    @IBOutlet weak var assistsLabel: UILabel!
    @IBOutlet weak var yellowCardsLabel: UILabel!
    @IBOutlet weak var redCardsLabel: UILabel!
    
    func configure(with stat: PlayerStat, selectedStatIndex: Int) {
            playerNameLabel.text = stat.playerName

            goalsLabel.isHidden = selectedStatIndex != 0
            goalsLabel.text = selectedStatIndex == 0 ? "\(stat.goals)" : ""
            
            assistsLabel.isHidden = selectedStatIndex != 1
            assistsLabel.text = selectedStatIndex == 1 ? "\(stat.assists)" : ""

            yellowCardsLabel.isHidden = selectedStatIndex != 2
            yellowCardsLabel.text = selectedStatIndex == 2 ? "\(stat.yellowCards)" : ""

            redCardsLabel.isHidden = selectedStatIndex != 3
            redCardsLabel.text = selectedStatIndex == 3 ? "\(stat.redCards)" : ""
    }
}

class TeamStatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedStatIndex: Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segCtrl: UISegmentedControl!
    
    var playerStats: [PlayerStat] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerStats = [
            PlayerStat(playerName: "Timothy Weah", goals: 1, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Christian Pulisic", goals: 1, assists: 2, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Haji Wright", goals: 1, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Sergino Dest", goals: 0, assists: 1, yellowCards: 1, redCards: 0),
            PlayerStat(playerName: "Tyler Adams", goals: 0, assists: 0, yellowCards: 1, redCards: 0),
            PlayerStat(playerName: "Tim Ream", goals: 0, assists: 0, yellowCards: 1, redCards: 0),
            PlayerStat(playerName: "Weston McKennie", goals: 0, assists: 0, yellowCards: 1, redCards: 0),
            PlayerStat(playerName: "Kellyn Acosta", goals: 0, assists: 0, yellowCards: 1, redCards: 0),
            PlayerStat(playerName: "Matt Turner", goals: 0, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Antonee Robinson", goals: 0, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Yunus Musah", goals: 0, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Walker Zimmerman", goals: 0, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Cameron Carter-Vickers", goals: 0, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Jesus Ferreira", goals: 0, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Brenden Aaronson", goals: 0, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Giovanni Reyna", goals: 0, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "DeAndre Yedlin", goals: 0, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Shaquell Moore", goals: 0, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Jordan Morris", goals: 0, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Ethan Horvath", goals: 0, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Sean Johnson", goals: 0, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Luca de la Torre", goals: 0, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Aaron Long", goals: 0, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Cristian Roldan", goals: 0, assists: 0, yellowCards: 0, redCards: 0),
            PlayerStat(playerName: "Joe Scally", goals: 0, assists: 0, yellowCards: 0, redCards: 0)
        ]
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerStats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerStatsCell", for: indexPath) as! PlayerStatsCell
        let stat = playerStats[indexPath.row]
        cell.configure(with: stat, selectedStatIndex: selectedStatIndex)
        return cell
    }
    
    @IBAction func onSegmentChanged(_ sender: Any) {
        selectedStatIndex = segCtrl.selectedSegmentIndex
        switch segCtrl.selectedSegmentIndex {
        case 0:
            playerStats.sort { $0.goals > $1.goals }
        case 1:
            playerStats.sort { $0.assists > $1.assists }
        case 2:
            playerStats.sort { $0.yellowCards > $1.yellowCards }
        case 3:
            playerStats.sort { $0.redCards > $1.redCards }
        default:
            break
        }
        
        tableView.reloadData()
        
    }
    
}
