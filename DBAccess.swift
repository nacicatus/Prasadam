//
//  DBAccess.swift
//  Prasadam
//
//  Created by Saurabh Sikka on 06/12/15.
//  Copyright © 2015 Saurabh Sikka. All rights reserved.
//

import Foundation

class DBAccess : NSObject {
    var database: COpaquePointer = nil
    
    override init(){
        super.init()
        self.initializeDatabase()
    }
    
    func initializeDatabase() {
        let path = NSBundle.mainBundle().pathForResource("catalog", ofType: "db")
        if (sqlite3_open(path!, &database) == SQLITE_OK){
            print("Opening Database")
        } else {
            print("Error opening database. Closing database")
            sqlite3_close(database)
        }
    }
    
    func closeDatabase() {
        if sqlite3_close(database) != SQLITE_OK {
            print("Error closing Database")
        } else {
            print("Closing Database")
        }
        database = nil
    }
    
    
    func getAllProducts() -> NSMutableArray {
        let products = NSMutableArray()
        
        let sql = "SELECT product.ID,product.Name,Manufacturer.name,product.details,product.price,product.quantityonhand,country.country, product.image FROM Product,Manufacturer, Country where manufacturer.manufacturerid=product.manufacturerid and product.countryoforiginid=country.countryid"
        
        var statement: COpaquePointer = nil
        
        let sqlResult = sqlite3_prepare_v2(database, sql, -1, &statement, nil)
        
        if sqlResult == SQLITE_OK {
            // Step through the results - once for each row.
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //  allocate a Product object to add to products array
                let product = Product()
                
                // The second parameter is the column index (0 based) in
                // the result set.
                let name = sqlite3_column_text(statement, 1)
                let manufacturer = sqlite3_column_text(statement, 2)
                let details = sqlite3_column_text(statement, 3)
                let countryOfOrigin = sqlite3_column_text(statement, 6)
                let image = sqlite3_column_text(statement, 7)
                
                //  Set all the attributes of the product
                product.ID = sqlite3_column_int64(statement, 0)
                product.name = "\(name)"
                product.manufacturer = "\(manufacturer)"
                product.details = "\(details)"
                product.price = sqlite3_column_double(statement, 4)
                product.quantity = sqlite3_column_int(statement, 5)
                product.countryOfOrigin = "\(countryOfOrigin)"
                product.image = "\(image)"
                
                // Add the product to the products array
                products.addObject(product)
                
            }
            // finalize the statement to release its resources
            sqlite3_finalize(statement)
        }
        else {
            print("Problem with the database:")
            print("\(sqlResult)")
        }
        
        return products;
        
        
    }
    
    
}

