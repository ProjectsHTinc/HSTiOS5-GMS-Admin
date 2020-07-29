//
//  Document.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 14/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import WebKit

class Document: UIViewController {
    
    /* Call ConDoc*/
    let ConPresenter = ConsDocumentPresenter(consDocumentService: ConsDocumentService())
    var ConData = [ConsDocumentData]()
    
    /* Call GriDoc*/
    let GriPresenter = GriDocumentPresenter(griDocumentService: GriDocumentService())
    var griData = [GriDocumentData]()
    
    var searchBar = UISearchController()
    let documentInteractionController = UIDocumentInteractionController()

    var selectedconstitunecyId = String()

    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*SetUp Segment Control*/
        self.setUpSegmentControl()
        /*Right Navigation Bar*/
        self.addrightButton(bg_ImageName:"ConstituentSearch")
        self.tableView.backgroundColor = UIColor.white
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        
        self.callAPIConsDoc ()
        /*Set delegate for Document preview*/
        documentInteractionController.delegate = self
        self.addCustomizedBackBtn(title:"  Constituent documents")

    }
    
    @objc public override func rightButtonClick()
    {
        searchBar = UISearchController(searchResultsController: nil)
        // Set any properties (in this case, don't hide the nav bar and don't show the emoji keyboard option)
        searchBar.hidesNavigationBarDuringPresentation = false
        searchBar.searchBar.keyboardType = UIKeyboardType.asciiCapable

        // Make this class the delegate and present the search
        self.searchBar.searchBar.delegate = self
        present(searchBar, animated: true, completion: nil)
    }
    
    func setUpSegmentControl ()
    {
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.lightGray,
                          NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13.0)];
        let attributesSelected = [ NSAttributedString.Key.foregroundColor : UIColor.white,
                                   NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13.0)];
        segmentControl.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: UIControl.State.normal)
        segmentControl.setTitleTextAttributes(attributesSelected as [NSAttributedString.Key : Any], for: UIControl.State.selected)
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        
        if (segmentControl.selectedSegmentIndex == 0)
        {
            self.callAPIConsDoc ()
        }
        else
        {
            self.callAPIGriDoc ()
        }
        
    }
    
    func callAPIConsDoc ()
    {
        ConPresenter.attachView(view: self)
        ConPresenter.getConsDoc(constituent_id: selectedconstitunecyId)
    }
    
    func callAPIGriDoc ()
    {
        GriPresenter.attachView(view: self)
        GriPresenter.getGriDoc(constituent_id: selectedconstitunecyId)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Document: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate , ConsDocumentView, GriDocumentView
{
    func startLoadingCons() {
        //
    }
    
    func finishLoadingCons() {
        //
    }
    
    func setConsDoc(consDocument: [ConsDocumentData]) {
        ConData = consDocument
        self.tableView.isHidden = false
        self.tableView.reloadData()

    }
    
    func setEmptyCons(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
        self.tableView.isHidden = true
    }
    
    func startLoadingGri() {
        //
    }
    
    func finishLoadingGri() {
        //
    }
    
    func setGriDoc(GriDocument: [GriDocumentData]) {
        griData = GriDocument
        self.tableView.isHidden = false
        self.tableView.reloadData()

    }
    
    func setEmptyGri(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
        self.tableView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (segmentControl.selectedSegmentIndex == 0)
        {
            return ConData.count
        }
        else
        {
            return griData.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DocumentCell
        
        if (segmentControl.selectedSegmentIndex == 0)
        {
            let data = ConData[indexPath.row]
            cell.titleLabel.text = data.doc_name
            cell.date.text = data.created_at
            
        }
        else{
            let data = griData[indexPath.row]
            cell.titleLabel.text = data.doc_name
            cell.date.text = data.created_at
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (segmentControl.selectedSegmentIndex == 0)
        {
            let data = ConData[indexPath.row]
            let url =  Globals.documentUrl + data.doc_file_name
            self.storeAndShare(withURLString: url )

        }
        else
        {
            let data = griData[indexPath.row]
            let url =  Globals.documentUrl + data.doc_file_name
            self.storeAndShare(withURLString: url )
        }
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
             
//        self.performSegue(withIdentifier: "to_search", sender: searchBar.text)
        
    }
    
    
}

extension Document {

    func share(url: URL) {
        documentInteractionController.url = url
        documentInteractionController.uti = url.typeIdentifier ?? "public.data, public.content"
        documentInteractionController.name = url.localizedName ?? url.lastPathComponent
        documentInteractionController.presentPreview(animated: true)
    }

    /// This function will store your document to some temporary URL and then provide sharing, copying, printing, saving options to the user
    func storeAndShare(withURLString: String)
    {
        guard let url = URL(string: withURLString) else { return }
        /// START YOUR ACTIVITY INDICATOR HERE
        self.view.activityStartAnimating()
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let tmpURL = FileManager.default.temporaryDirectory
                .appendingPathComponent(response?.suggestedFilename ?? "fileName.png")
            do {
                try data.write(to: tmpURL)
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                /// STOP YOUR ACTIVITY INDICATOR HERE
                self.view.activityStopAnimating()
                self.share(url: tmpURL)
            }
            }.resume()
    }
}
    
extension Document: UIDocumentInteractionControllerDelegate
{
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
            guard let navVC = self.navigationController else {
                return self
            }
            return navVC
        }
}

extension URL
{
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
}
