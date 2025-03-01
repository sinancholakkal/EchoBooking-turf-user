 List<Map<String,String>> getDetails(dynamic turfmodel){
  return    [
      {'Name': turfmodel.turfName},
      {'Date': (turfmodel.bookingDate.split("-").reversed.join("-"))},
      {'Time': turfmodel.bookingTime},
      {'Category': turfmodel.catogery},
      {'Landmark': turfmodel.landmark},
      {'Includes': turfmodel.includes},
      {'Price': "₹${turfmodel.price}"},
      {'Payment': "Success"},
      {'Status': turfmodel.status},
    ];
 }