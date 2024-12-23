import 'package:event_booking_app/config/bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/app_theme.dart';
import '../../home/pages/bottomnav.dart';
import 'forgot_password.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDarkMode = themeMode == ThemeMode.dark;
        final theme = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          'Welcome Back',
                           style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                          // style: TextStyle(
                          //   color: Colors.black,
                          //   fontSize: 32,
                          //   fontWeight: FontWeight.bold,
                          //   letterSpacing: 0.5,
                          // ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Sign in to continue',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                            ),
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
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
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPassword(),
                                ),
                              );
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xff6351ec),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xff6351ec),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  // Handle sign in
                                }
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: const Center(
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey[300],
                                thickness: 1,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Or continue with',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey[300],
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Container(
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                //sementara
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Bottomnav(),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/google.png',
                                    height: 24,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Sign in with Google',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: theme.textTheme.bodyMedium,
                              // style: TextStyle(
                              //   color: Colors.black87,
                              //   fontSize: 16,
                              // ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Signup(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Color(0xff6351ec),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
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
            ),
          ),
        );
      },
    );
  }
}
