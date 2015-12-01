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

class ViewController: UIViewController, AVAudioPlayerDelegate {

    var music = Music()
    var albums: [AlbumInfo] = []
    var songQuery: Music = Music()
    var audio: AVAudioPlayer! = nil
    var audioPlayer: AVAudioPlayer!
    var appDelegate = AppDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if((appDelegate.tappedSongId) != nil) {
            let item: MPMediaItem = songQuery.getItem(appDelegate.tappedSongId!)
            if let url: NSURL = item.valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOfURL: url)
                    audioPlayer.delegate = self
                    audioPlayer.play()
                } catch {
                    
                }
            }
            
        } else {
            
            albums = songQuery.get()
            
            dump(albums)
            let songId: NSNumber = albums[1].songs[1].songId
            let item: MPMediaItem = songQuery.getItem(songId)
            print(item.valueForProperty(MPMediaItemPropertyAssetURL))
            if let url: NSURL = item.valueForProperty(MPMediaItemPropertyAssetURL) as? NSURL {
                do {
                audioPlayer = try AVAudioPlayer(contentsOfURL: url)
                audioPlayer.delegate = self
                audioPlayer.play()
                } catch {
                    
                }
            }
        }
        
        
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
        if((appDelegate.tappedSongId) != nil) {
            print(appDelegate.tappedSongId)
        }else {
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

