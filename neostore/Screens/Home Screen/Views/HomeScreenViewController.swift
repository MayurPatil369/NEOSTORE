//
//  HomeScreenViewController.swift
//  neostore
//
//  Created by Neosoft on 30/10/24.
//




import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sliderImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConst.HomeCollectionViewCell, for: indexPath) as! HomeCollectionViewCell
        
        cell.homeScreenImageView.image = UIImage(named: sliderImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.myPageControl.currentPage = indexPath.row
    }
    
    var autoScrollTimer: Timer?

    @IBOutlet var parentView: UIView!
    @IBOutlet weak var rightsideView: UIView!
    @IBOutlet weak var tableProdView: UIView!
    @IBOutlet weak var sofaProdView: UIView!
    @IBOutlet weak var chairProdView: UIView!
    @IBOutlet weak var cupboardView: UIView!
    @IBOutlet weak var sideUIView: UIView!
    
    
   
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var myPageControl: UIPageControl!
    
    @IBOutlet weak var leadingConstraintSideView: NSLayoutConstraint!
    
    let sb = UIStoryboard(name: SbConstants.Main, bundle: nil)
    
    var sliderImages = ["slider_img1", "slider_img2","slider_img3","slider_img4"]

    var slideViewController: SlideViewController?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationUI()
        let nib = UINib(nibName: CellConst.HomeCollectionViewCell, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: CellConst.HomeCollectionViewCell)
        
        collectionView.delegate = self
        collectionView.dataSource = self
     
        myPageControl.numberOfPages = sliderImages.count
        myPageControl.currentPage = 0
        
        myPageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        self.rightsideView.isHidden = true
    
        startAutoScroll()
    }
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        let page = sender.currentPage
        let indexPath = IndexPath(item: page, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func startAutoScroll() {
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
    }

    func stopAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = nil
    }
    
    @objc func scrollToNextPage() {
        let nextPage = (myPageControl.currentPage + 1) % sliderImages.count
        let indexPath = IndexPath(item: nextPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        myPageControl.currentPage = nextPage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAutoScroll()
    }

    
    func navigationUI() {
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: Constants.menu_icon), style: .plain, target: self, action: #selector(showMenu))
        
        self.navigationController?.navigationBar.tintColor = .white
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 23)
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButton
        
        let searchButton = UIBarButtonItem(
            image: UIImage(systemName: Constants.magnifyingglass),
            style: .plain,
            target: self,
            action: #selector(searchAction)
        )
        searchButton.tintColor = .white
        
        self.navigationItem.rightBarButtonItem = searchButton
    }

    @objc func searchAction() {
        print("Search button tapped")
    }

    @objc func hideSideMenu(){
        
    }
    
        
    @objc func showMenu(){
        self.navigationItem.leftBarButtonItem?.isHidden = true
        UIView.animate(withDuration: 0.5){
            self.sideUIView.layer.zPosition = 1
            self.leadingConstraintSideView.constant = 0
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func homeScreenTapped(_ sender: Any) {

        UIView.animate(withDuration: 0.5){
            self.leadingConstraintSideView.constant = -280
            self.view.layoutIfNeeded()
        }
        self.navigationItem.leftBarButtonItem?.isHidden = false

    }
    
    
}
extension HomeViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                
        if let touch = touches.first {
            
            if tableProdView == touch.view {
                navigateToScreen(storyboardName: SbConstants.HomeScreen, viewControllerID: SbConstants.ProductViewController, prodCatId: 1)
            } else if chairProdView == touch.view {
                navigateToScreen(storyboardName: SbConstants.HomeScreen, viewControllerID: SbConstants.ProductViewController, prodCatId: 2)
            } else if sofaProdView == touch.view {
                navigateToScreen(storyboardName: SbConstants.HomeScreen, viewControllerID: SbConstants.ProductViewController, prodCatId: 3)
            } else if cupboardView == touch.view {
                navigateToScreen(storyboardName: SbConstants.HomeScreen, viewControllerID: SbConstants.ProductViewController, prodCatId: 4)
            } else if parentView == touch.view {
                self.hideSideMenu()
            } else if rightsideView == touch.view {
                self.hideSideMenu()
            }
        }
    }
}

    

