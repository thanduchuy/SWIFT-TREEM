//
//  HomeController.swift
//  Trẻ Em
//
//  Created by Huy Than Duc on 10/5/20.
//

import Foundation
import UIKit

class HomeController : UIViewController {
    @IBOutlet weak var nvView: UICollectionView!
    let cellId = "cellId"
    let nvTitle = ["Trang chủ","Tư vấn","Thông tin"]
    var horiContrains : NSLayoutConstraint?
    var selected = 0
    // view
    @IBOutlet weak var valueView: UIView!
    @IBOutlet weak var helpView: UIView!
    @IBOutlet weak var infoView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        nvView.delegate = self
        nvView.dataSource = self
        nvView.register(NVCell.self, forCellWithReuseIdentifier: cellId)
        nvView.collectionViewLayout.invalidateLayout()
        let indexPath = IndexPath(row: 0, section: 0)
        self.nvView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        helpView.isHidden = true
        infoView.isHidden = true
        setUpHorizontalView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    func setUpHorizontalView() {
        let horiView = UIView()
        horiView.backgroundColor = UIColor(named: "selected")
        horiView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(horiView)
        horiContrains = horiView.leftAnchor.constraint(equalTo: self.nvView.leftAnchor)
        horiContrains?.isActive = true
        horiView.bottomAnchor.constraint(equalTo: self.nvView.bottomAnchor).isActive = true
        horiView.widthAnchor.constraint(equalTo: self.nvView.widthAnchor,multiplier: 1/3).isActive = true
        horiView.heightAnchor.constraint(equalToConstant:8).isActive = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func updateHorizontalView() {
        let x = CGFloat(selected) * nvView.frame.width / 3
        horiContrains?.constant = x
    }
}
extension HomeController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = nvView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NVCell
        cell.label.text = nvTitle[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        updateHorizontalView()
        let orientation = UIApplication.shared.statusBarOrientation
        if(orientation == .landscapeLeft || orientation == .landscapeRight)
        {
            return CGSize(width: nvView.frame.width/4, height: nvView.frame.height)
        }
        else{
            return CGSize(width: nvView.frame.width/3, height: nvView.frame.height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selected = indexPath.item
        valueView.isHidden = true
        helpView.isHidden = true
        infoView.isHidden = true
        switch selected {
        case 0:
            valueView.isHidden = false
        case 1:
            helpView.isHidden = false
        case 2:
            infoView.isHidden = false
        default:
            valueView.isHidden = false
        }
        updateHorizontalView()
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
class NVCell : UICollectionViewCell {
    let label : UILabel = {
        let label = UILabel()
        label.textColor =  UIColor(named: "dismiss")
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    override var isHighlighted: Bool {
        didSet {
            label.textColor = isHighlighted ? UIColor(named: "selected") : UIColor(named: "dismiss")
        }
    }
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? UIColor(named: "selected") : UIColor(named: "dismiss")
        }
    }
    func setUp() {
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
