import 'package:flutter/material.dart';
import 'package:register/model/user.dart';

class UserInfoPage extends StatelessWidget {

  User userInfo;
  UserInfoPage({required this.userInfo});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User info'),
        centerTitle: true,
      ),
      body: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                '${userInfo.name.isEmpty ? 'пусто' : userInfo.name}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text('${userInfo.story.isEmpty ? 'пусто' : userInfo.story}'),
              leading: Icon(
                Icons.person, 
                color: Colors.black
                ),
                // trailing: Text('${userInfo.country}'), ///////не работает из-за DropdownButtonFormField
              ),
            ListTile(
              title: Text(
                '${userInfo.phone.isEmpty ? 'пусто' : userInfo.phone}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(
                Icons.phone, 
                color: Colors.black
                ),
              ),
              ListTile(
              title: Text(
                '${userInfo.email.isEmpty ? 'пусто' : userInfo.email}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(
                Icons.email, 
                color: Colors.black
                ),
              ),
          ],
        ),
      ),
    );
  }
}
