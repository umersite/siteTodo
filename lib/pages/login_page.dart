import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todos/pages/register_page.dart';
import 'package:flutter_todos/pages/todo.dart';
import 'package:flutter_todos/services/auth_service.dart';
import 'package:flutter_todos/services/validate.dart';
import 'package:flutter_todos/widgets/background.dart';
import 'package:flutter_todos/widgets/beveled_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const Todos()));
    }
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose

  //   setState(() {
  //     _isProcessing = false;
  //   });
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
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
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
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
                                      width: double.infinity,
                                      child: beveledButton(
                                          title: "Login",
                                          onTap: () {
                                            onPressedSubmit();
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: beveledButton(
                                          title: "Register",
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const RegisterPage()));
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

  void onPressedSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isProcessing = true;
      });
      await Future.delayed(const Duration(seconds: 2), () {});
      SignInUser();
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void SignInUser() {
    AuthenticationHelper()
        .signIn(email: email.toString(), password: password.toString())
        .then((result) {
      if (result == null) {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => const Todos()));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => Todos()));
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
