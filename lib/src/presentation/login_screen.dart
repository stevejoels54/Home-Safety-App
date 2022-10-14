import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import '../presentation/values_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<bool> loginUser() async {
    Map data = {
      'email': _emailController.text,
      'password': _passwordController.text
    };
    //encode Map to JSON
    var body = json.encode(data);

    var url = Uri.parse('https://home-safety-backend.herokuapp.com/login/');
    bool success = false;
    var response = await http.post(url, body: body);

    if (response.statusCode == 201) {
      success = true;
    } else {
      success = false;
    }
    return success;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/home-pic4.jpeg'),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.5),
          body: SafeArea(
              child: Column(
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Center(
                  child: Text(
                    'Home Safety System',
                    style: GoogleFonts.nunitoSans(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              //Email Input field (container)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[600]?.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(16)),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          prefixIcon:
                              Icon(Icons.email, color: Colors.white, size: 30),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                    )
                  ],
                ),
              ),
              //Password input field (container)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[600]?.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(16)),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          prefixIcon:
                              Icon(Icons.lock, color: Colors.white, size: 30),
                        ),
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    //Forgot password
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Forgot Password?'),
                  ],
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16)),
                      child: ElevatedButton(
                        onPressed: () {
                          loginUser().then((value) => {
                                if (value)
                                  {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()),
                                    )
                                  }
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8043F9),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        child: const Text('Login'),
                      ))
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: TextButton(
                        onPressed: () {
                          // getUser();
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Create account',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ))
                ],
              ),
            ],
          )),
        ));
  }
}
