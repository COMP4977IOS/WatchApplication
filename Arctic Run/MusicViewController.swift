//
//  ViewController.swift
//  WatchConnectApp
//
//  Created by Johnny Marin on 2016-02-16.
//  Copyright © 2016 Johnny Marin. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class MusicViewController: UIViewController {
    let mediaItems = MPMediaQuery.songsQuery().items
    var audioSession: AVAudioSession = AVAudioSession.sharedInstance()
    var nowPlaying = "Nothing"
    let audioPlayer = MPMusicPlayerController.systemMusicPlayer()
    var nowPlayingItemDidChangeObserver : AnyObject?
    @IBOutlet weak var nowPlayingLabel: UILabel!
    
    
    @IBAction func previous(sender: AnyObject) {
        prevSong()
    }
    @IBAction func next(sender: AnyObject) {
        nextSong()
    }
    @IBAction func playAudio(sender: AnyObject) {
        
        startPlay()
        
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        stopPlay()
        
    }
    
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self.nowPlayingItemDidChangeObserver!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        
        
        
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        } catch {
            print("AudioSession error")
        }
        
        do {
            
            audioPlayer.prepareToPlay()
        }
        self.audioPlayer.beginGeneratingPlaybackNotifications()
        self.nowPlayingItemDidChangeObserver =
            NSNotificationCenter.defaultCenter().addObserverForName(MPMusicPlayerControllerNowPlayingItemDidChangeNotification, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { (notification) -> Void in
                self.updateNowPlayingItem()
            })
        
        updateNowPlayingItem()
    }
    
    func updateNowPlayingItem(){
        if let nowPlayingItem = self.audioPlayer.nowPlayingItem {
            
            let nowPlayingTitle = nowPlayingItem.title
            
            self.nowPlayingLabel.text = nowPlayingTitle
            nowPlaying = self.nowPlayingLabel.text!
        } else {
            self.nowPlayingLabel.text = "Nothing"
            nowPlaying = self.nowPlayingLabel.text!
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stopPlay() {
        audioPlayer.pause()
    }
    
    func startPlay() {
        audioPlayer.play()
    }
    
    func nextSong() {
        self.audioPlayer.skipToNextItem()
        updateNowPlayingItem()
        
    }
    
    func prevSong() {
        self.audioPlayer.skipToPreviousItem()
        updateNowPlayingItem()
        
    }
    
    
    
    
    
}

