//
//  ConcentrationThemeViewController.swift
//  ConcentrationProject
//
//  Created by Preet Patel on 12/18/18.
//  Copyright © 2018 Preet Patel. All rights reserved.
//

import UIKit

class ConcentrationThemeViewController: UIViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱🏓🏸🏒🏏",
        "Animals": "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷",
        "Faces": "😀😄😁😆😅😂🤣☺️😊😇🙂🙃😉😌",
    ]

    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    // This function prevents the iPhone version to load into the game first without choosing a theme
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
        ) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let button = sender as? UIButton {
                if let themeName = button.currentTitle {
                    if let theme = themes[themeName] {
                        if let cvc = segue.destination as? ConcentrationViewController {
                            cvc.theme = theme
                        }
                    }
                }
            }
        }
    }


}
