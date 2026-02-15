import 'package:flutter/material.dart';
import 'package:projectmanager/common/const/const.dart';
import 'package:projectmanager/common/fonts/fonts.dart';
import 'package:projectmanager/common/theme/pallette.dart';
import 'package:projectmanager/view/pages/auth/login.dart';
import 'package:projectmanager/view/widgets/auth/form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PalleteColor.backgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: AppConst.authTopPadding),
            Text(
              'Sign Up',
              style: AppFont.karla.copyWith(
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
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    AuthForm(submitText: 'Sign up'),
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
                            style: AppFont.karla.copyWith(
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
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Login to your account',
                        style: AppFont.karla.copyWith(
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
    );
  }
}
