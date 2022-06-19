import 'package:dorkar/config/strings.dart';
import 'package:dorkar/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../config/colors.dart';
import '../../controller/blocs/login/login_bloc.dart';
import '../../controller/providers/home_provider.dart';
import '../../controller/providers/login_provider.dart';
import '../../routes/route_names.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  static final TextEditingController password = TextEditingController();
  static final TextEditingController email = TextEditingController();

  _textField(TextEditingController controller, String hint, IconData iconData,
      {bool isPassword = false}) {
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        height: 38.h,
        margin: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: textGrey, width: .6),
        ),
        child: Row(
          children: [
            SizedBox(width: 8.w),
            Icon(iconData),
            SizedBox(width: 8.w),
            Flexible(
              child: TextField(
                controller: controller,
                obscureText: isPassword,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: regularText(15.sp, color: textGrey),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 360.w,
        padding: EdgeInsets.only(left: 24.w),
        color: white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 54.h,
              width: 200.w,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              Provider.of<HomeProvider>(context, listen: true)
                  .isSwitched
                  ? BanglaString.loginText
                  : EnglishString.loginText,
              style: TextStyle(
                fontSize: 22.sp,
                color: textGrey,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              Provider.of<HomeProvider>(context, listen: true)
                  .isSwitched
                  ? BanglaString.login
                  : EnglishString.login,
              style: TextStyle(
                fontSize: 34.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            _textField(email, "Email or Phone", Icons.email_outlined),
            SizedBox(height: 12.h),
            _textField(password, "Password", Icons.lock, isPassword: true),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                FocusScopeNode currentScope = FocusScope.of(context);
                if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
                if (password.text == "" || email.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("All fields are required"),
                    ),
                  );
                } else {
                  context.read<LoginBloc>().add(
                        LoginWithEmailAndPassword(
                          email.text,
                          password.text,
                        ),
                      );
                  Provider.of<LoginProvider>(context, listen: false)
                      .setAuthenticating(true);
                }
              },
              child: Container(
                height: 38.h,
                margin: EdgeInsets.only(right: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: primaryRed,
                ),
                child: Center(
                  child: Provider.of<LoginProvider>(context, listen: true)
                          .getAuthenticating
                      ? const CircularProgressIndicator.adaptive(
                          backgroundColor: white,
                        )
                      : Text(
                    Provider.of<HomeProvider>(context, listen: true)
                        .isSwitched
                        ? BanglaString.login
                        : EnglishString.login,
                          style: semiBoldText(16.sp, color: white),
                        ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Align(
              alignment: Alignment.center,
              child: Text(
                Provider.of<HomeProvider>(context, listen: true)
                    .isSwitched
                    ? BanglaString.forgetPassword
                    : EnglishString.forgetPassword,
                style: semiBoldText(14.w, color: textGrey),
              ),
            ),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginFailure) {
                  Provider.of<LoginProvider>(context, listen: false)
                      .setAuthenticating(false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Given credentials are incorrect!'),
                    ),
                  );
                }
                if (state is LoginLoaded) {
                  Provider.of<LoginProvider>(context, listen: false)
                      .setAuthenticating(false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Successfully logged in!'),
                    ),
                  );
                  context.goNamed(homePage);
                }
                if (state is LoginConnectionError) {
                  Provider.of<LoginProvider>(context, listen: false)
                      .setAuthenticating(false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No internet!'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
