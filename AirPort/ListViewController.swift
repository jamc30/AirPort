//
//  ListViewController.swift
//  AirPort
//
//  Created by Juan Antonio Martin on 09/06/21.
//

import Foundation
import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListaTableViewCell", for: indexPath) as! ListaTableViewCell
        cell.nameLabel.text = data.items[indexPath.row].name
        cell.municipalLabel.text = data.items[indexPath.row].municipalityName
        
        return cell
    }
    
    
    var data : DataItem!
    var km : Int!
    
    @IBOutlet weak var airPortTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tbcv = self.tabBarController as! TabBarViewController
        data = tbcv.data

        airPortTableView.delegate = self
        airPortTableView.dataSource = self
        
        self.airPortTableView.register(UINib.init(nibName: "ListaTableViewCell", bundle: nil), forCellReuseIdentifier: "ListaTableViewCell")
        self.airPortTableView.reloadData()
        
        
    }
}
