//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 重崎竜一 on 2017/11/08.
//  Copyright © 2017年 rychshgzk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nextImage: UIButton!

    @IBOutlet weak var startstop: UIButton!
   
    @IBOutlet weak var beforeImage: UIButton!
    
    var timer: Timer!
    var dispImageNo = 0
    let images = ["image01", "image02", "image03", "image04", "image05"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // バンドルした画像を読み込み
        let image: UIImage! = UIImage(named: images[0])
        
        // 画像を表示
        imageView.image = image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のDetailを取得する
        let detailViewController:DetailViewController = segue.destination as! DetailViewController
        // 遷移先の dispImageNo に 画像がタップされた時の数値を渡す
        detailViewController.imageName = images[dispImageNo]
    }

    /// 表示している画像の番号を元に画像を表示する
    func displayImage() {
        // 画像の番号が正常な範囲を指しているかチェック
        
        // 範囲より下を指している場合、最後の画像を表示
        if dispImageNo < 0 {
            dispImageNo = images.count - 1
        }
        
        // 範囲より上を指している場合、最初の画像を表示
        if dispImageNo > images.count - 1 {
            dispImageNo = 0
        }
        
        // 表示している画像の番号から名前を取り出し
        let name = images[dispImageNo]
        
        // 画像を読み込み
        let image = UIImage(named: name)
        
        // Image Viewに読み込んだ画像をセット
        imageView.image = image
    }
    
    func nextPage(timer: Timer) {
        // 関数が動いているか否か確認
        print("動いてるよ")
        
        // 画像番号を +1 する
        dispImageNo += 1
        
        // 画像を表示する
        displayImage()
    }
    

    
    // action
    @IBAction func onTapImage(_ sender: Any) {
        performSegue(withIdentifier: "Detail", sender: nil)
        if self.timer != nil {
            self.timer.invalidate() // タイマーを破棄する
            self.timer = nil        // startstop() が timer == nil の判断をできるよう、 timer == nil としておく
            self.beforeImage.isEnabled = true
            self.nextImage.isEnabled = true
            self.startstop.setTitle("再生", for: .normal)
        }
    }
    
    @IBAction func beforeImage(_ sender: Any) {
        // 戻るボタン
        // 画像番号を -1 する
        dispImageNo -= 1
        
        // 画像を表示する
        displayImage()
        
    }
    
    @IBAction func startstop(_ sender: Any) {
        // タイマーが存在している場合はスライドを停止、タイマーが存在してない場合はスライド動かす
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(
                nextPage), userInfo: nil, repeats: true)
            self.beforeImage.isEnabled = false
            self.nextImage.isEnabled = false
            self.startstop.setTitle("停止", for: .normal)
        } else {
            // タイマーを停止する
            self.beforeImage.isEnabled = true
            self.nextImage.isEnabled = true
            self.timer.invalidate() // タイマーを破棄する
            self.timer = nil        // startstop() が timer == nil の判断をできるよう、 timer == nil としておく
            self.startstop.setTitle("再生", for: .normal)
        }
        
    }
    
    @IBAction func nextImage(_ sender: Any) {
        // 進むボタン
        // 画像番号を +1 する
        dispImageNo += 1
        
        // 画像を表示する
        displayImage()
    }
    
    @IBAction func modoru(_ segue: UIStoryboardSegue) {
    }
    
}

