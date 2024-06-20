//
//  TeamViewController.swift
//  Final
//
//  Created by Giovanni Rivera on 11/28/23.
//

import UIKit

struct Player {
    var name: String
    var club: String
    var position: String
    var imageName: String
}

struct CoachesInfo {
    var coachName: String
    var coachingRole: String
    var imageName: String
}

class PlayerCell: UITableViewCell {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerClubLabel: UILabel!
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var playerImageView: UIImageView!
    
    @IBOutlet weak var coachNameLabel: UILabel!
    @IBOutlet weak var coachRoleLabel: UILabel!
    @IBOutlet weak var coachImageView: UIImageView!

    func configure(with player: Player) {
        
        playerNameLabel.isHidden = false
        playerClubLabel.isHidden = false
        playerPositionLabel.isHidden = false
        playerImageView.isHidden = false

        coachNameLabel.isHidden = true
        coachRoleLabel.isHidden = true
        coachImageView.isHidden = true

        playerNameLabel.text = player.name
        playerClubLabel.text = player.club
        playerPositionLabel.text = player.position
        playerImageView.image = UIImage(named: player.imageName)
    }
    
    func configureCoach(with coach: CoachesInfo) {
            playerNameLabel.isHidden = true
            playerClubLabel.isHidden = true
            playerPositionLabel.isHidden = true
            playerImageView.isHidden = true

            coachNameLabel.isHidden = false
            coachRoleLabel.isHidden = false
            coachImageView.isHidden = false

            coachNameLabel.text = coach.coachName
            coachRoleLabel.text = coach.coachingRole
            coachImageView.image = UIImage(named: coach.imageName)
    }
}

class TeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var selectedStatIndex: Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segCtrl: UISegmentedControl!
        
    var players: [Player] = []
    
    var coachesStats: [CoachesInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        players = [
            Player(name: "Matt Turner", club: "Arsenal", position: "Goalkeeper", imageName: "mattturner"),
            Player(name: "Christian Pulisic", club: "AC Milan", position: "Forward", imageName: "christianpulisic"),
            Player(name: "Tyler Adams", club: "Leeds United", position: "Midfielder", imageName: "tyleradams"),
            Player(name: "Tim Ream", club: "Fulham", position: "Defender", imageName: "timream"),
            Player(name: "Antonee Robinson", club: "Fulham", position: "Defender", imageName: "antoneerobinson"),
            Player(name: "Yunus Musah", club: "Valencia", position: "Midfielder", imageName: "yunusmusah"),
            Player(name: "Timothy Weah", club: "Lille", position: "Forward", imageName: "timothyweah"),
            Player(name: "Sergino Dest", club: "Mila", position: "Defender", imageName: "serginodest"),
            Player(name: "Weston McKennie", club: "Juventus", position: "Midfielder", imageName: "westonmcKennie"),
            Player(name: "Walker Zimmerman", club: "Nashvile", position: "Defender", imageName: "walkerzimmerman"),
            Player(name: "Josh Sargent", club: "Norwich City", position: "Forward", imageName: "joshsargent"),
            Player(name: "Haji Wright", club: "Antalyaspor", position: "Forward", imageName: "hajiwright"),
            Player(name: "Cameron Carter-Vickers", club: "Celtic", position: "Defender", imageName: "cameroncartervickers"),
            Player(name: "Jesus Ferreira", club: "FC Dallas", position: "Forward", imageName: "jesusferreira"),
            Player(name: "Brenden Aaronson", club: "Leeds United", position: "Midfielder", imageName: "brendenaaronson"),
            Player(name: "Giovanni Reyna", club: "Dortmund", position: "Forward", imageName: "giovannireyna"),
            Player(name: "Kellyn Acosta", club: "Los Angeles FC", position: "Midfielder", imageName: "kellynacosta"),
            Player(name: "DeAndre Yedlin", club: "Inter Miami", position: "Defender", imageName: "deandreyedlin"),
            Player(name: "Shaquell Moore", club: "Nashville", position: "Defender", imageName: "shaqellmoore"),
            Player(name: "Jordan Morris", club: "Seattle FC", position: "Forward", imageName: "jordanmorris"),
            Player(name: "Ethan Horvath", club: "Luton Town", position: "Goalkeeper", imageName: "ethanhorvat"),
            Player(name: "Sean Johnson", club: "NYC FC", position: "Goalkeeper", imageName: "seanjohnson"),
            Player(name: "Luca de la Torre", club: "Celta Vigo", position: "Midfielder", imageName: "lucadelatorre"),
            Player(name: "Aaron Long", club: "NY Red Bulls", position: "Defender", imageName: "aaronlong"),
            Player(name: "Cristian Roldan", club: "Seattle FC", position: "Forward", imageName: "cristianroldan"),
            Player(name: "Joe Scally", club: "M'Gladbach", position: "Defender", imageName: "joescally")
        ]
        
        coachesStats = [
            CoachesInfo(coachName: "Gregg Berhalter", coachingRole: "Manager", imageName: "greggberhalter"),
            CoachesInfo(coachName: "B.J. Callaghan", coachingRole: "Assistant Manager", imageName: "bjcallaghan"),
            CoachesInfo(coachName: "Mikey Varas", coachingRole: "Assistant Manager", imageName: "mikeyvaras"),
            CoachesInfo(coachName: "Fabian Otte", coachingRole: "Goakeepers Coach", imageName: "fabianotte"),
            CoachesInfo(coachName: "Gianni Vio", coachingRole: "Technical Coach", imageName: "giannivio"),
            CoachesInfo(coachName: "Darcy Norman", coachingRole: "Athletic Coach", imageName: "darcynorman"),
        ]
                
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return players.count
        if selectedStatIndex == 0 {
            return players.count
        } else {
            return coachesStats.count
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell

            if selectedStatIndex == 0 {
                let player = players[indexPath.row]
                cell.configure(with: player)
            } else {
                let coach = coachesStats[indexPath.row]
                cell.configureCoach(with: coach)
            }

            return cell
    }
    
    @IBAction func onSegmentChanged2(_ sender: Any) {
        selectedStatIndex = segCtrl.selectedSegmentIndex
        switch segCtrl.selectedSegmentIndex {
        case 0:
            players.sort { $0.name < $1.name }
        case 1:
            coachesStats.sort { $0.coachName < $1.coachName }
        default:
            break
        }
        
        tableView.reloadData()
    }
    
}
