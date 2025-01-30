import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_booking/domain/model/user_model.dart';

class UserService {
    Future<void>userStore(UserModel user)async{
    print("===================================storeddetails called");
    FirebaseFirestore.instance.collection("userApp").doc(user.uid).set({
      "uid":user.uid,
      "name":user.name,
      "phone" : user.phone,
      "address":user.address,
    });
  }
}