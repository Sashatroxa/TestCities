//
//  DetailPresenter.swift
//  CitiesTest
//
//  Created by Aleksandr on 06.10.2022.
//

protocol DetailPresenterProtocol: AnyObject {
    
}

final class DetailPresenter {
    private weak var view: DetailViewProtocol?
    
    init(view: DetailViewProtocol) {
        self.view = view
    }
}

//MARK: - DetailPresenterProtocol
extension DetailPresenter: DetailPresenterProtocol {
    
}
