import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 36, 36),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),

          child: SizedBox(
            width: double.infinity,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                const Center(
                  child: Icon(
                    Icons.coffee_outlined,
                    size: 45,
                    color: Color.fromARGB(255, 109, 76, 65),
                  ),
                ),

                // Welcome text
                Center(
                  child: const Text(
                    'Welcome back',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 247, 245, 245),
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                // Subtitle
                Center(
                  child: const Text(
                    'Take a breath and start your journey again',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 109, 76, 65),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Email label
                const Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 251, 249, 249),
                  ),
                ),

                const SizedBox(height: 8),

                // Email field
                SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Color.fromARGB(255, 109, 76, 65),
                      ),

                      hintText: 'Enter your email',

                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 109, 76, 65),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 109, 76, 65),
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 109, 76, 65),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Password label
                const Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 250, 249, 248),
                  ),
                ),

                const SizedBox(height: 8),

                // Password field
                SizedBox(
                  height: 40,
                  child: TextField(
                    obscureText: true,

                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color.fromARGB(255, 109, 76, 65),
                      ),

                      suffixIcon: const Icon(
                        Icons.visibility_off,
                        color: Color.fromARGB(255, 109, 76, 65),
                      ),

                      hintText: 'Enter your password',

                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 109, 76, 65),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 109, 76, 65),
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 109, 76, 65),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },

                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 254, 253, 253),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                // Login button
                SizedBox(
                  width: double.infinity,
                  height: 45,

                  child: ElevatedButton(
                    onPressed: () {
                      // Handle login logic here
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 109, 76, 65),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    child: const Text(
                      'Log In',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Or
                const Center(
                  child: Text(
                    'Or',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 30, 30, 30),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Google button
                SizedBox(
                  width: double.infinity,
                  height: 45,

                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Google login logic here
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 251, 253, 253),

                      elevation: 1,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: Color.fromARGB(255, 220, 220, 220),
                        ),
                      ),
                    ),

                    child: const Text(
                      'Continue with Google',
                      style: TextStyle(
                        color: Color.fromARGB(255, 30, 30, 30),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 243, 242, 242),
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        // Handle sign up logic here
                      },

                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 109, 76, 65),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}