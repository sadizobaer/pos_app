import 'package:dorkar/config/strings.dart';
import 'package:dorkar/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../config/colors.dart';
import '../../controller/blocs/login/login_bloc.dart';
import '../../controller/providers/login_provider.dart';
import '../../routes/route_names.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _emailController =
      TextEditingController(text: "");
  final TextEditingController _passwordController =
      TextEditingController(text: "");

  Container _textField(
      TextEditingController controller, String hint, IconData iconData) {
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
              loginText,
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
              login,
              style: TextStyle(
                fontSize: 34.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            _textField(_emailController, "Email or Phone", Icons.lock),
            SizedBox(height: 12.h),
            _textField(_passwordController, "Password", Icons.person),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                if (_emailController.text == "" ||
                    _passwordController.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("All fields are required"),
                    ),
                  );
                } else {
                  context.read<LoginBloc>().add(LoginWithEmailAndPassword(
                      _emailController.text, _passwordController.text));
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
                          login,
                          style: semiBoldText(16.sp, color: white),
                        ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Align(
              alignment: Alignment.center,
              child: Text(
                forgetPassword,
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
                      content: Text('Something went wrong!'),
                    ),
                  );
                }
                if(state is LoginLoaded){
                  Provider.of<LoginProvider>(context, listen: false)
                      .setAuthenticating(false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Successfully logged in!'),
                    ),
                  );
                  context.goNamed(homePage);
                }
                if(state is LoginConnectionError){
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
