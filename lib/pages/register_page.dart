import 'package:flutter/material.dart';
import 'package:flutter_todos/pages/login_page.dart';

import '../services/auth_service.dart';
import '../services/validate.dart';
import '../widgets/background.dart';
import '../widgets/beveled_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  late bool _abscure;
  bool _isProcessing = false;

  String? email;
  String? password;
  final _focusEmail = FocusNode();
  
  final togglePasswordFocusNode = FocusNode();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
     _abscure = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
        automaticallyImplyLeading: false,
      ),
      body: backgroundContainer(fillbody()),
    );
  }

  Widget fillbody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 10,
            color: Colors.black.withOpacity(0.6),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: SafeArea(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            maxLength: 30,
                            decoration: const InputDecoration(
                              hintText: "Enter User ID",
                              labelText: "User ID",
                              prefixIcon:
                                  Icon(Icons.account_box, color: Colors.white),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                validateEmail(value, _focusEmail),
                            onSaved: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                          TextFormField(
                            obscureText: _abscure,
                            maxLength: 8,
                            decoration: InputDecoration(
                              hintText: "Enter Password",
                              labelText: "Password",
                              prefixIcon:
                                  const Icon(Icons.key, color: Colors.white),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                child: GestureDetector(
                                  onTap: _toggleObscured,
                                  child: Icon(
                                    _abscure
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) => validatePass(value),
                            onSaved: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          _isProcessing
                              ?const Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    
                                    CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                              : Column(
                                  mainAxisSize: MainAxisSize.max,
                                  
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width:double.infinity,
                                      child: beveledButton(
                                          title: "Register User",
                                          onTap: () {
                                            onPressedSubmit();
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width:double.infinity,
                                      child: beveledButton(
                                          title: "Go to Login", onTap: () {
                                                 Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) =>
                                                            const LoginPage()));
                                    
                                          }),
                                    )
                                  ],
                                )
                        ],
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleObscured() {
    setState(() {
      _abscure = !_abscure;
      if (togglePasswordFocusNode.hasPrimaryFocus) {
        return;
      }
      togglePasswordFocusNode.canRequestFocus = false;
    });
  }

  void onPressedSubmit()async{
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isProcessing = true;
      });
      await Future.delayed(const Duration(seconds: 2), () {});
      SignUpUser();
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void SignUpUser() {
    AuthenticationHelper()
        .signUp(email: email.toString(), password: password.toString())
        .then((result) {
      if (result == null) {
         Future.delayed(const Duration(seconds: 2), () {});
         ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("User Created")));
         Future.delayed(const Duration(seconds: 2), () {});   
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => const Todos()));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result)));
        Future.delayed(const Duration(seconds: 2), () {});
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => super.widget));
      }
    });

  }
}