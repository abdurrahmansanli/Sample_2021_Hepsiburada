//
//  BaseViewController.swift
//  hepsiexpress
//
//  Created by Abdurrahman Şanlı on 21.05.2021.
//

import UIKit

class BaseViewController<ViewModel>: UIViewController where ViewModel: BaseViewModel {
    
    lazy var viewModel: ViewModel = ViewModel()
    
    var data: ViewModelData?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(data: ViewModelData) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModelData()
        bind()
        layout()
    }
    
    func setViewModelData() {}
    
    func bind() {}
    
    func layout() {}
}
