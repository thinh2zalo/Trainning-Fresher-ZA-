//
//  ThiThuViewController.swift
//  QuanSuTest
//
//  Created by vincent on 3/13/20.
//  Copyright © 2020 vincent. All rights reserved.
//

import UIKit
import Spring

class ThiThuViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = QuestionCell.init();
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    


 
    
    @IBOutlet weak var QuestionTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        QuestionTable.register(UITableViewCell.self, forCellReuseIdentifier: "cellQues");
        view.addSubview(QuestionTable);
        QuestionTable.dataSource = self;
        QuestionTable.delegate = self;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
