//
//  PlayListViewController.swift
//  onetapmusic
//
//  Created by 五島　僚太郎 on 2015/11/29.
//  Copyright © 2015年 rg. All rights reserved.
//

import UIKit

class PlayListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var music = Music()
    var songQuery: Music = Music()
    var albums = [AlbumInfo]()
    var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    /* Cellが選択された際に呼び出されるデリゲートメソッド. */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var songViewController = SongViewController()
        songViewController.songIndex = indexPath.row
        self.navigationController?.pushViewController(songViewController, animated: true)
        dump(albums[indexPath.row].albumTitle)
    }
    /* Cellの総数を返すデータソースメソッド. (実装必須)
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    /* Cellに値を設定するデータソースメソッド. (実装必須)
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell { // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! UITableViewCell // Cellに値を設定する
        var title: AnyObject = albums[indexPath.row].albumTitle
        cell.textLabel!.text = "\(title)"
        print(title)
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
