import 'package:fin_pro_new/backend/auth_service.dart';
import 'package:fin_pro_new/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Pair class for returning multiple values
class Pair<A, B> {
  final A first;
  final B second;
  Pair(this.first, this.second);
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  // Email validation
  bool isValidEmail(String email) {
    if (!email.contains('@') || !email.contains('.')) return false;
    int atIndex = email.indexOf('@');
    int dotIndex = email.lastIndexOf('.');
    if (atIndex < 1 || dotIndex < atIndex + 2 || dotIndex >= email.length - 1) {
      return false;
    }
    return true;
  }

  // Password validation
  Pair<bool, String> isPasswordValid(String password) {
    if (password.length < 6) return Pair(false, 'length');
    bool hasUpper = false;
    bool hasLower = false;
    bool hasDigit = false;

    for (int i = 0; i < password.length; i++) {
      String char = password[i];
      if (char.contains(RegExp(r'[A-Z]')))
        hasUpper = true;
      else if (char.contains(RegExp(r'[a-z]')))
        hasLower = true;
      else if (char.contains(RegExp(r'\d')))
        hasDigit = true;
    }

    if (!hasUpper) return Pair(false, 'upper');
    if (!hasLower) return Pair(false, 'lower');
    if (!hasDigit) return Pair(false, 'digit');

    return Pair(true, 'Passed');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Title
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.4,
            child: ShaderMask(
              shaderCallback:
                  (bounds) => LinearGradient(
                    colors: [Colors.blueAccent, Colors.tealAccent],
                  ).createShader(bounds),
              child: Text(
                "Sign in",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Full Name Label and Field (unused in logic)
          Positioned(
            top: screenHeight * 0.2,
            left: screenWidth * 0.12,
            child: Text(
              "Enter your full name",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
            ),
          ),
          Positioned(
            top: screenHeight * 0.23,
            left: screenWidth * 0.10,
            child: SizedBox(
              width: screenWidth * 0.8,
              child: TextField(
                style:TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Full Name",
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),

          // Email Label and Field
          Positioned(
            top: screenHeight * 0.35,
            left: screenWidth * 0.12,
            child: Text(
              "Enter your email",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
            ),
          ),
          Positioned(
            top: screenHeight * 0.38,
            left: screenWidth * 0.10,
            child: SizedBox(
              height: screenHeight * 0.07,
              width: screenWidth * 0.8,
              child: TextField(
                style:TextStyle(color: Colors.white),
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),

          // Password Label and Field
          Positioned(
            top: screenHeight * 0.49,
            left: screenWidth * 0.12,
            child: Text(
              "Enter your password",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
            ),
          ),
          Positioned(
            top: screenHeight * 0.52,
            left: screenWidth * 0.10,
            child: SizedBox(
              height: screenHeight * 0.07,
              width: screenWidth * 0.8,
              child: TextField(
                style:TextStyle(color: Colors.white),
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),

          // SignIn Button
          Positioned(
            top: screenHeight * 0.64,
            left: screenWidth * 0.2,
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(screenWidth * 0.6, screenHeight * 0.05),
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed:
                  _isLoading
                      ? null
                      : () async {
                        setState(() {
                          _isLoading = true;
                        });

                        String email = _emailController.text.trim();
                        String password = _passwordController.text.trim();

                        // Validations
                        Pair<bool, String> passCheck = isPasswordValid(
                          password,
                        );
                        bool emailValid = isValidEmail(email);

                        if (!passCheck.first) {
                          String errorMsg =
                              {
                                'upper':
                                    'Password must contain at least one uppercase letter',
                                'lower':
                                    'Password must contain at least one lowercase letter',
                                'digit':
                                    'Password must contain at least one digit',
                                'length':
                                    'Password must be at least 6 characters long',
                              }[passCheck.second] ??
                              'Invalid password';

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(errorMsg)));
                          setState(() => _isLoading = false);
                          return;
                        }

                        if (!emailValid) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid email format'),
                            ),
                          );
                          setState(() => _isLoading = false);
                          return;
                        }

                        bool isEmailUsed = await _authService
                            .checkIfEmailExists(email);

                        if (isEmailUsed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'The email is already in use. Try with a different email!',
                              ),
                            ),
                          );
                          setState(() => _isLoading = false);
                          return;
                        }

                        // Sign up
                        final userCredential = await _authService.signUp(
                          email,
                          password,
                        );

                        setState(() => _isLoading = false);

                        if (userCredential != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Dashboard(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Signup failed. Please try again.'),
                            ),
                          );
                        }
                      },
              child: ShaderMask(
                shaderCallback:
                    (bounds) => LinearGradient(
                      colors: [Colors.orangeAccent, Colors.pinkAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                child: Text(
                  'SignIn',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),

          // Loading Spinner Overlay
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(color: Colors.orangeAccent),
              ),
            ),
        ],
      ),
    );
  }
}
