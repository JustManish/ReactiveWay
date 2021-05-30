//
//  viewController+ImagePicker.swift
//  jaldilive
//
//  Created by Admin on 10/12/20.
//  Copyright © 2020 Admin. All rights reserved.
//
/*
import CropViewController

private let imageView = UIImageView()
var croppingStyle = CropViewCroppingStyle.default
var imgdelegate: ImagePickerDelegate?

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?,imageExtension:String)
    func didCancelPicker()
}
extension UIViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           guard let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }
           
           let cropController = CropViewController(croppingStyle: croppingStyle, image: image)
           //cropController.modalPresentationStyle = .fullScreen
           cropController.delegate = self
           
           //If profile picture, push onto the same navigation stack
           if croppingStyle == .circular {
               if picker.sourceType == .camera {
                   picker.dismiss(animated: true, completion: {
                       self.present(cropController, animated: true, completion: nil)
                   })
               } else {
                   picker.pushViewController(cropController, animated: true)
               }
           }
           else { //otherwise dismiss, and then present from the main controller
               picker.dismiss(animated: true, completion: {
                   self.present(cropController, animated: true, completion: nil)
                   //self.navigationController!.pushViewController(cropController, animated: true)
               })
           }
       }
     
    public func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
       
        updateImageViewWithImage(image, fromCropViewController: cropViewController)
    }
    
    public func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
      
        updateImageViewWithImage(image, fromCropViewController: cropViewController)
    }
    
    public func updateImageViewWithImage(_ image: UIImage, fromCropViewController cropViewController: CropViewController) {
        imageView.image = image
       // layoutImageView()

        self.navigationItem.leftBarButtonItem?.isEnabled = true
         
        imgdelegate?.didSelect(image: image, imageExtension: "jpeg")
        
        cropViewController.dismiss(animated: true, completion: nil)
      

//        if cropViewController.croppingStyle != .circular {
//            imageView.isHidden = true
//
//            cropViewController.dismissAnimatedFrom(self, withCroppedImage: image,
//                                                   toView: imageView,
//                                                   toFrame: CGRect.zero,
//                                                   setup: { self.layoutImageView() },
//                                                   completion: {
//                                                    self.imageView.isHidden = false })
//        }
//        else {
//            self.imageView.isHidden = false
//            cropViewController.dismiss(animated: true, completion: nil)
//        }
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
           guard UIImagePickerController.isSourceTypeAvailable(type) else {
               return nil
           }

           return UIAlertAction(title: title, style: .default) { [unowned self] _ in
               let pickerController = UIImagePickerController()
               pickerController.sourceType = type
               pickerController.modalPresentationStyle = .overCurrentContext
              // pickerController.allowsEditing = false
               pickerController.delegate = self
              self.present(pickerController, animated: true)
           }
       }

    
     func presentImageGalleryCamera() {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = self.action(for: .camera, title: "Take photo") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Photo library") {
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
            imgdelegate?.didCancelPicker();
        }))

//        if UIDevice.current.userInterfaceIdiom == .pad {
//            alertController.popoverPresentationController?.sourceView = sourceView
//            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
//            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
//        }

        self.present(alertController, animated: true)
    }
    
       func addButtonTapped(sender: AnyObject) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let defaultAction = UIAlertAction(title: "Crop Image", style: .default) { (action) in
           // self.croppingStyle = .de
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        let profileAction = UIAlertAction(title: "Make Profile Picture", style: .default) { (action) in
           // self.croppingStyle =
            
            let imagePicker = UIImagePickerController()
            imagePicker.modalPresentationStyle = .popover
           // imagePicker.popoverPresentationController?.barButtonItem = (sender as! UIBarButtonItem)
            imagePicker.preferredContentSize = CGSize(width: 320, height: 568)
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        alertController.addAction(defaultAction)
        alertController.addAction(profileAction)
        alertController.modalPresentationStyle = .popover
        
        let presentationController = alertController.popoverPresentationController
        presentationController?.barButtonItem = (sender as! UIBarButtonItem)
        present(alertController, animated: true, completion: nil)
    }
    
}


extension UIViewController
{
    
    func addBgGradient(colors: [CGColor]){
      
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = colors
        gradient.locations = [0.0, 1.0]
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    
func getCellHeight() -> CGFloat {
    
    let screenSize = UIScreen.main.bounds
//   print("screenSize.size.width \(screenSize.size.width)")
//   print("screenSize.size.height \(screenSize.size.height) ")
   
    if screenSize.size.width == 375.0 && screenSize.size.height == 667.0
    {
        return  self.view.frame.size.height * 0.25
    }
    if screenSize.size.width == 375.0 && screenSize.size.height == 812.0 // Iphone Xs
    {
       return  self.view.frame.size.height * 0.215
    }
   if screenSize.size.width == 390.0 && screenSize.size.height == 844.0
   {
       return  self.view.frame.size.height * 0.215
   }
   if screenSize.size.width == 414.0 && screenSize.size.height == 736.0
   {
       return  self.view.frame.size.height * 0.245
   }
   if screenSize.size.width == 414 && screenSize.size.height == 896
   {
       return  self.view.frame.size.height * 0.21
   }
   if screenSize.size.width == 428.0 && screenSize.size.height == 926.0
   {
       return  self.view.frame.size.height * 0.2105
   }
     return  self.view.frame.size.height * 0.20
}
    
}
*/
