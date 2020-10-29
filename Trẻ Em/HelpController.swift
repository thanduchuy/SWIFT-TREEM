//
//  HelpController.swift
//  Trẻ Em
//
//  Created by Huy Than Duc on 10/5/20.
//

import UIKit

struct DataHelp {
    var image:String
    var content: String
    var select: String
}

class HelpController: UIViewController {

    @IBOutlet weak var helpCollection: UICollectionView!
    @IBOutlet weak var titleSelect: UILabel!
    let cellId = "cell"
    @IBOutlet weak var valueSelect: UILabel!
    let data :[DataHelp] = [DataHelp(image: "newspaper.fill", content: "Liên lạc",select: "thanduchuyz299@gmail.com"),DataHelp(image: "location.circle", content: "Địa chỉ",select: "K23/5 Nguyễn Phước Chu, Liên Chiểu, Đà Nẵng"),DataHelp(image: "phone.bubble.left.fill", content: "Số điện thoại",select:"0387771904")]
    override func viewDidLoad() {
        super.viewDidLoad()
        helpCollection.dataSource = self
        helpCollection.delegate = self
        helpCollection.register(HelpCell.self, forCellWithReuseIdentifier: cellId)
        helpCollection.collectionViewLayout.invalidateLayout()
        let indexPath = IndexPath(row: 0, section: 0)
        self.helpCollection.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        titleSelect.text = data[0].content
        valueSelect.text = data[0].select
        // Do any additional setup after loading the view.
    }
}
extension HelpController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/3, height: 140)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = helpCollection.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HelpCell
        cell.imageView.image = UIImage(systemName: data[indexPath.row].image)
        cell.label.text = data[indexPath.row].content
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        titleSelect.text = data[indexPath.row].content
        valueSelect.text = data[indexPath.row].select
    }
}
class HelpCell : UICollectionViewCell {
    let label : UILabel = {
        let label = UILabel()
        label.textColor =  UIColor.lightGray
        return label
    }()
    let imageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = UIColor.lightGray
        image.image = image.image?.withRenderingMode(.alwaysTemplate)
        return image
    }()
    override var isHighlighted: Bool {
        didSet {
            label.textColor = isHighlighted ? UIColor(named: "selected") : UIColor.lightGray
            imageView.tintColor = isHighlighted ? UIColor(named: "selected") : UIColor.lightGray
        }
    }
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? UIColor(named: "selected") : UIColor.lightGray
            imageView.tintColor = isSelected ? UIColor(named: "selected") : UIColor.lightGray
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let horizontalLabel = NSLayoutConstraint(item: label, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        contentView.addConstraint(horizontalConstraint)
        contentView.addConstraint(horizontalLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
