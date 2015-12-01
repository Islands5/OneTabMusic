//
//  SongViewController.swift
//  onetapmusic
//
//  Created by 五島　僚太郎 on 2015/11/30.
//  Copyright © 2015年 rg. All rights reserved.
//

import UIKit

class SongViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var songIndex: Int
    var music = Music()
    var songQuery: Music = Music()
    var albums = [AlbumInfo]()
    var myTableView: UITableView!
    var appDelegate = AppDelegate()
    
    init() {
        songIndex = 0
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        albums = songQuery.get()
        
        // Status Barの高さを取得する.
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        // TableViewの生成する(status barの高さ分ずらして表示).
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight)) // Cell名の登録をおこなう.
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell") // DataSourceの設定をする.
        myTableView.dataSource = self // Delegateを設定する.
        myTableView.delegate = self
        self.view.addSubview(myTableView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Cellが選択された際に呼び出されるデリゲートメソッド. */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.tabBarController?.selectedIndex = 0
        let songId = albums[songIndex].songs[indexPath.row].songId
        appDelegate.tappedSongId = songId
    }
    /* Cellの総数を返すデータソースメソッド. (実装必須)
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums[songIndex].songs.count
    }
    /* Cellに値を設定するデータソースメソッド. (実装必須)
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell { // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! UITableViewCell // Cellに値を設定する
        var title: AnyObject = albums[songIndex].songs[indexPath.row].songTitle
        cell.textLabel!.text = "\(title)"
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
