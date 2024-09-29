import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sms_admin/feat/auth/services/auth_service.dart';

class SignupPage extends StatefulWidget {
  static const String routeName = '/SignUp';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with AutomaticKeepAliveClientMixin<SignupPage> {
  // Define controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  bool get wantKeepAlive => true; // Keep state alive

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super to maintain state

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Text(
                        "Sign up",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                    FadeInUp(
                      duration: Duration(milliseconds: 1200),
                      child: Text(
                        "Create an account, It's free",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    FadeInUp(
                      duration: Duration(milliseconds: 1200),
                      child: makeInput(label: "Name", controller: nameController),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 1300),
                      child: makeInput(
                        label: "Password",
                        obscureText: true,
                        controller: passwordController,
                      ),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 1400),
                      child: makeInput(
                        label: "Confirm Password",
                        obscureText: true,
                        controller: confirmPasswordController,
                      ),
                    ),
                  ],
                ),
                FadeInUp(
                  duration: Duration(milliseconds: 1500),
                  child: Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      ),
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        // Call signUpUser function on button press
                        signUpUser(context);
                      },
                      color: Colors.greenAccent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Sign up",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                FadeInUp(
                  duration: Duration(milliseconds: 1600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an account?"),
                      Text(
                        " Login",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget makeInput({
    required String label,
    bool obscureText = false,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  // Function to handle sign-up logic
  void signUpUser(BuildContext context) async {
    // Retrieve user input
    String name = nameController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Perform basic validation
    if (name.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showSnackBar(context, 'Please fill in all fields.');
      return;
    }

    if (password != confirmPassword) {
      showSnackBar(context, 'Passwords do not match.');
      return;
    }

    // Call AuthService to sign up the user
    await AuthService().signUpUser(
      context: context,
      name: name,
      password: password,
    );
  }

  // Utility function to show snack bar messages
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
