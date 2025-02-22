import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/domain/model/turf_model.dart';

class SearchServices {
  Future<List<TurfModel>> searching(Map<String, String> querys) async {
    List<TurfModel> turfs = [];
    final String? searchQuery = querys["search"]?.toLowerCase();
    final String? Searchcategory = querys['category']?.toLowerCase();
    final String? date = querys['date'];
    final String? time = querys['time'];
    final String? startprice = querys['startprice'];
    final String? endprice = querys['endprice'];
    final instance = FirebaseFirestore.instance;
    final ownerSnap = await instance.collection("owner").get();
    for (var ownerDoc in ownerSnap.docs) {
      final ownerData = ownerDoc.data();
      final turfDocs = await ownerDoc.reference.collection("turfs").get();
      if (turfDocs.docs.isNotEmpty) {
        for (var turf in turfDocs.docs) {
          bool isSearch = false;
          final turfData = turf.data();
          final String turfname = turfData['turfname'].toString().toLowerCase();
          final String category = turfData['catogery'].toString().toLowerCase();
          if (searchQuery != null && turfname.contains(searchQuery) ||
              searchQuery == category) {
            isSearch = true;
          }
          if(isSearch == true && startprice!=null && endprice !=null){
            double start = double.parse(startprice);
            double end = double.parse(endprice);
            int price = int.parse(turfData["price"]);
            if(!(start<=price && price<=end)){
              isSearch = false;
            }
          }
          if (isSearch && turfData["reviewStatus"] == "true") {
            final turfModel = TurfModel(
              latitude: turfData['latitude'],
              longitude: turfData['longitude'],
              ownerId: ownerData['uid'],
              turfId: turfData['turfid'],
              ownerName: ownerData['name'],
              ownerEmail: ownerData['email'],
              turfName: turfData['turfname'],
              phone: turfData['phone'],
              email: turfData['email'],
              price: turfData['price'],
              state: turfData['state'],
              country: turfData['country'],
              catogery: turfData['catogery'],
              includes: turfData['includes'],
              landmark: turfData['landmark'],
              reviewStatus: turfData['reviewStatus'],
              images: turfData["images"],
            );
            turfs.add(turfModel);
          }
        }
      }
    }
    return turfs;
  }
}
