//
//  CategoryFilterViewController.swift
//  MovieProject
//
//  Created by Raul Humberto Mantilla Assia on 9/24/18.
//  Copyright © 2018 rmantilla. All rights reserved.
//

import UIKit

protocol ListCategoriesDisplayLogic: class
{
    func displayFetchedCategories(viewModel: ListCategories.FetchCategories.ViewModel)
}

class CategoryFilterViewController: UIViewController {

    var interactor: ListCategoriesBusinessLogic?
    var router: (NSObjectProtocol & ListCategoriesRoutingLogic & ListCategoriesDataPassing)?
    var displayedCategories: [ListCategories.FetchCategories.ViewModel.DisplayedCategory] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ListCategoriesInteractor()
        let presenter = ListCategoriesPresenter()
        let router = ListCategoriesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        fetchCategories()
    }
    
    // MARK: - Fetch Categories
    
    func fetchCategories()
    {
        let request = ListCategories.FetchCategories.Request()
        interactor?.fetchCategories(request: request)
    }
    @IBAction func didTapClose(_ sender: UIButton)
    {
        router?.routeBack()
    }
    
}

// MARK: - ListCategoriesDisplayLogic protocol implementation

extension CategoryFilterViewController: ListCategoriesDisplayLogic
{
    func displayFetchedCategories(viewModel: ListCategories.FetchCategories.ViewModel)
    {
        displayedCategories = viewModel.displayedCategories
        tableView?.reloadData()
    }
}

// MARK: - UItableView Delegates implementation

extension CategoryFilterViewController: UITableViewDelegate, UITableViewDataSource
{
    struct Constant
    {
        static let categoryCellReuseIdentifier = "CategoryFilterTableViewCell"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return displayedCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let displayedCategory = displayedCategories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.categoryCellReuseIdentifier) as? CategoryFilterTableViewCell
        cell?.setup(withViewModel: displayedCategory)
        return cell!
    }
}


// MARK: - Transition Delegates implementation

extension CategoryFilterViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeUpToBottomTransitionAnimation(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeUpToBottomTransitionAnimation(isPresenting: false)
    }
    
}
