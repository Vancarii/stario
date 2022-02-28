import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFunctions {
  static FirebaseFirestore _firestoreFirebase;
  static FirebaseAuth _firestoreAuth;

  Map userData;

  Future<void> init() async {
    _firestoreFirebase ??= FirebaseFirestore.instance;
    _firestoreAuth ??= FirebaseAuth.instance;

    stream();
  }

  //get auth => _firestoreAuth;

  get userDataStream => userData;

  void stream() async {
    await for (var snapshot in _firestoreFirebase.collection('users').snapshots()) {
      for (var message in snapshot.docs) {
        print('pls work boss: ${message.data()} : ${message.id}');
        userData = message.data();
      }
    }
  }

  //Goes through all users UIDs and matches current logged in auth UID
  /*Future<List<String>> getUserDetailsWithAuthUID(currentAuthUserUID) async {
    final users = await _firestoreFirebase.collection('users').get();
    for (var user in users.docs) {
      final uid = user.data()['uid'];
      final artistName = user.data()['artist name'];
      print('UIDS: $uid');
      print('artistName: $artistName');

      if (currentAuthUserUID == uid) {
*/ /*        print('user: ${user.id}');

        print('SIUUUU');
        print(uid + ' ' + currentAuthUserUID);*/ /*
        return [user.id, artistName];
      }
    }
    return null;
  }*/
}

final firebaseFunctions = FirebaseFunctions();
