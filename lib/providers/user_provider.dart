import 'package:ChatApp/models/user.dart';
import 'package:ChatApp/screens/home_page.dart';
import 'package:ChatApp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  User? myUser;

  defineUser(String uid) async {
    CollectionReference refUsers =
        FirebaseFirestore.instance.collection('users');
    DocumentSnapshot doc = await refUsers.doc(uid).get();
    User thisUser = User.fromDocument(doc);
    myUser = thisUser;
    notifyListeners();
    return thisUser;
  }

  updateUserInfo(User updatedUser, String currentUserId) async {
    myUser?.bio = updatedUser.bio;
    myUser?.photo = updatedUser.photo;
    myUser?.username = updatedUser.username;
    notifyListeners();
    await DatabaseMethods().upDateUsersInfo(updatedUser, currentUserId);
  }
}
