//
//  ViewController.swift
//  SDT00CREATEAPI
//
//  Created by Alejandro Flores Cruz on 2019-01-07.
//  Copyright © 2019 Alejandro Flores. All rights reserved.
//

import UIKit
import AVFoundation

//Player tryout sunday night
var player:AVPlayer?
var playerItem:AVPlayerItem?
var playButton:UIButton?

class FirstCustomTableViewCell: UITableViewCell {
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var audioURLLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol {
    //Properties
    var feedItems: NSArray = NSArray()
    var selectedEpisode : EpisodeModel = EpisodeModel()
    @IBOutlet weak var listTableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        ///set delegates and initialize homeModel
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
    }
    func itemsDownloaded(items: NSArray){
        feedItems = items
        self.listTableView.reloadData()
    }
    
    //Player tryout sunday night
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Retrieve cell
        let cellIdentifier: String = "BasicCell"
        let myCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FirstCustomTableViewCell
       
        // Get the episode to be shown
        let item: EpisodeModel = feedItems[indexPath.row] as! EpisodeModel
        
        var audioVar:String = (item.audioURL!)

        // Get references to labels of cell
        myCell.mainTitleLabel.text = item.mainTitle
        myCell.pubDateLabel.text = item.pubDate
        myCell.descrLabel.text = item.descr
        myCell.audioURLLabel.text = item.audioURL
        
        //error: skipping output stream
        
        //Sunday (now monday) Code
        var url = URL(string: audioVar)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer=AVPlayerLayer(player: player!)
        playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
        self.view.layer.addSublayer(playerLayer)
        
        return myCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Set selected episode to var
        selectedEpisode = feedItems[indexPath.row] as! EpisodeModel
        
        // Manually call segue to detail view controller
        self.performSegue(withIdentifier: "detailSegue", sender: self)
        
        //Plays song
        player!.play()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get reference to the destination view controller
        let detailVC  = segue.destination as! DetailViewController
        // Set the property to the selected location so when the view for
        // detail view controller loads, it can access that property to get the feeditem obj
        detailVC.selectedEpisode = selectedEpisode
    }

}

