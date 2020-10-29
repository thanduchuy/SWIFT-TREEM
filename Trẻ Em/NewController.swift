//
//  NewController.swift
//  Trẻ Em
//
//  Created by Huy Than Duc on 10/5/20.
//

import UIKit
import AVKit
import AVFoundation
import Foundation
class NewController: UIViewController {
    
    @IBOutlet weak var magazineCollec: UICollectionView!
    @IBOutlet weak var scrollVIew: UIScrollView!
    @IBOutlet weak var videoCollection: UICollectionView!
    var pvController = AVPlayerViewController()
    var playerView = AVPlayer()
    let videoURLs = ["https://www.radiantmediaplayer.com/media/big-buck-bunny-360p.mp4","https://r4---sn-42u-nboll.googlevideo.com/videoplayback?expire=1602320260&ei=JCOBX7jdHci_gAfql5o4&ip=167.88.120.96&id=o-AFsVsx4rKQp52CDtpapkIPjapIUWnP02c7fxqn6jUjNs&itag=18&source=youtube&requiressl=yes&vprv=1&mime=video%2Fmp4&gir=yes&clen=4370815&ratebypass=yes&dur=211.069&lmt=1601158650232223&fvip=4&fexp=23915654&c=WEB&txp=5530422&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRgIhANgh0MwSsBHgHRv_rYwxIHnGWut5q4dX2AlLvd8DPypuAiEAshYQQMS5RhknaMB5pAMnn_8ZqpjHAm5NHa0nL04TGNU%3D&title=WEAN+-+MOT+NGUOI+VI+EM+%28Lyrics+Video%29&cms_redirect=yes&mh=d0&mip=42.113.140.198&mm=31&mn=sn-42u-nboll&ms=au&mt=1602298600&mv=m&mvi=4&pl=24&lsparams=mh,mip,mm,mn,ms,mv,mvi,pl&lsig=AG3C_xAwRAIgadwuVvX3V4xlO97noXzOqVxFM4g6y1wFWq7J0TtyjCwCIAnE_Q63ZgJJry2oe8PeduK-vR5Hob2kEtyO0UbKaHWK","https://r4---sn-42u-2iie.googlevideo.com/videoplayback?expire=1602320139&ei=qyKBX46mA4Wm1gKolrmwDg&ip=212.40.116.187&id=o-AIvPJKAgEeqd1OlUuB1Q_Y-u-LosxTXPiXkP8nfnB7AM&itag=18&source=youtube&requiressl=yes&vprv=1&mime=video%2Fmp4&gir=yes&clen=13863582&ratebypass=yes&dur=199.970&lmt=1577778290778188&fvip=4&fexp=23915654&c=WEB&txp=5531432&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIgJSQliSsNhao8903BKdbTAOl6Z8V_rUNRlQL6jSGwt54CIQDwlclvBrjaacLT8Y8ag0AO05hH3v8atX-33Qdy5rty6w%3D%3D&title=TOULIVER+X+SLIMV+-+EM+%C6%A0I+C%E1%BB%A8+VUI++%5BOFFICIAL+VIDEO%5D&cms_redirect=yes&mh=3W&mip=42.113.140.198&mm=31&mn=sn-42u-2iie&ms=au&mt=1602298482&mv=m&mvi=4&pl=24&lsparams=mh,mip,mm,mn,ms,mv,mvi,pl&lsig=AG3C_xAwRQIhAJtxnbOOZwKoCp0c0MhtpLt8bK2DIYKIcR8PrVwc-2a1AiAw8d2ouese5BKaYkx5iRzAp8mZNn6wA1pSH5z3qi1q7A%3D%3D"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        magazineCollec.delegate = self
        magazineCollec.dataSource = self
        videoCollection.delegate = self
        videoCollection.dataSource = self
        magazineCollec.collectionViewLayout.invalidateLayout()
        videoCollection.collectionViewLayout.invalidateLayout()
    }
    
    func playVideo(text:String) {
        let url : URL = URL(string: text)!
        playerView = AVPlayer(url: url as URL)
        pvController.player = playerView
        self.present(pvController, animated: true) {
            self.pvController.player?.play()
        }
    }
    
}

extension NewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.magazineCollec {
            return 4
        } else {
            return videoURLs.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.magazineCollec {
            let cell = magazineCollec.dequeueReusableCell(withReuseIdentifier: "MCell", for: indexPath) as! CustomCell
            return cell
        } else {
            let cell = videoCollection.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! CellVideoCollection
            cell.getVideoThumbnail(text: videoURLs[indexPath.row])
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.videoCollection {
           playVideo(text: videoURLs[indexPath.row])
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == videoCollection {
            return CGSize(width: 250, height: 150)
        } else {
            return CGSize(width: magazineCollec.frame.width/2, height: 200)
        }
    }
    
}
class CellVideoCollection: UICollectionViewCell {

    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var btnLike: UIView!
    @IBOutlet weak var labelTIme: UILabel!
    @IBOutlet weak var btnPlay: UIView!
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var parentView: UIView!
    var active = true
    var url : URL? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        bg.roundCorners(corners: [.topLeft,.topRight], radius: 10)
        btnLike.layer.cornerRadius = btnLike.frame.height/2
        btnPlay.layer.cornerRadius = 10
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.btnLike.addGestureRecognizer(gesture)
    }
    func getVideoThumbnail(text: String) {
        url = URL(string: text)
        getThumbnail(url: url!) { (image,time) in
            self.bg.image = image
            self.labelTIme.text =  self.convertTime(time: time)
        }
    }
    func convertTime(time:Double) -> String {
        var result = ""
        let minutes = Int((time.truncatingRemainder(dividingBy: 3600)) / 60)
        var second = time.truncatingRemainder(dividingBy: 60)
        second = round(second * 100) / 100
        result = "0\(minutes):\(second)"
        return result
    }
    func getThumbnail(url:URL,completion: @escaping ((_ image: UIImage,_ time: Double)->Void) )  {
        DispatchQueue.global().async {
            let asset = AVAsset(url: url)
            let avAssetImage = AVAssetImageGenerator(asset: asset)
            let durationInSeconds = asset.duration.seconds
            avAssetImage.appliesPreferredTrackTransform = true
            let thumbnailVideo = CMTimeMake(value: 7, timescale: 1)
            do {
                let cgImage = try avAssetImage.copyCGImage(at: thumbnailVideo, actualTime: nil)
                let image = UIImage(cgImage: cgImage)
                DispatchQueue.main.sync {
                    completion(image,durationInSeconds)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    @objc func someAction(_ sender:UITapGestureRecognizer){
        if active {
            imgLike.image = UIImage(systemName: "star.fill")
        } else {
            imgLike.image = UIImage(systemName: "star")
        }
        active.toggle()
    }
}
class CustomCell: UICollectionViewCell {
    @IBOutlet weak var parentView: UIView!
    
    @IBOutlet weak var btnLike: UIView!
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var bg: UIView!
    var active = true
    override func awakeFromNib() {
        super.awakeFromNib()
        parentView.roundCorners(corners: [.topLeft,.topRight], radius: 10)
        bg.roundCorners(corners: [.allCorners], radius: 10)
        btnLike.layer.cornerRadius = btnLike.frame.height/2
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
        self.btnLike.addGestureRecognizer(gesture)
    }
    @objc func someAction(_ sender:UITapGestureRecognizer){
        if active {
            imgLike.image = UIImage(systemName: "star.fill")
        } else {
            imgLike.image = UIImage(systemName: "star")
        }
        active.toggle()
    }
}
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
