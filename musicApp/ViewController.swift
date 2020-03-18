//
//  ViewController.swift
//  musicApp
//
//  Created by Lun H on 2020/3/17.
//  Copyright © 2020 Lun H. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let player = AVPlayer()
    var musicItem:AVPlayerItem?
    var isPlaying = false
    let url = Bundle.main.url(forResource: "頑固", withExtension: ".mp3")
    let url2 = Bundle.main.url(forResource: "以後別做朋友", withExtension: ".mp3")
    
    
    @IBOutlet weak var musicLength: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var playImage: UIButton!
    @IBOutlet weak var musicSlider: UISlider!
    @IBOutlet weak var time: UILabel!
    
    @IBAction func nextSong(_ sender: UIButton) {  //下一首歌
        musicItem = AVPlayerItem(url: url2!)
        player.replaceCurrentItem(with: musicItem)
        player.play()
        playImage.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        image.image = UIImage(named: "4")
        observeCurrentTime()
        updateUI()
    }
    
    
    @IBAction func previousAction(_ sender: UIButton) { //上一首歌
        musicItem = AVPlayerItem(url: url!)
        player.replaceCurrentItem(with: musicItem)
        player.play()
        playImage.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        image.image = UIImage(named: "1")
        observeCurrentTime()
        updateUI()
    }
    
    @IBAction func setTime(_ sender: UISlider, forEvent event: UIEvent) { //拖移播放時間
        let seconds = Int64(musicSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        player.seek(to: targetTime)
    }
    
    
    
    @IBAction func play(_ sender: UIButton)   //播放
        {
        if isPlaying == false{
            musicItem =  AVPlayerItem(url: url!)
            player.replaceCurrentItem(with: musicItem)
            player.play()
            playImage.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }else{
            player.pause()
            playImage.setImage(UIImage(systemName: "play.fill"), for: .normal)
            isPlaying = false
        }
        observeCurrentTime()
        updateUI()
        isPlaying = true
    }
   
    //取得現在時間
    func observeCurrentTime(){
    player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main) { (CMTime) in
            if self.player.currentItem?.status == .readyToPlay{
                let currentTime = CMTimeGetSeconds(self.player.currentTime())
                self.musicSlider.value = Float(currentTime)
                self.time.text = self.formatConversion(time: currentTime)
            }
        }
    }
    
    
    func updateUI(){
        guard let duration = musicItem?.asset.duration else { //更新Slider
            return
        }
        let seconds = CMTimeGetSeconds(duration)
        musicSlider.minimumValue = 0
        musicSlider.maximumValue = Float(seconds)
        musicLength.text = formatConversion(time: seconds)
        musicSlider.isContinuous = true
    }
    
    
    func formatConversion(time:Float64) -> String { //轉換時間
        let songLength = Int(time)
        let minutes = Int(songLength / 60)
        let seconds = Int(songLength % 60)
        var time = ""
        if minutes < 10{
            time = "0\(minutes):"
        }else{
            time = "\(minutes)"
        }
        
        if seconds < 10{
            time += "0\(seconds)"
        }else{
            time += "\(seconds)"
        }
        return time
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let url = Bundle.main.url(forResource: "頑固", withExtension: ".mp3")
//        musicItem = AVPlayerItem(url: url!)
//        updateUI()
//        observeCurrentTime()
    }
    
    
    
    
    


}

