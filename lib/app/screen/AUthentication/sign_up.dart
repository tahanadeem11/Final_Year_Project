import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Theme/theme.dart';
import '../home/widgets/demopagestate.dart';
import 'login.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  TextEditingController firstName = TextEditingController();
  TextEditingController listName = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;



  int index =0;

  @override
  Widget build(BuildContext context) {

    void _navigateToSignUp() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen()),
      );
    }
    // Function to navigate to SignInScreen
    void _navigateToSignIn() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    }
    return Scaffold(
      backgroundColor: AppColor.kWhite,
      appBar: AppBar(
          backgroundColor: Color(0xFF43A1D4),
          elevation: 0,

          centerTitle: true,
          title: Text(
            'LABQUEST',
            textAlign: TextAlign.center,
            style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white
    ),
         // automaticallyImplyLeading:false
      ),),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(children: [

              Container(
                height: 200,
                //color: Colors.blue,

                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF43A1D4),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        children: [
                          Text(
                            'Create Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'We happy to see you. Sign Up to your account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                    children: [

              Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'First Name',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                            ),
                          ),
                          const SizedBox(height: 8),
                          PrimaryTextFormField(
                              borderRadius: BorderRadius.circular(24),
                              hintText: 'First',
                              controller: firstName,
                              width: 155,
                              height: 52)
                        ],
                      ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Last Name',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                PrimaryTextFormField(
                                    borderRadius: BorderRadius.circular(24),
                                    hintText: 'Last',
                                    controller: listName,
                                    width: 155,
                                    height: 52)
                              ],
                            ),
                          ],
                        ),

                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                        ),
                      ),
                      const SizedBox(height: 7),
                      PrimaryTextFormField(
                          borderRadius: BorderRadius.circular(24),
                          hintText: 'abc@gmail.com',
                          controller: emailC,
                          width: 327,
                          height: 52)
                    ],
                  ),
                  const SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                        ),
                      ),
                      const SizedBox(height: 8),
                      PasswordTextField(
                          borderRadius: BorderRadius.circular(24),
                          hintText: 'Password',
                          controller: passwordC,
                          width: 327,
                          height: 52)
                    ],
                  ),
                  const SizedBox(height: 28),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF43A1D4)),
                          ),
                          child: Text("Create Account",style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            print("${emailC.text}");
                            registerUser(emailC.text,passwordC.text);
                          },
                        ),
                      ),
                      // PrimaryButton(
                      //   elevation: 0,
                      //   onTap: ()  async{
                      //     try {
                      //       // Sign up the user
                      //       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                      //         email: emailC.text.trim(),
                      //         password: passwordC.text.trim(),
                      //       );
                      //
                      //       // Check if user creation was successful
                      //       if (userCredential.user != null) {
                      //         // Store user data in firestore
                      //         name = '${firstName.text} ${listName.text}';
                      //         CollectionReference users = FirebaseFirestore.instance.collection('Users');
                      //         await users.doc(userCredential.user!.uid).set({
                      //           'id': userCredential.user!.uid,
                      //           'image': '',
                      //           'name': name,
                      //           'email': emailC.text.trim(),
                      //         });
                      //
                      //         // Show sign up successful message
                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //           const SnackBar(
                      //             content: Text('Sign Up Successful'),
                      //           ),
                      //         );
                      //
                      //         // Navigate to the home page
                      //         Navigator.pushReplacement(
                      //           context,
                      //           MaterialPageRoute(builder: (context) => Home()),
                      //         );
                      //       }
                      //     } catch (e) {
                      //       // Handle sign up errors
                      //       print(e);
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(
                      //           content: Text(e.toString()),
                      //         ),
                      //       );
                      //     }
                      //   },
                      //   text: 'Create Account',
                      //   bgColor: AppColor.bgColor,
                      //   borderRadius: 20,
                      //   height: 46,
                      //   width: 327,
                      //   textColor: AppColor.kWhite,
                      // ),
                      const SizedBox(height: 20),
                      CustomRichText(
                        title: 'Already have an account? ',
                        subtitle: 'Log In',
                        onTab: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(),)),
                        subtitleTextStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: DividerRow(title: 'Or Sign Up with'),
                        ),
                        const SizedBox(height: 24),
                        SecondaryButton(
                            height: 56,
                            textColor: AppColor.kGrayscaleDark100,
                            width: 260,
                            onTap: () {},
                            borderRadius: 24,
                            bgColor: AppColor.kBackground.withOpacity(0.3),
                            text: 'Continue with Google',
                            icons: ImagesPath.kGoogleIcon),
                      ],
                    ),
                  ),
                  const SizedBox(height: 23),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: TermsAndPrivacyText(
                      title1: '  By signing up you agree to our',
                      title2: ' Terms ',
                      title3: '  and',
                      title4: ' Conditions of Use',
                    ),
                  ),
                ],
              ),
            ),
          ]),)
        ),
      ),
    );
  }
}

class TermsAndPrivacyText extends StatelessWidget {
  const TermsAndPrivacyText(
      {super.key,
      required this.title1,
      required this.title2,
      required this.title3,
      this.color2,
      required this.title4});
  final Color? color2;
  final String title1, title2, title3, title4;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style:TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white
        ),
        children: [
          TextSpan(
            text: title1,
          ),
          TextSpan(
            text: title2,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white
            ),
          ),
          TextSpan(
            text: title3,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white
            ),
          ),
          TextSpan(
            text: title4,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white
            ),
          ),
        ],
      ),
    );
  }
}

class SecondaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text, icons;
  final double width;
  final double height;
  final double borderRadius;
  final double? fontSize;
  final Color textColor, bgColor;
  const SecondaryButton(
      {super.key,
      required this.onTap,
      required this.text,
      required this.width,
      required this.height,
      required this.icons,
      required this.borderRadius,
      this.fontSize,
      required this.textColor,
      required this.bgColor});

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
          height: widget.height,
          alignment: Alignment.center,
          width: widget.width,
          decoration: BoxDecoration(
            color: widget.bgColor,
            border: Border.all(color: AppColor.kLine),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Row(
            children: [
              Image.asset(widget.icons, width: 23.85, height: 23.04),
              const SizedBox(width: 12),
              Text(widget.text,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                  ),),
            ],
          ),
        ),
      ),
    );
  }
}

class DividerRow extends StatelessWidget {
  final String title;
  const DividerRow({
    required this.title,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Divider(
              color: AppColor.kLine,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Divider(
              color: AppColor.kLine,
            ))
      ],
    );
  }
}

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTab,
    required this.subtitleTextStyle,
  });
  final String title, subtitle;
  final TextStyle subtitleTextStyle;
  final VoidCallback onTab;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: title,
          style:TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white
          ),
          children: <TextSpan>[
            TextSpan(
              text: subtitle,
              style: subtitleTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius, elevation;
  final double? fontSize;
  final IconData? iconData;
  final Color? textColor, bgColor;
  const PrimaryButton(
      {Key? key,
      required this.onTap,
      required this.text,
      this.width,
      this.height,
      this.elevation = 5,
      this.borderRadius,
      this.fontSize,
      required this.textColor,
      required this.bgColor,
      this.iconData})
      : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Card(
          elevation: widget.elevation ?? 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
          ),
          child: Container(
            height: widget.height ?? 55,
            alignment: Alignment.center,
            width: widget.width ?? double.maxFinite,
            decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryTextButton extends StatelessWidget {
  const PrimaryTextButton(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.textStyle});
  final Function() onPressed;
  final String title;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        title,
        style: textStyle,
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final String hintText;

  final double width, height;
  final TextEditingController controller;
  final BorderRadiusGeometry borderRadius;
  const PasswordTextField(
      {Key? key,
      required this.hintText,
      required this.height,
      required this.controller,
      required this.width,
      required this.borderRadius})
      : super(key: key);
  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = false;
  @override
  Widget build(BuildContext context) {
    InputBorder enabledBorder = InputBorder.none;
    InputBorder focusedErrorBorder = InputBorder.none;
    InputBorder errorBorder = InputBorder.none;
    InputBorder focusedBorder = InputBorder.none;

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: AppColor.kBackground2,
          border: Border.all(color: AppColor.kLine)),
      child: TextFormField(
          obscureText: _obscureText,
          controller: widget.controller,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white
          ),
          decoration: InputDecoration(
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColor.kGrayscaleDark100,
                size: 17,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white
            ),
            enabledBorder: enabledBorder,
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: focusedErrorBorder,
          )),
    );
  }
}

class PrimaryTextFormField extends StatelessWidget {
  PrimaryTextFormField(
      {super.key,
      required this.hintText,
      this.keyboardType,
      required this.controller,
      required this.width,
      required this.height,
      this.hintTextColor,
      this.onChanged,
      this.onTapOutside,
      this.prefixIcon,
      this.prefixIconColor,
      this.inputFormatters,
      this.maxLines,
      this.borderRadius});
  final BorderRadiusGeometry? borderRadius;

  final String hintText;

  final List<TextInputFormatter>? inputFormatters;
  Widget? prefixIcon;
  Function(PointerDownEvent)? onTapOutside;
  final Function(String)? onChanged;
  final double width, height;
  TextEditingController controller;
  final Color? hintTextColor, prefixIconColor;
  final TextInputType? keyboardType;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    InputBorder enabledBorder = InputBorder.none;
    InputBorder focusedErrorBorder = InputBorder.none;
    InputBorder errorBorder = InputBorder.none;
    InputBorder focusedBorder = InputBorder.none;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: AppColor.kBackground,
          border: Border.all(color: AppColor.kLine)),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style:TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white
          ),
          prefixIcon: prefixIcon,
          prefixIconColor: prefixIconColor,
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          errorBorder: errorBorder,
          focusedErrorBorder: focusedErrorBorder,
        ),
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        onTapOutside: onTapOutside,
      ),
    );
  }
}
registerUser(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    // Navigate to the home screen upon successful registration
    Get.offAll(Demopagestate()); // Use Get.offAll to clear the navigation stack
  } on FirebaseAuthException catch (e) {
    // Show error message in snackbar
    Get.snackbar("Error", e.message ?? "Unknown error occurred");
    print("Firebase Auth Error: ${e.message}");
  } catch (e) {
    // Show generic error message in snackbar
    Get.snackbar("Error", "An unknown error occurred");
    print("Unknown Error: $e");
  }
}


