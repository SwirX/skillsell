import 'dart:io';

import 'package:SkillSell/models/property.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class firestoreDB {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // get functions

  Future<List<String>> getAdmins() async {
    return _db.collection("users").doc("admins").get().then((doc) {
      final data = doc.data()!;
      List<String> uids =
          (data["uid"] as List<dynamic>).map((e) => e.toString()).toList();
      return uids;
    });
  }

  Future<Property> getProperty(String id) async {
    return _db.collection('properties').doc(id).get().then((doc) {
      var d = doc.data()!;
      List<String> images =
          (d["images"] as List<dynamic>).map((e) => e.toString()).toList();
      return Property(
        id,
        d["title"],
        d["description"],
        d["address"],
        d["price"],
        images,
        d["category"],
        d["owner"],
        d["email"],
        d["phone"],
        d["status"],
        d["area"],
        d["dealer"],
        d["dealer_num"],
        d["dealer_email"],
      );
    });
  }

  Stream<QuerySnapshot> getProperties() {
    return _db.collection('properties').snapshots();
  }

  Future<List<Property>> getPropertiesByCategory(String category) async {
    return _db
        .collection('properties')
        .where('category', isEqualTo: category)
        .get()
        .then((docs) => docs.docs.map((doc) {
              var d = doc.data();
              List<String> images = (d["images"] as List<dynamic>)
                  .map((e) => e.toString())
                  .toList();
              return Property(
                doc.id,
                d["title"],
                d["description"],
                d["address"],
                d["price"],
                images,
                d["category"],
                d["owner"],
                d["email"],
                d["phone"],
                d["status"],
                d["area"],
                d["dealer"],
                d["dealer_num"],
                d["dealer_email"],
              );
            }).toList());
  }

  Future<List<Property>> getPropertiesByStatus(String status) async {
    return _db
        .collection('properties')
        .where('status', isEqualTo: status)
        .get()
        .then((docs) => docs.docs.map((doc) {
              var d = doc.data();
              List<String> images = (d["images"] as List<dynamic>)
                  .map((e) => e.toString())
                  .toList();
              return Property(
                doc.id,
                d["title"],
                d["description"],
                d["address"],
                d["price"],
                images,
                d["category"],
                d["owner"],
                d["email"],
                d["phone"],
                d["status"],
                d["area"],
                d["dealer"],
                d["dealer_num"],
                d["dealer_email"],
              );
            }).toList());
  }

  Future<List<Property>> getPropertiesByAddress(String address) async {
    return _db
        .collection('properties')
        .where('address', isEqualTo: address)
        .get()
        .then((docs) => docs.docs.map((doc) {
              var d = doc.data();
              List<String> images = (d["images"] as List<dynamic>)
                  .map((e) => e.toString())
                  .toList();
              return Property(
                doc.id,
                d["title"],
                d["description"],
                d["address"],
                d["price"],
                images,
                d["category"],
                d["owner"],
                d["email"],
                d["phone"],
                d["status"],
                d["area"],
                d["dealer"],
                d["dealer_num"],
                d["dealer_email"],
              );
            }).toList());
  }

  Future<String> getUserPfp(String uid) async {
    return _db
        .collection('users')
        .doc(uid)
        .get()
        .then((doc) => doc.data()!['pfp']);
  }

  // post functions

  Future<void> createProperty(Property property) async {
    var ref = await _db.collection('properties').add({
      'title': property.title,
      'description': property.description,
      'address': property.address,
      'price': property.price,
      'images': property.images,
      'category': property.category,
      'owner': property.owner,
      'email': property.email,
      'phone': property.phone,
      'dealer': property.dealer,
      'dealer_num': property.dealerNum,
      'dealer_email': property.dealerEmail,
      'status': property.status,
      'area': property.area,
    });
    _db.collection("properties").doc(ref.id).update({
      "id": ref.id,
    });
    List<File> files = [];
    for (var image in property.images) {
      files.add(File(image));
    }
    var uploadedImages = await uploadImages(files, ref.id, property.title);
    _db.collection("properties").doc(ref.id).update({
      "images": uploadedImages,
    });
  }

  Future<void> createUser(User user) async {
    await _db.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'name': user.displayName,
      'photo_url': user.photoURL ??
          "https://firebasestorage.googleapis.com/v0/b/skillsell.appspot.com/o/users%2Fdefault.jpg?alt=media&token=a8613802-5673-4084-9e95-c02b8e38f116",
      'phone': user.phoneNumber,
    });
  }

  Future<List<String>> uploadImages(
      List<File> images, String propID, String title) async {
    List<String> uploadedLinks = [];
    int iter = 0;
    for (var image in images) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child("properties")
          .child(propID)
          .child("image${iter}_$title.${image.path.split('.').last}");
      final uploadTask = storageRef.putFile(image);
      await uploadTask;
      var link = await storageRef.getDownloadURL();
      uploadedLinks.add(link);
      iter++;
    }
    return uploadedLinks;
  }
}
