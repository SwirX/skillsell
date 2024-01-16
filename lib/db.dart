import 'package:SkillSell/models/property.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class firestoreDB {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // get functions

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
  }
}
