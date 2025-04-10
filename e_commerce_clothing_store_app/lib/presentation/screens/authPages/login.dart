import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/service/api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 101, 23, 226),
      body: Column(
        children: [
          const Spacer(flex: 2),
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 79, 10, 240),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("User Name"),
                        TextFormField(
                          controller: _usernameController,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter username'
                              : null,
                          decoration: const InputDecoration(
                            hintText: "User Name",
                            prefixIcon: Icon(Icons.person),
                            border: UnderlineInputBorder(),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("Password"),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter password'
                              : null,
                          obscuringCharacter: "*",
                          obscureText: !isVisible,
                          decoration: InputDecoration(
                            hintText: "......",
                            prefixIcon: const Icon(Icons.lock),
                            border: const UnderlineInputBorder(),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () async {},
                              icon: Icon(
                                isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 100),
                        Center(
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _isLoading = true;
                                      final username =
                                          _usernameController.text.trim();
                                      final password =
                                          _passwordController.text.trim();
                                      final api = ApiService();
                                      final token =
                                          await api.login(username, password);
                                      if (token != null) {
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        await prefs.setString('token', token);
                                        await prefs.setString('username',
                                            username); // ← Add this line
                                        Navigator.pushReplacementNamed(
                                            context, '/home');
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text("Login failed")),
                                        );
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 79, 33, 243),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    minimumSize: const Size(200, 60),
                                  ),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              child: const Text(
                                "sign up",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 17),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
