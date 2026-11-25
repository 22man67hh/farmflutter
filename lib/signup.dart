import 'package:flutter/material.dart';
import 'package:flutter_project/otp.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

 final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController = TextEditingController();

bool _isPasswordMatch = false;
@override
void initState() {
  super.initState();
  _passwordController.addListener(_checkPasswordMatch);
  _confirmPasswordController.addListener(_checkPasswordMatch);
}

 void _checkPasswordMatch() {
   final password=_passwordController.text;
   final confirm=_confirmPasswordController.text;
   final matched=password.isNotEmpty && confirm.isNotEmpty && password==confirm;
   if(matched != _isPasswordMatch){
    setState(() {
      _isPasswordMatch=matched;
    });
     
   }
 }

 @override
 void dispose() {
   _nameController.dispose();
   _phoneController.dispose();
   _emailController.dispose();
   _passwordController.dispose();
   _confirmPasswordController.dispose();
   super.dispose();
 }
  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Signup successful"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Center(child: Text("Signup Page")),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                                SizedBox(height: 30),

                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                    border: Border.all(color: Colors.purpleAccent, width: 5),
                  ),
                  child: Icon(Icons.app_registration_rounded, color: Colors.white, size: 60),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter name";
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 30),
                SizedBox(
                  width:300,
                  child:TextFormField(
                    controller: _phoneController, 
                    keyboardType: TextInputType.phone,
                    decoration:InputDecoration(
                      labelText: "Phone Number",
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    )
                    )
                ),

                SizedBox(height: 30),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter email";
                      }
                      if (!value.contains('@')) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 30),

                SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.key),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),

                    keyboardType: TextInputType.text,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 30),

                SizedBox(
                  width: 300,
                  child:TextFormField(
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration:InputDecoration(
                      labelText: "Confirm Password",
                      prefixIcon: Icon(Icons.key),
errorText: (_confirmPasswordController.text.isNotEmpty && !_isPasswordMatch)
    ? 'Passwords do not match'
    : null,                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    )
                  )
                  ),
                SizedBox(height: 30),
                SizedBox(
                  width: 300,
                 child: ElevatedButton(
                  onPressed: _isPasswordMatch ? _handleSubmit : null,
                  child: const Text("Signup"),
                ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      child: Text("Otp Page"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OtpPage()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          ),
        ),
      ),
    );
  }
}
