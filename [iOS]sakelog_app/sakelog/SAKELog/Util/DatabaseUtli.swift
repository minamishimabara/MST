//
//  DatabaseUtli.swift
//  SAKELog
//
//  Created by taisuke kaneko on 2016/11/26.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import Foundation

class DatabaseUtil : NSObject {
 
    var db : FMDatabase!
    
    static let shard = DatabaseUtil()
    
    /*** query header ***/
    let CREATE_TABLE = "CREATE TABLE"
    let INSERT_INTO = "INSERT INTO"
    let IF_NOT_EXISTS = "IF NOT EXISTS"
    let SELECT_FROM = "SELECT * FROM"
    let UPDATE = "UPDATE"
    let DELETE_FROM = "DELETE FROM"
    
    /*** table ***/
    let T_SAKELOG = "sakeLog"
    
    /*** columns ***/
    let C_ID = "id"
    let C_DATE = "date"
    let C_RATE = "userRate"
    let C_MEMO = "memo"
    let C_P_NAME = "p_name"
    let C_P_FURIGANA = "p_furigana"
    let C_P_CAPACITY = "p_capacity"
    let C_P_ACIDITY = "p_acidity"
    let C_P_NIHONSHUDO = "p_nihonshudo"
    let C_B_RICE_POLISH = "b_rice_polish"
    let C_P_BEST_TEMPERATURE = "p_best_temperature"
    let C_P_ALCOHOL = "p_alcohol"
    let C_B_NAME = "b_name"
    let C_P_IMAGE = "p_image"
    
    /*** type ***/
    let T_INT = "INTEGER"
    let T_TEXT = "TEXT"
    
    /*** OTHER ***/
    let PRIMARY = "PRIMARY KEY"
    let VALUES = "VALUES"
    let ORDER_BY = "ORDER BY"
    let SET = "SET"
    let WHERE = "WHERE"
    let END = ";"
    
    private func defineTable() -> String {
        return "(\(C_ID) \(T_INT) \(PRIMARY)," +
        "\(C_DATE) \(T_TEXT)," +
        "\(C_RATE) \(T_INT)," +
        "\(C_MEMO) \(T_TEXT)," +
        "\(C_P_NAME) \(T_TEXT)," +
        "\(C_P_FURIGANA) \(T_TEXT)," +
        "\(C_P_CAPACITY) \(T_TEXT)," +
        "\(C_P_ACIDITY) \(T_TEXT)," +
        "\(C_P_NIHONSHUDO) \(T_TEXT)," +
        "\(C_B_RICE_POLISH) \(T_TEXT)," +
        "\(C_P_BEST_TEMPERATURE) \(T_TEXT)," +
        "\(C_P_ALCOHOL) \(T_TEXT)," +
        "\(C_B_NAME) \(T_TEXT)," +
        "\(C_P_IMAGE) \(T_TEXT))"
    }
    
    private func insertTable() -> String {
        return "(\(C_DATE),\(C_RATE),\(C_MEMO),\(C_P_NAME),\(C_P_FURIGANA),\(C_P_CAPACITY),\(C_P_ACIDITY)," +
        "\(C_P_NIHONSHUDO),\(C_B_RICE_POLISH),\(C_P_BEST_TEMPERATURE),\(C_P_ALCOHOL),\(C_B_NAME),\(C_P_IMAGE))"
    }
    
    let INPUT_PARAM = "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
    
    private override init() {
        super.init()
        // /Documentsまでのパスを取得
        let paths = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask, true)
        // <Application>/Documents/sample.db というパスを生成
        let _path = paths[0].appendingPathComponent("jp.mst.sakeLog.db")
        
        // FMDatabaseクラスのインスタンスを作成
        // 引数にファイルまでのパスを渡す
        db = FMDatabase(path: _path)
        
        // データベースをオープン
        db.open()
        
        // create文
        let createQuery =
            "\(CREATE_TABLE) \(IF_NOT_EXISTS) \(T_SAKELOG) " +
            defineTable() +
            "\(END)"
        
        // テーブル作成
        db.executeUpdate(createQuery, withArgumentsIn: nil)
    }

    deinit {
        // データベースをクローズ
        db.close()
    }
    
    func insertSakeLog(param: Array<Any>) {
        let insertQuery =
            "\(INSERT_INTO) \(T_SAKELOG)" +
            insertTable() +
            "\(VALUES) \(INPUT_PARAM)\(END)"
        db.executeUpdate(insertQuery, withArgumentsIn: param)
    }
    
    func updateSakeLog(forColumnKey: String, value: Any, atID : Int){
        let updateQuery =
            "\(UPDATE) \(T_SAKELOG) \(SET) \(forColumnKey) = \"\(value)\" \(WHERE) \(C_ID) = \(atID)"
        db.executeUpdate(updateQuery, withArgumentsIn: nil)
    }
    
    func deleteSakeLog(atID : Int){
        let deleteQuery =
            "\(DELETE_FROM) \(T_SAKELOG) \(WHERE) \(C_ID) = \(atID)"
        db.executeUpdate(deleteQuery, withArgumentsIn: nil)
    }
    
    func selectSakeLog() -> [SakeLogData] {
        var retArraySakeLogData = Array<SakeLogData>()
        let selectQuery =
            "\(SELECT_FROM) \(T_SAKELOG) \(ORDER_BY) \(C_ID)\(END)"
        let result = db.executeQuery(selectQuery, withArgumentsIn: nil)
        
        if let cursor = result{
            while cursor.next() {
                let sakeLog : SakeLogData = SakeLogData()
                sakeLog.id = Int(cursor.int(forColumn: C_ID))
                sakeLog.date = cursor.string(forColumn: C_DATE)
                sakeLog.rate = Int(cursor.int(forColumn: C_RATE))
                sakeLog.memo = cursor.string(forColumn: C_MEMO)
                sakeLog.p_name = cursor.string(forColumn: C_P_NAME)
                sakeLog.p_furigana = cursor.string(forColumn: C_P_FURIGANA)
                sakeLog.p_capacity = cursor.string(forColumn: C_P_CAPACITY)
                sakeLog.p_acidity = cursor.string(forColumn: C_P_ACIDITY)
                sakeLog.p_nihonshudo = cursor.string(forColumn: C_P_NIHONSHUDO)
                sakeLog.b_rice_polish = cursor.string(forColumn: C_B_RICE_POLISH)
                sakeLog.p_best_temperature = cursor.string(forColumn: C_P_BEST_TEMPERATURE)
                sakeLog.p_alcohol = cursor.string(forColumn: C_P_ALCOHOL)
                sakeLog.b_name = cursor.string(forColumn: C_B_NAME)
                sakeLog.p_image = cursor.string(forColumn: C_P_IMAGE)
                retArraySakeLogData.append(sakeLog)
            }
        }
        return retArraySakeLogData
    }    
}
