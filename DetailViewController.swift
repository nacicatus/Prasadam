//
//  DetailViewController.swift
//  Prasadam
//
//  Created by Saurabh Sikka on 06/12/15.
//  Copyright © 2015 Saurabh Sikka. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    

    var detailItem: Product! {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let _ = self.detailItem {
            
            let theProduct: Product = self.detailItem
            
            if let _ = self.detailDescriptionLabel {
                self.detailDescriptionLabel.text = "\(theProduct.ID)"
            }
            if let _ = self.nameLabel {
                self.nameLabel.text = theProduct.name
            }
            if let _ = self.manufacturerLabel {
                self.manufacturerLabel.text = theProduct.manufacturer
            }
            if let _ = self.detailsLabel {
                self.detailsLabel.text = theProduct.details
            }
            if let _ = self.priceLabel {
                self.priceLabel.text = "\(theProduct.price)"
            }
            if let _ = self.quantityLabel {
                self.quantityLabel.text = "\(theProduct.quantity)"
            }
            if let _ = self.countryLabel {
                self.countryLabel.text = theProduct.countryOfOrigin
            }
            
                
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

