//
//  FilteredList.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/27.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
  @FetchRequest var fetchRequest: FetchedResults<T>
  
  // this is our content closure; we'll call this once for each item in the list
  let content: (T) -> Content
  
  init(filterKey: String,
       filterValue: String,
       @ViewBuilder content: @escaping (T) -> Content) {
    
    // NSPredicate has a special symbol that can be used to replace attribute names: %K, for “key”.
    // This will insert values we provide, but won’t add quote marks around them. The correct predicate is this:
    _fetchRequest = FetchRequest<T>(sortDescriptors: [],
                                    predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
    self.content = content
  }
  
  var body: some View {
    List(fetchRequest, id: \.self) { singer in
      self.content(singer)
    }
  }
}
