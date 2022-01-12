import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:register/model/user.dart';
import 'package:register/pages/user_info_page.dart';

// import 'dart:io';

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

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  List<String> _countries = ['Ru', 'Uk', 'Ge', 'Fr'];
  Object? _selectedCountry;

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();

  User newUser = User();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();

    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Register Form'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name *',
                hintText: 'Школьная кличка',
                prefixIcon: Icon(Icons.person),
                suffixIcon: IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () {
                    setState(() {
                      _nameController.text = '';
                    });
                  },
                  color: Colors.red,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              validator: _validateName,
              onSaved: (value) => newUser.name = value!,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              focusNode: _phoneFocus,
              controller: _phoneController,
              decoration: InputDecoration(
                  labelText: 'Phone Number *',
                  hintText: 'Есть позвонить?',
                  helperText: 'Format: (XXX)XXX-XXXX',
                  prefixIcon: Icon(Icons.call),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _phoneController.clear();
                    },
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),

                    //suffixIcon: IconButton(
                    //   icon: Icon(Icons.delete_outline),
                    //   onPressed: () {
                    //     setState(() {
                    //       _phoneController.text = '';
                    //     });
                    //   },
                    // color: Colors.red,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  )),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter(RegExp(r'^[()\d -]{1,15}$'),
                    allow: true),
                // FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) => _validatePhoneNumber(value)
                  ? null
                  : 'Проверьте соответствие (XXX)XXX-XXXX',
              onSaved: (value) => newUser.phone = value!,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Address *',
                hintText: 'По IP вычислю!',
                prefixIcon: Icon(Icons.mail),
                suffixIcon: IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () {
                    setState(() {
                      _emailController.text = '';
                    });
                  },
                  color: Colors.red,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
              onSaved: (value) => newUser.email = value!,
            ),
            SizedBox(
              height: 10.0,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.map),
                labelText: 'Country?',
              ),
              items: _countries.map((country) {
                return DropdownMenuItem(
                  child: Text(country),
                  value: country,
                );
              }).toList(),
              onChanged: (country) {
                print(country);
                setState(() {
                  _selectedCountry = country;
                  // newUser.country = country as String?;
                });
              },
              value: _selectedCountry,
              // validator: (val) {
              //   return val == null ? 'Выбери страну' : null;
              // },
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: _storyController,
              decoration: InputDecoration(
                labelText: 'True Story',
                alignLabelWithHint: true,
                hintText: 'Выкладывай...',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () {
                    setState(() {
                      _storyController.text = '';
                    });
                  },
                  color: Colors.red,
                ),
              ),
              maxLines: 3,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
              onSaved: (value) => newUser.story = value!,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: _passController,
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Password *',
                hintText: 'Пароль введи',
                suffixIcon: IconButton(
                  icon:
                      Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
                icon: Icon(Icons.security),
              ),
              validator: _validaePassword,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: _confirmPassController,
              obscureText: _hidePassConf,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Confirm Password *',
                hintText: 'Пароль повтори',
                suffixIcon: IconButton(
                  icon: Icon(
                      _hidePassConf ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePassConf = !_hidePassConf;
                    });
                  },
                ),
                icon: Icon(Icons.security),
              ),
              validator: _validaePassword,
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              onPressed: _submitForm,
              color: Colors.green,
              child: Text('Зарегистрироваться',
                  style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showDialog(name: _nameController.text);
      // print('Form is valid');
      print('name user is ${_nameController.text}');
      print('phone user is ${_phoneController.text}');
      print('email user is ${_emailController.text}');
      print('story user is ${_storyController.text}');
    } else {
      _showMessage(message: 'Проверьте введенные данные');
    }
  }

  String? _validateName(value) {
    final _nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value.isEmpty) {
      return 'Поле Name не может быть пустым.';
    } else if (!_nameExp.hasMatch(value)) {
      return 'Поле Name некорректно.';
    } else {
      return null;
    }
  }

  bool _validatePhoneNumber(input) {
    final _phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d-\d\d\d\d$');
    return _phoneExp.hasMatch(input);
  }

  String? _validateEmail(value) {
    if (value.isEmpty) {
      return 'Поле Email не может быть пустым.';
    } else if (!_emailController.text.contains('@') ||
        !_emailController.text.contains('.')) {
      return 'Поле Email некорректно';
    } else {
      return null;
    }
  }

  String? _validaePassword(value) {
    if (_passController.text.length < 8) {
      return 'Минимум 8 символов';
    } else if (_confirmPassController.text != _passController.text) {
      return 'Пароли не совпадают';
    } else {
      return null;
    }
  }

  void _showMessage({message}) {
    _scaffoldKey.currentState!.showSnackBar(
      SnackBar(
          duration: Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            message,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18.0),
          )),
    );
  }

  void _showDialog({name}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Регистрация прошла успешно.',
              style: TextStyle(fontSize: 15.0, color: Colors.green),
            ),
            content: Text(
              'Поздравляю!',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserInfoPage(
                          userInfo: newUser,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Закрыть',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18.0,
                    ),
                  ))
            ],
          );
        });
  }
}
