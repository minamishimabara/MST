//
//  MapViewController.swift
//  SAKELog
//
//  Created by 金子 太祐 on 2016/11/12.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import UIKit
import MapKit

enum YOSHIDAYA_POSITION : CLLocationDegrees {
    case LATITUDE =  32.669404
    case LONGITUDE = 130.306605
    static let coordinateFor2D : CLLocationCoordinate2D = CLLocationCoordinate2DMake(LATITUDE.rawValue, LONGITUDE.rawValue)
    
}
enum URAKAWA_POSITION : CLLocationDegrees {
    case LATITUDE = 32.670715
    case LONGITUDE = 130.300802
    static let coordinateFor2D : CLLocationCoordinate2D = CLLocationCoordinate2DMake(LATITUDE.rawValue, LONGITUDE.rawValue)
}


class MapViewController: UIViewController, MKMapViewDelegate {

    var mapView: MKMapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //マップの設定
        //マップにフレームサイズを設定
        self.mapView.frame = self.view.frame
        //マップのDelegateを設定（上記のMKMapDelegate）
        self.mapView.delegate = self
        self.view.addSubview(self.mapView)
        
        self.mapView.showsUserLocation = true
        
        //初期位置を設定
        //経度、緯度からメルカトル図法の点に変換する
        let coordinate_YOSHIDA = YOSHIDAYA_POSITION.coordinateFor2D
        
        let span = MKCoordinateSpanMake(0.003, 0.003)
        
        //任意の場所を表示する場合、MKCoordinateRegionを使って表示する -> (中心位置、表示領域)
        let centerPosition = MKCoordinateRegion(center: coordinate_YOSHIDA, span: span)
        self.mapView.setRegion(centerPosition, animated:true)
        
        //ピンを生成
        let theRoppongiAnnotation = MKPointAnnotation()
        //ピンを置く場所を設定
        theRoppongiAnnotation.coordinate = coordinate_YOSHIDA
        //ピンのタイトルの設定
        theRoppongiAnnotation.title = "吉田屋酒造"
        //ピンを地図上に追加
        self.mapView.addAnnotation(theRoppongiAnnotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
}
