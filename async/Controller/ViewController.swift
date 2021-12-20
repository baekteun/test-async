//
//  ViewController.swift
//  async
//
//  Created by 최형우 on 2021/12/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var datasource: [Todo] = []{
        didSet { tableView.reloadData() }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    @IBAction func SessionButtonDidTap(_ sender: UIButton) {
        Task {
            let data = try await NetworkManager.shared.sessionTest()
            self.datasource = data.shuffled()
        }
    }
    
    @IBAction func AlamofireButtonDidTap(_ sender: UIButton) {
        Task {
            let data = try await NetworkManager.shared.alamofireTest()
            datasource = data.shuffled()
        }
    }
    @IBAction func MoyaButtonDidTap(_ sender: UIButton) {
        Task {
            let data = try await NetworkManager.shared.moyaTest()
            datasource = data.shuffled()
        }
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = datasource[indexPath.row].title
        return cell
    }
    
    
}
