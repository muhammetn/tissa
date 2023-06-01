//
//  ImageViewerVC.swift
//  shareTrend
//
//  Created by Muhammet Nurchayev on 17.06.2022.
//

import UIKit

class ImageViewerVC: UIViewController {
    var interactor:Interactor? = nil
    var images = [Image]()
    var smallImages: [UIImage]?
    var currentIndex = Int()
    let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.estimatedItemSize = .zero
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.register(ImageViewerImageCell.self, forCellWithReuseIdentifier: "ImageViewerImageCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        let panGestureRec = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        view.addGestureRecognizer(panGestureRec)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = false
        collectionView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {[self] in
            collectionView.contentOffset.x = scWidth * CGFloat(currentIndex)
            collectionView.isHidden = false
//            collectionView.scrollToItem(at: IndexPath(item: 2, section: 0), at: .centeredHorizontally, animated: true)
//            collectionView.selectItem(at: IndexPath(item: currentIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        }
//        let _ = centerItemsInCollectionView(cellWidth: scWidth, numberOfItems: Double(images.count), spaceBetweenCell: 0, collectionView: collectionView)
    }
    
    @objc func handleGesture(_ sender: UIPanGestureRecognizer) {
        let percentThreshold:CGFloat = 0.3

        // convert y-position to downward pull progress (percentage)
        let translation = sender.translation(in: view)
        let verticalMovement = translation.y / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)
        
        guard let interactor = interactor else { return }
        
        switch sender.state {
        case .began:
            interactor.hasStarted = true
            dismiss(animated: true, completion: nil)
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish
                ? interactor.finish()
                : interactor.cancel()
        default:
            break
        }
    }
    
}


extension ImageViewerVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewerImageCell", for: indexPath) as! ImageViewerImageCell
//        cell.imageView.image = smallImages?[indexPath.row]
        cell.backgroundColor = .clear
        cell.imageView.sdImageLoadWithoutVisible(imgUrl: images[indexPath.row].large, placeholder: true, placImg: smallImages?[indexPath.row])
        cell.isUserInteractionEnabled = true
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
//    }

//    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
//
//    }
}


//    MARK: --Hepsi Burada-ky yaly etjek boldym doly edilmedik
class ImageViewerImageCell: UICollectionViewCell, UIScrollViewDelegate{
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let closeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "Close_circle"), for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        btn.isHidden = true
        return btn
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews(){
        addSubview(scrollView)
        addSubview(closeBtn)
        closeBtn.backgroundColor = .gray
        scrollView.addSubview(imageView)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 4
        let rec = UITapGestureRecognizer(target: self, action: #selector(clickScroll))
        scrollView.addGestureRecognizer(rec)
    }
    
    @objc func clickScroll(){
//        closeBtn.isHidden = !closeBtn.isHidden
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            closeBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            closeBtn.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: topAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo:scrollView.contentLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        let recog = UITapGestureRecognizer(target: self, action: #selector(clickImage(_:)))
        recog.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(recog)
    }
    
    @objc func clickImage(_ sender: UITapGestureRecognizer){
        if scrollView.zoomScale > 1 {
            scrollView.setZoomScale(1, animated: true)
         } else {
             let center = sender.location(in: imageView)
             let zoomRect = zoomRectForScale(3, center: center)
             scrollView.zoom(to: zoomRect, animated: true)
         }
    }
    
    private func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = scrollView.frame.size.height / scale
        zoomRect.size.width = scrollView.frame.size.width / scale
        // choose an origin so as to get the right center.
//        zoomRect.origin.x = center.x — (zoomRect.size.width / 2.0)
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
//    MARK: scrollViewDidZoom=> ImageView - da image doly yapmasa bosh scroll bolmaz yaly etya. Islemedi yone  ?!
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = imageView.image{
                let ratioW = imageView.frame.width / image.size.width
                let ratioH = imageView.frame.height / image.size.height
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth * scrollView.zoomScale > imageView.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - imageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conditionTop = newHeight * scrollView.zoomScale > imageView.frame.height
                let top = 0.5 * (conditionTop ? newHeight - imageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        }else{
            scrollView.contentInset = .zero
        }
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
