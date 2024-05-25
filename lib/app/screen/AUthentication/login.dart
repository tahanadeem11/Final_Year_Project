import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../Theme/color.dart';
import '../home/widgets/demopagestate.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _isLoading = false;
  bool _termsAccepted = false; // Add this variable

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate() || !_termsAccepted) { // Check if terms are accepted
      if (!_termsAccepted) {
        Get.snackbar(
          "Error",
          "You must accept the terms and conditions",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Get.off(() => Demopagestate());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message!,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            SizedBox(height: 10),
            Text(
              "Login to your\nAccount",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 10),
            Spacer(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    cursorColor: Colors.grey,
                    cursorHeight: 15,
                    decoration: InputDecoration(
                      focusColor: AppColors.TextfieldColor,
                      border: InputBorder.none,
                      filled: true,
                      fillColor: AppColors.TextfieldColor,
                      label: Text("Email"),
                      labelStyle: TextStyle(
                        color: AppColors.TextfieldTextColor,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_passwordVisible,
                    cursorColor: Colors.grey,
                    cursorHeight: 15,
                    decoration: InputDecoration(
                      focusColor: AppColors.TextfieldColor,
                      border: InputBorder.none,
                      filled: true,
                      fillColor: AppColors.TextfieldColor,
                      label: Text("Password"),
                      labelStyle: TextStyle(
                        color: AppColors.TextfieldTextColor,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.TextfieldTextColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: _termsAccepted,
                        onChanged: (value) {
                          setState(() {
                            _termsAccepted = value!;
                          });
                        },
                      ),
                      Text(
                        "I agree with terms & conditions",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: _isLoading ? null : _signIn,
                    child: Container(
                      height: 48,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: _termsAccepted ? AppColors.Primary_Color : Colors.white, // Update button color based on termsAccepted
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: _termsAccepted ? Colors.deepPurple.withOpacity(0.5) : Colors.grey.withOpacity(0.5), // Update shadow color based on termsAccepted
                            spreadRadius: 2,
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: Center(
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                          "Sign in",
                          style: TextStyle(
                            color: _termsAccepted ? Colors.white : Colors.grey, // Update text color based on termsAccepted
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Forgot your Password?",
              style: TextStyle(
                color: AppColors.Primary_Color,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 20),
            Spacer(),
            Row(
              children: <Widget>[
                Expanded(
                  child: Divider(height: 1, thickness: 2),
                ),
                Text("  Or Continue With  "),
                Expanded(
                  child: Divider(height: 1, thickness: 2),
                ),
              ],
            ),
            Spacer(),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 20),
                  Container(
                    height: 53,
                    width: 53,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Image.asset("assets/google.png"),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?  ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed("/SignUpScreen");
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: AppColors.Primary_Color,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

