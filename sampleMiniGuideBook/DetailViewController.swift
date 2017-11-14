//
//  DetailViewController.swift
//  sampleMiniGuideBook
//
//  Created by yuka on 10/11/2017.
//  Copyright © 2017 yuka. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    var selectedKey:String = "未選択" /*選択された行のkeyを受け取る*/
    var selectedAreaNum:Int = -2

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet weak var myMapView2: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("DetailVC viewDidload")
        print("selectedAreaNum:\(selectedAreaNum)")
        print("areaList[selectedAreaNum]:\(areaList[selectedAreaNum])")
        print("areaList[selectedAreaNum].description:\(areaList[selectedAreaNum].description)")

        let filePath = Bundle.main.path(forResource: "areaList", ofType: "plist")
        let dics = NSDictionary(contentsOfFile: filePath!)
        let variables = dics?.object(forKey: selectedKey) as! NSDictionary

        let detailInfo = dics![selectedKey] as! NSDictionary  /* NSDictionaryからキー指定で取り出すと必ずAnyになるので、Dictionary型だと教えてやらないといけないので、ダウンキャスト必須 */
/* NS:NextStep Appleの　NSがつかないのを使いたいが、NSってつけないと使えない NS Objective-Cの名残 */
        self.title = selectedKey
//こっちとおなじ動き        navigationItem.title = "AAAA"
        
        myTextView.text = variables["description"] as! String
//        self.textView.contentOffset = CGPointMake(0, -self.textView.contentInset.top);
        myTextView.contentOffset = CGPoint(x:0, y:-myTextView.contentInset.top)
        myImageView.image = UIImage(named: detailInfo["image"] as! String)

        makeMap(lat: atof(detailInfo["latitude"] as! String), long: atof(variables["longitude"] as! String), pName: selectedKey )

        
        
        
    }
    
    func makeMap(lat:Double, long:Double, pName:String) {
        let cPin = MKPointAnnotation()
        
        cPin.coordinate = CLLocationCoordinate2DMake(lat, long)
        cPin.title = pName
        
        let span = MKCoordinateSpanMake(0.05,0.05)
        let region = MKCoordinateRegionMake(cPin.coordinate, span)
     //   myMapView.setRegion(region, animated: true)
     //   myMapView.addAnnotation(cPin)

        myMapView2.setRegion(region, animated: true)
        myMapView2.addAnnotation(cPin)
        print("makeMap :")
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
