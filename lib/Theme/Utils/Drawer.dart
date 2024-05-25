import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Theme/color.dart';

class AppDrawer extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> _getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      return userData.data() as Map<String, dynamic>;
    }
    return {};
  }

  void _logout() async {
    await _auth.signOut();
    Get.offAllNamed('/SignInScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[


              Divider(),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: _logout,
              ),
            ],

      ),
    );
  }
}
