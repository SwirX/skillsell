import 'package:SkillSell/auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _error = "";
  // ignore: prefer_final_fields
  bool _passwordVisible = false;

  Future<void> signIn() async {
    try {
      await Auth().signinWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 96, 8, 64),
              child: Text(
                'SkillSell',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF3050DD),
                  fontSize: 48,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w100,
                  height: 0,
                ),
              ),
            ),
            Text(_error),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: ShapeDecoration(
                  color: const Color(0xFF222222),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x7F000000),
                      blurRadius: 14.30,
                      offset: Offset(0, 1),
                      spreadRadius: 13,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8, 25, 8, 48),
                      child: Text(
                        'Welcome Back',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFCDCDCD),
                          fontSize: 48,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w100,
                          height: 0,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 32),
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              hintText: "example@test.com",
                              hintStyle: TextStyle(
                                color: Color(0xaaCDCDCD),
                                fontSize: 24,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w100,
                                height: 0,
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Color(0xFFCDCDCD),
                                fontSize: 24,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w100,
                                height: 0,
                              ),
                            ),
                            style: const TextStyle(
                              color: Color(0xFFCDCDCD),
                              fontSize: 24,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w100,
                              height: 0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _passwordController,
                            keyboardType: _passwordVisible
                                ? TextInputType.visiblePassword
                                : TextInputType.text,
                            obscureText: !_passwordVisible,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              hintText: "*********",
                              hintStyle: TextStyle(
                                color: Color(0xaaCDCDCD),
                                fontSize: 24,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w100,
                                height: 0,
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Color(0xFFCDCDCD),
                                fontSize: 24,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w100,
                                height: 0,
                              ),
                            ),
                            style: const TextStyle(
                              color: Color(0xFFCDCDCD),
                              fontSize: 24,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w100,
                              height: 0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8, 32, 8, 24),
                          child: TextButton(
                            onPressed: signIn,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: const Color(0xff4570dd),
                              ),
                              child: const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12, 6, 12, 6),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Color(0xFFCDCDCD),
                                    fontSize: 24,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w200,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.popAndPushNamed(
                                      (context), "/signup"),
                                  child: const Text("Sign up Here!",
                                      style: TextStyle(color: Colors.white)),
                                )
                              ]),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Text(
            //     'OR',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       color: Color(0xFF222222),
            //       fontSize: 24,
            //       fontFamily: 'Lexend',
            //       fontWeight: FontWeight.w100,
            //       height: 0,
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
            //   child: Row(
            //     children: [
            //       Padding(
            //           padding: EdgeInsets.all(8),
            //           child: ElevatedButton(
            //             onPressed: () {},
            //             child: AnyLogo.tech.apple.image(width: 50, height: 50),
            //           ))
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
