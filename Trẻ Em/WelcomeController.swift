//
//  WelcomeController.swift
//  Trẻ Em
//
//  Created by Huy Than Duc on 10/2/20.
//

import UIKit

class WelcomeController: UIViewController {
    
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var colectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    var selected = 0
    let cellId = "cellId"
    let list = [welcome](arrayLiteral: welcome(image: "boy", content: "Đảm bảo an toàn thực phẩm, chỉ sử dụng các thực phẩm đã được nấu chín"),welcome(image: "girl", content: "Giữ ấm cơ thể cho trẻ, tăng cường sức khỏe bằng ăn uống, nghỉ ngơi, sinh hoạt hợp lý."),welcome(image: "playtime", content: "Rửa tay bằng nước sạch và xà phòng sau khi tiếp xúc động vật nuôi như chó, mèo."),welcome(image: "toys", content: " Khi trẻ có các triệu chứng sốt, ho, khó thở... gia đình cần thông báo ngay cho cơ quan y tế khi có các triệu chứng kể trên."))
    override func viewDidLoad() {
        super.viewDidLoad()
        colectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        colectionView.delegate = self
        colectionView.dataSource = self
        colectionView.backgroundColor = .clear
        btnSkip.layer.cornerRadius = btnSkip.frame.height / 2
        setValue(index: selected)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func setValue(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.colectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        imageView.image = UIImage(named: list[index].image)
        label.text = list[index].content
        UIView.animate(withDuration: 1.5) {
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func goSkip(_ sender: Any) {
        if selected < 3 {
            selected += 1
            setValue(index: selected)
        } else {
            guard let vc = storyboard?.instantiateViewController(identifier: "home_view") as? HomeController else {
                return
            }
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
}
extension WelcomeController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setValue(index: indexPath.row)
        selected = indexPath.row
    }
}
