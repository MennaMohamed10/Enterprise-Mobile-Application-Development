import 'package:flutter/material.dart';
import 'package:signupscreen/Login.dart';
import 'package:signupscreen/UserModel.dart';
import 'dbHelper.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}
// Modify your _SignUpState class
class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String gender = "";
  String? level;
  List<String> genders = ['Male', 'Female'];
  List<String> levels = ['1', '2', '3', '4'];
  bool visible = false;

  late DbHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  void register() async {
    String uname = nameController.text;
    String email = emailController.text;
    String uid = idController.text;
    String level = this.level ?? ""; // Use selected level
    String password = passwordController.text;
    String gender = this.gender;

    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      UserModel userModel = UserModel(uname, email, uid, level, password, gender);
      await dbHelper.saveData(userModel); // Save user data to the database
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registerd successfully')),
      );
      print('User data saved successfully');
      // You can also perform navigation or show a success message here
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Registration",
                      style: TextStyle(
                        color: Colors.deepPurple,  fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                    ),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: "Name",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                    ),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: "Email",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        }
                        bool validEmail = RegExp(
                            r'^[a-zA-Z0-9_.+-]+@stud\.fci-cu\.edu\.eg$')
                            .hasMatch(value);
                        if (!validEmail) {
                          return "Please enter a valid FCI email address";
                        }
                        return null;
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                    ),
                    child: TextFormField(
                      controller: idController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: "ID",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ID is required";
                        }
                        return null;
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: level,
                      onChanged: (String? newValue) {
                        setState(() {
                          level = newValue;
                        });
                      },
                      items: levels.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        icon: Icon(Icons.format_list_numbered),
                        hintText: 'Level',
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: !visible,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              visible = !visible;
                            });
                          },
                          icon: Icon(visible ? Icons.visibility : Icons
                              .visibility_off),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        }
                        if(value.length<8)
                          return "password must be at least 8 characters";
                        return null;
                      },
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                    ),
                    child: TextFormField(
                      controller: confirmPasswordController,
                      obscureText: !visible,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        hintText: "Confirm Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              visible = !visible;
                            });
                          },
                          icon: Icon(visible ? Icons.visibility : Icons
                              .visibility_off),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        }
                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          return "Passwords don't match";
                        }
                        return null;
                      },
                    ),
                  ),

                  Row(
                    children: [
                      Text(
                        "Gender",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          for (String genderOption in genders)
                            Row(
                              children: [
                                Radio<String>(
                                  value: genderOption,
                                  groupValue: gender,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      gender = newValue!;
                                    });
                                  },
                                ),
                                Text(genderOption),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                         register();
                      }


                    },
                    child: Text('Register'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Do you have an account? "),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Login()),
                          );
                        },
                        child: Text('Login'),
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

