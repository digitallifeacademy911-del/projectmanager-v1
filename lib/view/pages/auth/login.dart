import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projectmanager/common/const/const.dart';
import 'package:projectmanager/common/theme/pallette.dart';
import 'package:projectmanager/view/pages/auth/signup.dart';
import 'package:projectmanager/view/pages/authenticated/projects.dart';
import 'package:projectmanager/view/widgets/auth/form.dart';
import 'package:projectmanager/viewmodel/Authentication/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Consumer<AuthViewmodel>(
      builder: (context, authviewmodel, child) => Scaffold(
        backgroundColor: PalleteColor.backgroundColor,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: AppConst.authTopPadding),
              Text(
                'Log In',
                style: GoogleFonts.karla(
                  color: PalleteColor.white,
                  fontSize: AppConst.H1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              Expanded(
                child: Container(
                  padding: AppConst.bodyPadding,
                  decoration: BoxDecoration(
                    color: PalleteColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: AppConst.bodyRadius,
                      topRight: AppConst.bodyRadius,
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AuthForm(
                        submitText: 'Log In',
                        emailController: emailController,
                        passwordController: passwordController,
                        onSubmit: () async {
                          try {
                            await authviewmodel.login(
                              emailController.text,
                              passwordController.text,
                            );
                            if (context.mounted) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProjectsPage();
                                  },
                                ),
                              );
                            }
                          } on Exception catch (e) {
                            if (kDebugMode) {
                              print(e.toString());
                            }
                          }
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                color: PalleteColor.whiteWeak,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: BoxBorder.all(
                                color: PalleteColor.whiteWeak,
                              ),
                            ),
                            child: Text(
                              'Or',
                              style: GoogleFonts.karla(
                                color: PalleteColor.whiteWeak,
                                fontSize: AppConst.p,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                color: PalleteColor.whiteWeak,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Create a new account',
                          style: GoogleFonts.karla(
                            color: PalleteColor.blueOpacity100,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
