//
//  ProductViewController.swift
//  neostore
//
//  Created by Neosoft on 11/11/24.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var prodCatId: Int = 0
    lazy var prodViewModel = ProductViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationUI()
        
        tableView.dataSource = self
        tableView.delegate = self

        let nib = UINib(nibName: CellConst.ProductsTableViewCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CellConst.ProductsTableViewCell)
        let req = ProdRequest(product_category_id: prodCatId)
        if prodCatId == 1 {
            self.navigationItem.title = NavigationTitleConst.Table
            initViewModel(req: req, id: 1)
            observeEvent()
        } else if prodCatId == 2 {
            self.navigationItem.title = NavigationTitleConst.Chair
            initViewModel(req: req, id: 2)
            observeEvent()
        } else if prodCatId == 3 {
            self.navigationItem.title = NavigationTitleConst.Sofa
            initViewModel(req: req, id: 3)
            observeEvent()
        } else if prodCatId == 4 {
            self.navigationItem.title = NavigationTitleConst.Cupboard
            initViewModel(req: req, id: 4)
            observeEvent()
        }
    }

    func navigationUI() {
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

    
    func initViewModel(req: ProdRequest, id: Int) {
        prodViewModel.fetchProducts(dataTab: req, id: id)
    }

    func observeEvent() {
        prodViewModel.eventHandler = { [weak self] event in
            guard let self = self else { return }

            switch event {
            case .loading:
                print(EventConstants.Loading)
            case .stopLoading:
                print(EventConstants.StoppedLoading)
            case .dataLoaded:
                print(EventConstants.DataLoaded)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error ?? "Error Occured")
            }
        }
    }
}

extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.prodViewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellConst.ProductsTableViewCell) as! ProductsTableViewCell
        let tb = self.prodViewModel.products[indexPath.row]
        cell.productTitle.text = tb.name
        cell.productProducer.text = tb.producer
        cell.productCost.text = "Rs. \(tb.cost)"
        cell.starRating.rating = CGFloat(tb.rating)
        
        if let url = URL(string: tb.product_images){
            cell.productImg.loadImage(from: url)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: SbConstants.HomeScreen, bundle: nil)
        guard let productdetailsVC = storyboard.instantiateViewController(withIdentifier: SbConstants.ProductDetailsViewController) as? ProductDetailsViewController else { return }
        
        productdetailsVC.prodID = self.prodViewModel.products[indexPath.row].id
        productdetailsVC.stars = self.prodViewModel.products[indexPath.row].rating
        self.navigationController?.pushViewController(productdetailsVC, animated: true)
    }



    
}
