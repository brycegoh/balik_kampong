import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreClient {
  static CollectionReference userCollectionReference() {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users;
  }

  static Future<void> addUser() async {
    CollectionReference userRef = userCollectionReference();
    await userRef.add({
      'full_name': "fullName", // John Doe
      'company': "company", // Stokes and Sons
      'age': 123,
      'id': userRef.id
    });
  }
}
