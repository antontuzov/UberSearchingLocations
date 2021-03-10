//
//  SearchViewController.swift
//  UberSearchingLocations
//
//  Created by turbo on 10.03.2021.
//

import UIKit
import CoreLocation



protocol SearchViewControllerDelegat: AnyObject {
    func searchViewController(_ vc: SearchViewController,
                              didSelectLocationWith coordinates: CLLocationCoordinate2D?)
}





class SearchViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
 
    weak var delegatee: SearchViewControllerDelegat?
    
    
    
    private var label: UILabel =  {
        let label = UILabel()
        label.text = "Where you fuking going!"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private let  field: UITextField = {
        let field = UITextField()
        field.placeholder = "tap some"
        field.layer.cornerRadius = 9
        field.backgroundColor = .systemGray
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        field.leftViewMode = .always
        return field
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Celled")
        
        
        return tableView
    }()
    
    var locations = [Location]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(field)
        view.addSubview(tableView)
        field.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .secondarySystemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.sizeToFit()
        label.frame = CGRect(x: 20, y: 20, width: label.frame.size.width, height: label.frame.size.height)
        field.frame = CGRect(x: 10, y: 20+label.frame.size.height, width: view.frame.size.width-20, height: 50)
        let tableY: CGFloat = field.frame.origin.y+field.frame.size.height+6
        tableView.frame = CGRect(x: 0, y: tableY, width: view.frame.size.width, height: view.frame.size.height-tableY)
    }
  

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        field.resignFirstResponder()
        if let text = field.text, !text.isEmpty {
            LocationManager.shared.findLocations(with: text) { [weak self] locations in
                DispatchQueue.main.async {
                    self?.locations = locations
                    self?.tableView.reloadData()
                }
                
                
                
                
            }
            
        }
        
        return true
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Celled", for: indexPath)
        cell.textLabel?.text = locations[indexPath.row].titel
        cell.textLabel?.numberOfLines = 0
        cell.contentView.backgroundColor = .secondarySystemBackground
        cell.backgroundColor = .secondarySystemBackground
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let coordinate = locations[indexPath.row].coordinates
        
        
        delegatee?.searchViewController(self, didSelectLocationWith: coordinate)
    }
    
    
    
    
}
