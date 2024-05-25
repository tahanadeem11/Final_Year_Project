import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Theme/color.dart';
import '../home/widgets/demopagestate.dart'; // Make sure to import the DemoPageState

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _isLoading = false;
  bool _termsAccepted = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (!_termsAccepted) {
      Get.snackbar(
        "Error",
        "You must accept the terms and conditions",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Store user data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'email': _emailController.text.trim(),
        'uid': userCredential.user!.uid,
      });

      // Navigate to DemoPageState on successful signup
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
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(flex: 2),
            SizedBox(height: 10),
            Text(
              "Sign Up To Your \nAccount",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 10),
            Spacer(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          height: 57,
                          child: TextFormField(
                            controller: _firstNameController,
                            cursorColor: Colors.grey,
                            cursorHeight: 15,
                            decoration: InputDecoration(
                              focusColor: AppColors.TextfieldColor,
                              border: InputBorder.none,
                              filled: true,
                              fillColor: AppColors.TextfieldColor,
                              label: Text("First Name"),
                              labelStyle: TextStyle(color: AppColors.TextfieldTextColor),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Container(
                          height: 57,
                          child: TextFormField(
                            controller: _lastNameController,
                            cursorColor: Colors.grey,
                            cursorHeight: 15,
                            decoration: InputDecoration(
                              focusColor: AppColors.TextfieldColor,
                              border: InputBorder.none,
                              filled: true,
                              fillColor: AppColors.TextfieldColor,
                              label: Text("Last Name"),
                              labelStyle: TextStyle(color: AppColors.TextfieldTextColor),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
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
                      labelStyle: TextStyle(color: AppColors.TextfieldTextColor),
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
                      labelStyle: TextStyle(color: AppColors.TextfieldTextColor),
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
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_passwordVisible,
                    cursorColor: Colors.grey,
                    cursorHeight: 15,
                    decoration: InputDecoration(
                      focusColor: AppColors.TextfieldColor,
                      border: InputBorder.none,
                      filled: true,
                      fillColor: AppColors.TextfieldColor,
                      label: Text("Confirm Password"),
                      labelStyle: TextStyle(color: AppColors.TextfieldTextColor),
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
                        return 'Please confirm your password';
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: _termsAccepted && !_isLoading ? _signUp : null,
                    child: Container(
                      height: 48,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: _termsAccepted ? Colors.deepPurple : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: _termsAccepted
                            ? [BoxShadow(color: Colors.deepPurple.withOpacity(0.5), spreadRadius: 2, blurRadius: 5)]
                            : [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 5)],
                      ),
                      child: Center(
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                          "Sign Up",
                          style: TextStyle(
                            color: _termsAccepted ? Colors.white : Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
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
              "Forgot the Password?",
              style: TextStyle(
                color: AppColors.Primary_Color,
                fontSize: 16,
                fontWeight: FontWeight.w500,
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
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed("/SignIn");
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: AppColors.Primary_Color,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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
