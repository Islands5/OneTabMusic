//
//  ViewController.swift
//  onetapmusic
//
//  Created by 五島　僚太郎 on 2015/11/15.
//  Copyright © 2015年 rg. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class ViewController: UIViewController {

    var music = Music()
    var albums: [AlbumInfo] = []
    var songQuery: Music = Music()
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item: MPMediaItem = appDelegate.playMusicOfSongId()
        if let url: NSURL = item.valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL {
            do {
                appDelegate.audioPlayer = try AVAudioPlayer(contentsOfURL: url)
                appDelegate.audioPlayer.play()
            } catch {

            }
        }
        
        let myImageView = UIImageView(frame: CGRectMake(0,0,100,120))
        let myImage = UIImage(named: "onpu350.png")
        
        // 画像をUIImageViewに設定する.
        myImageView.image = myImage
        
        // 画像の表示する座標を指定する.
        myImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        
        // UIImageViewをViewに追加する.
        self.view.addSubview(myImageView)
        
        
//        do {
//            var audio = try AVAudioPlayer(data: predicate)
//        } catch {
//            fatalError("Failed to initialize a player.")
//        }
//        fatalError("Url is nil.")
//        audio.play()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

