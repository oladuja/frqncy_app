
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frqncy_app/src/models/user.dart';
import 'package:frqncy_app/src/utils/logger.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUser(UserModel user) async {
    try {
      await _db.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      logger.e('Error saving user: $e');
      rethrow;
    }
  }

  Future<UserModel?> getUser(String id) async {
    try {
      final doc = await _db.collection('users').doc(id).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      logger.e('Error fetching user: $e');
      rethrow;
    }
  }
}
