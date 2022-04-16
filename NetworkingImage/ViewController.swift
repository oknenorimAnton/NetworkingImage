//
//  ViewController.swift
//  NetworkingImage
//
//  Created by Антон on 16.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var getImageButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //изначально activityIndicator невидим и анимация не работает
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        
    }
    
    @IBAction func getImagePressed(_ sender: Any) {
        
        self.label.isHidden = true
        self.getImageButton.isEnabled = false
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        guard let url = URL(string: "https://images.unsplash.com/photo-1649856018930-cb8bed61f48f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80") else
        { return }
        
        let session = URLSession.shared
        
            //данный метод создает задачу на получение содержимого по указанному юрл-адресу
        session.dataTask(with: url) { (data, response, error) in
            
            //проверка ошибки
            if let error = error {
                print("Error", error.localizedDescription)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                // данное замыкание происходит в фоновом потоке. Для того чтобы обновить интерфейс, отобразив загруженное изображение, нужно передать задачу на обновление интерфейса в основной поток, создав для этого ассинхронную очередь
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.imageView.image = image
                }
            }
        } .resume()
    }
}

