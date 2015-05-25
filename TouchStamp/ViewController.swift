//
//  ViewController.swift
//  TouchStamp
//
//  Created by nagata on 5/23/15.
//  Copyright (c) 2015 nagata. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imageNameArray: [String] = ["hana", "hoshi", "onpu", "shitumon"]
    var imageIndex: Int = 0
    @IBOutlet var haikeiImageView: UIImageView!
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        haikeiImageView.image = UIImage(named: "background")
    }
    
    @IBAction func selectedFirst() {
        imageIndex = 1
    }
    
    @IBAction func selectedSecond() {
        imageIndex = 2
    }
    
    @IBAction func selectedThird() {
        imageIndex = 3
    }
    
    @IBAction func selectedFourth() {
        imageIndex = 4
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch: UITouch = touches.first as! UITouch
        let location: CGPoint = touch.locationInView(self.view)
        if imageIndex != 0 {
            var image: UIImage = UIImage(named: imageNameArray[imageIndex - 1])!
            imageView = UIImageView(frame: CGRectMake(0, 0, 40, 40))
            imageView.image = image
            imageView.center = CGPointMake(location.x, location.y)
            self.view.addSubview(imageView)
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch: UITouch = touches.first as! UITouch
        let location: CGPoint = touch.locationInView(self.view)
        imageView.center = CGPointMake(location.x, location.y)
    }

    @IBAction func back() {
        self.imageView.removeFromSuperview()
    }

    @IBAction func selectBackground() {
        //UIImagePickerControllerのインスタンスをつくる
        var imagePickerController: UIImagePickerController = UIImagePickerController()
        
        //フォトライブラリを使う設定をする
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        //フォトライブラリを呼び出す
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }

    //フォトライブラリから画像の選択が終わったら呼ばれるメソッド
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        //imageに選んだ画像を設定する
        var image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        //そのimageを背景に設定する
        haikeiImageView.image = image
        
        //フォトライブラリを閉じる
        picker.dismissViewControllerAnimated(true, completion: nil)
        
    }

    @IBAction func save() {
        //画面のスクリーンショットを取得
        let rect: CGRect = CGRectMake(0, 30, 320, 380)
        UIGraphicsBeginImageContext(rect.size)
        self.view.layer.renderInContext(UIGraphicsGetCurrentContext())
        let capture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //フォトライブラリに保存
        UIImageWriteToSavedPhotosAlbum(capture, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutablePointer<Void>) {
        let alert = UIAlertView(title: "確認", message: "画像を保存しました", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "OK")
        alert.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

