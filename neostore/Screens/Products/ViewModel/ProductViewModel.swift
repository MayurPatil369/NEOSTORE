import Foundation

 class ProductViewModel {
    var products: [ProdData] = []
    var eventHandler: ((_ event: Event) -> Void)?
    
    func fetchProducts(dataTab: ProdRequest, id: Int) {
        APIManager.shared.manager(modelType: Product.self, type: APIEndpoints.getProduct(id), requestModel: dataTab, method: .get) { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let products):
                self.products = products.data
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                print(error)
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension ProductViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}



