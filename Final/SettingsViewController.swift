//
//  SettingsViewController.swift
//  Final
//
//  Created by Giovanni Rivera on 12/3/23.
//

import UIKit
import UserNotifications

enum SettingsSection: Int, CaseIterable {
    case preferences
    case account

    var title: String {
        switch self {
            case .preferences: return "Preferences"
            case .account: return "Account"
        }
    }
}

enum PreferencesOption: Int, CaseIterable {
    case darkMode
    case notifications

    var title: String {
        switch self {
            case .darkMode: return "Dark Mode"
            case .notifications: return "Notifications"
        }
    }
}

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return SettingsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        guard let section = SettingsSection(rawValue: section) else { return 0 }
            switch section {
            case .preferences:
                return PreferencesOption.allCases.count
            case .account:
                return 1
            }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = SettingsSection(rawValue: indexPath.section) else {
                fatalError("Section not found")
            }
                
            switch section {
            case .preferences:
                guard let option = PreferencesOption(rawValue: indexPath.row) else {
                    fatalError("Option not found")
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath)
                if let switchView = cell.accessoryView as? UISwitch {
                    switchView.tag = indexPath.row
                } else {
                    let switchView = UISwitch(frame: .zero)
                    switchView.tag = indexPath.row
                    switchView.addTarget(self, action: #selector(didToggleSwitch(_:)), for: .valueChanged)
                    cell.accessoryView = switchView
                }

                let switchView = cell.accessoryView as! UISwitch
                
                switch option {
                case .darkMode:
                    cell.textLabel?.text = option.title
                    switchView.isOn = UserDefaults.standard.bool(forKey: "DarkModeEnabled")
                case .notifications:
                    cell.textLabel?.text = option.title
                    UNUserNotificationCenter.current().getNotificationSettings { settings in
                        DispatchQueue.main.async {
                            switchView.isOn = settings.authorizationStatus == .authorized
                        }
                    }
                }
                return cell
            case .account:
                let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
                cell.textLabel?.text = "Sign Out"
                return cell
            }
        
    }
    
    @objc func didToggleSwitch(_ sender: UISwitch) {
        
        guard let option = PreferencesOption(rawValue: sender.tag) else {
            return
        }
            
        switch option {
        case .darkMode:
            UserDefaults.standard.set(sender.isOn, forKey: "DarkModeEnabled")
            
            UserDefaults.standard.synchronize()
                    
                if #available(iOS 13.0, *) {
                    self.view.window?.overrideUserInterfaceStyle = sender.isOn ? .dark : .light
                } else {
                    self.view.backgroundColor = sender.isOn ? .black : .white
                    self.tableView.reloadData()
                }
            
        case .notifications:
            if sender.isOn {
                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    DispatchQueue.main.async {
                        if granted {
                            UIApplication.shared.registerForRemoteNotifications()
                        } else {
                            sender.isOn = false
                        }
                        UserDefaults.standard.set(sender.isOn, forKey: "NotificationsEnabled")
                    }
                }
            } else {
                UserDefaults.standard.set(false, forKey: "NotificationsEnabled")
            }
        }
    }
    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
        scheduleSignOutNotification()

            if let onboardingViewController = storyboard?.instantiateViewController(withIdentifier: "OnboardingViewControllerID") as? OnboardingViewController {
                guard let window = UIApplication.shared.windows.first else { return }
                window.rootViewController = onboardingViewController
                window.makeKeyAndVisible()

                UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
            }
    }

    func scheduleSignOutNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Your Team Needs You"
        content.body = "You have successfully signed out."
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLogin" {
            let destinationVC = segue.destination as! OnboardingViewController
        }
    }
}
