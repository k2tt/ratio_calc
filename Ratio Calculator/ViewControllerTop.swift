//
//  ViewController.swift
//  Ratio Calculator
//
//  Created by HAIMUSHI on 2017/02/05.
//  Copyright © 2017年 HAIMUSHI. All rights reserved.
//

import UIKit

class ViewControllerTop: UIViewController {
    
    private var toolbar: UIToolbar!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var input_1: UITextField!
    @IBOutlet weak var input_2: UITextField!
    @IBOutlet weak var input_3: UITextField!
    @IBOutlet var view_bg: UIView!
    
//    // iボタンを押した時にキーボードを閉じる
//    @IBAction func tapInfo(_ sender: UIButton) {
//        self.input_1.resignFirstResponder()
//    }
    
    // input に入力があった時 calc() を実行
    @IBAction func editText(_ sender: UITextField) {
        checkText(_input: input_1, _text: sender.text!)
        calc()
    }
    @IBAction func editText2(_ sender: UITextField) {
        checkText(_input: input_2, _text: sender.text!)
        calc()
    }
    @IBAction func editText3(_ sender: UITextField) {
        checkText(_input: input_3, _text: sender.text!)
        calc()
    }
    
    // マッチした数を返す
    func getMatchCount(targetString: String, pattern: String) -> Int {
        do {
            
            let regex = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
            let targetStringRange = NSRange(location: 0, length: (targetString as NSString).length)
            
            return regex.numberOfMatches(in: targetString, options: [], range: targetStringRange)
            
        } catch {
            print("error: getMatchCount")
        }
        return 0
    }
    
    // 入力された値のチェック
    func checkText(_input: UITextField, _text: String) {
        
        // TODO: 最後に0が続くときの丸め処理 -> 行わない
        
        // テキストの値を代入
        let _tempText: String = _text
        
        // 1文字目のインデックスを取得
        let _startIndex = _tempText.startIndex

        // 正規表現パターン
        let _matchPattern: String = "\\."
        
        // 文字列の中に"."が何個含まれているかを返す
        let _matchCount: Int = getMatchCount(targetString: _tempText, pattern: _matchPattern)
        
        // print(type(of: _tempText)) // 型調査
        
        // 先頭が"0"かつ、2文字以上のとき
        if _tempText.hasPrefix("0") && _tempText.characters.count > 1 {
            
            // 2文字目のindexを取得
            let _secondIndex = _tempText.index(after:_startIndex)
            
            // 2文字目が"."でないときは、先頭の0を消す
            if _tempText[_secondIndex] != "." {
                _input.text = _tempText.substring(from: _tempText.index(_startIndex, offsetBy: 1))
            }
        }
        
        // 先頭が"."のとき"0"を足す
        if _tempText.hasPrefix(".") {
            _input.text = "0" + _tempText
        }

        // 文字列に"."が2個以上含まれていれば最後の"."を削除する
        if _matchCount > 1 {
            _input.text = _tempText.substring(to: _tempText.index(before: _tempText.endIndex))
        }
        
    }
    
    // 計算関数
    func calc() {
        
        // いずれかのinputの値が""、または"0"、または"0."、または"."ではなければ
        if (input_1.text! != "") && (input_2.text! != "") && (input_3.text! != "")  && (input_1.text! != ".") && (input_2.text! != ".") && (input_3.text! != ".") && (Double(input_1.text!) != 0.0) && (Double(input_2.text!) != 0.0) && (Double(input_3.text!) != 0.0) {

            // 計算した値を代入
            let _result: Double = Double(input_2.text!)! * Double(input_3.text!)! / Double(input_1.text!)!
            
            // 結果の小数点以下を取る
            let _float: [String] = String(_result).components(separatedBy: ".")
            
            // 結果が 0.001 以下なら
            if(_result < 0.001) {
                result.text = "0"
            }
            // 小数点以下が0なら整数にする
            else if _float[1] == "0" {
                result.text = String((_result.description as NSString).integerValue)
            }
            else {
                // 小数点第3桁以下は切り捨て
                let _decimal: Double = floor(_result * 1000)
                result.text = String(_decimal / 1000)
            }
        }
        else {
            result.text = "0"
        }
    }
    
    // 前の画面から戻る
//    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
//        self.input_1.becomeFirstResponder()
//    }

    
    // オンロード
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景画像スタイル
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "bg.jpg")?.draw(in: self.view.bounds)
        let bg_image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: bg_image)
        
        // Placeholderスタイル
        let _phConfig: NSAttributedString = NSAttributedString(string: "Number", attributes: [NSForegroundColorAttributeName: UIColor(red:1.0,green:1.0,blue:1.0,alpha:0.5)])
        self.input_1.attributedPlaceholder = _phConfig
        self.input_2.attributedPlaceholder = _phConfig
        self.input_3.attributedPlaceholder = _phConfig
        
        //input_1にフォーカス
        self.input_3.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
