import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// void main() {
//   runApp(MyApp());
// }

class RegisterFormPage extends StatefulWidget {

  @override
  _RegisterFormPageState createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePass = true;
  bool _hidePassConf = true;

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Form'),
        centerTitle: true,
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name *',
                hintText: 'Школьная кличка',
                prefixIcon: Icon(Icons.person),
                suffixIcon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  )
              ),
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone Number *',
                hintText: 'Есть позвонить?',
                helperText: 'Format: (XXX)XXX-XXXX',
                prefixIcon: Icon(Icons.call),
                suffixIcon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  )
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email Address *',
                hintText: 'По IP вычислю!',
                prefixIcon: Icon(Icons.mail),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'True Story *', alignLabelWithHint: true,
                hintText: 'Выкладывай...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 10.0,),
            TextFormField(
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Password *',
                hintText: 'Пароль введи',
                suffixIcon: IconButton(
                  icon: Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                  ),
                icon: Icon(Icons.security),
              ),
            ),
            SizedBox(height: 10.0,),
           TextFormField(
              obscureText: _hidePassConf,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Confirm Password *',
                hintText: 'Пароль повтори',
                suffixIcon: IconButton(
                  icon: Icon(_hidePassConf ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePassConf = !_hidePassConf;
                    });
                  },
                  ),
                icon: Icon(Icons.security),
              ),
            ),
            SizedBox(height: 20.0,),
            RaisedButton(
              onPressed: () {},
              color: Colors.green,
              child: Text(
                'Зарегистрироваться',
                style: TextStyle(color: Colors.white)
              ),
            )
          ],
        ),
        ),
    );
  }
}