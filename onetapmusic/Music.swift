//
//  Music.swift
//  onetapmusic
//
//  Created by 五島　僚太郎 on 2015/11/15.
//  Copyright © 2015年 rg. All rights reserved.
//

import Foundation
import MediaPlayer

// 曲情報
struct SongInfo {
    
    var albumTitle: String
    var artistName: String
    var songTitle:  String
    
    var songId   :  NSNumber
}

// アルバム情報
struct AlbumInfo {
    
    var albumTitle: String
    var songs: [SongInfo]
}


class Music {

    init(){
        
    }
    
    // iPhoneに入ってる曲を全部返す
    func get() -> [AlbumInfo] {
        
        var albums: [AlbumInfo] = []
        
        // アルバム情報から曲を取り出す
        let albumsQuery: MPMediaQuery = MPMediaQuery.albumsQuery()
        let albumItems: [MPMediaItemCollection] = albumsQuery.collections! as [MPMediaItemCollection]
        var album: MPMediaItemCollection
        
        for album in albumItems {
            
            var albumItems: [MPMediaItem] = album.items as [MPMediaItem]
            var song: MPMediaItem
            
            var songs: [SongInfo] = []
            
            var albumTitle: String = ""
            
            for song in albumItems {
                
                albumTitle = song.valueForProperty( MPMediaItemPropertyAlbumTitle ) as! String
                
                let songInfo: SongInfo = SongInfo(
                    albumTitle: song.valueForProperty( MPMediaItemPropertyAlbumTitle ) as! String,
                    artistName: song.valueForProperty( MPMediaItemPropertyArtist ) as! String,
                    songTitle:  song.valueForProperty( MPMediaItemPropertyTitle ) as! String,
                    songId:     song.valueForProperty( MPMediaItemPropertyPersistentID ) as! NSNumber
                )
                
                songs.append( songInfo )
            }
            
            let albumInfo: AlbumInfo = AlbumInfo(
                albumTitle: albumTitle,
                songs: songs
            )
            
            albums.append( albumInfo )
        }
        
        return albums
        
    }
    
    // songIdからMediaItemを取り出す
    func getItem( songId: NSNumber ) -> MPMediaItem {
        
        let property: MPMediaPropertyPredicate = MPMediaPropertyPredicate( value: songId, forProperty: MPMediaItemPropertyPersistentID )
        
        let query: MPMediaQuery = MPMediaQuery()
        query.addFilterPredicate( property )
        
        var items: [MPMediaItem] = query.items! as [MPMediaItem]
        
        return items[items.count - 1]
        
    }
    
}
