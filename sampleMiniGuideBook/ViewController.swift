//
//  ViewController.swift
//  sampleMiniGuideBook
//
//  Created by yuka on 09/11/2017.
//  Copyright © 2017 yuka. All rights reserved.
//

import UIKit

var areaList:[String] = []

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sendKeyInCharge:String = ""
    var sendNumberInCharge:Int = -1
    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myTableView.delegate = self
        myTableView.dataSource = self
       
        //ファイルパスを取得（エリア名が格納されているプロパティリスト）
        let filePath = Bundle.main.path(forResource: "areaList", ofType: "plist")
        
        //ファイルの内容を読み込んでディクショナリー型に格納
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        //TableView で扱いやすい配列の形(エリア名の入っている配列)を作成
        for (key,data) in dic! {

            print(key)
            print(data)
            areaList.append(key as! String)
        }
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cellko", for: indexPath)
        
        cell.textLabel?.text = areaList[indexPath.row]
        
        return cell
        
    }
    
    //タップされた時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendKeyInCharge = areaList[indexPath.row]
        
        sendNumberInCharge = indexPath.row
        print("タップされた時:\(sendNumberInCharge)")
        
        performSegue(withIdentifier: "segueTopTo1", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var dvc:DetailViewController = segue.destination as! DetailViewController
        
        dvc.selectedKey = sendKeyInCharge
        dvc.selectedAreaNum = sendNumberInCharge
        
        print("prepare")
        print("sendKeyInCharge: \(sendKeyInCharge)")
        print("sendNumberInCharge: \(sendNumberInCharge)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

