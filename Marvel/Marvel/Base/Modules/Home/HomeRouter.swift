//
//  HomeRouter.swift
//  Marvel
//
//  Created by Vinicius on 03/07/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter {
    
    var view: HomeRouterProtocol?
    
    init(view: HomeRouterProtocol?) {
        self.view = view
    }
    
    func showDetail(detailData: DetailCharacterDTO) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            view?.splitDetailView?.showDetailViewController(dto: detailData)
        } else {
            
            guard let detailView = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailView else {
                return
            }
            
            detailView.characterDTO = detailData
            view?.navigationController?.pushViewController(detailView, animated: true)
        }
    }
}
