import 'package:dorkar/config/language_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../config/colors.dart';
import '../../config/text_styles.dart';
import '../../controller/providers/home_provider.dart';

class HomeFooter extends StatelessWidget {
  final int totalQuantity;
  final double totalPrice;
  final double totalDiscount;
  const HomeFooter({
    Key? key,
    required this.totalQuantity,
    required this.totalPrice,
    required this.totalDiscount,
  }) : super(key: key);

  ///This function indicates bottom item and contains
  ///+ _bottomItemInformation
  Container _bottomItem(List<String> titles, List<String> values) {
    return Container(
      height: 33.h,
      color: black,
      child: Row(
        children: [
          Flexible(
            child: _bottomItemInformation(title: titles[0], value: values[0]),
          ),
          Container(
            height: 33.h,
            width: .4.h,
            color: white,
          ),
          Flexible(
            child: _bottomItemInformation(title: titles[1], value: values[1]),
          ),
          Container(
            height: 33.h,
            width: .4.h,
            color: white,
          ),
          Flexible(
            child: _bottomItemInformation(title: titles[2], value: values[2]),
          ),
        ],
      ),
    );
  }

  ///This function indicates bottom item information
  Row _bottomItemInformation({String? title, String? value}) {
    return Row(
      children: [
        SizedBox(width: 8.w),
        Text(
          title!.toUpperCase(),
          style: boldText(10.sp, color: white),
        ),
        const Spacer(),
        Text(
          value!,
          style: boldText(10.sp, color: white),
        ),
        SizedBox(width: 8.w),
      ],
    );
  }

  ///This function indicates bottom payment
  Row _paymentItem(String image, String title) {
    return Row(
      children: [
        SizedBox(width: 8.w),
        SizedBox(
          height: 30.h,
          width: 30.w,
          child: Image.asset(
            image,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(width: 16.w),
        Text(
          title,
          style: boldText(14.sp),
        ),
        const Spacer(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Column(
        children: [
          Provider.of<HomeProvider>(context, listen: false).isShowedBottomItem
              ? Column(
                  children: [
                    _bottomItem(
                      ['item', 'total', 'dis'],
                      ['$totalQuantity', '$totalPrice', '$totalDiscount'],
                    ),
                    Container(
                      height: .4.h,
                      color: white,
                    ),
                    _bottomItem(
                      ['coupon', 'tax', 'shipping'],
                      ['0.0', '0.0', '0.0'],
                    ),
                  ],
                )
              : Container(),
          Container(
            height: 42.h,
            color: primaryRed,
            child: Row(
              children: [
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  LanguageController.total().toUpperCase(),
                  style: boldText(14.sp, color: white),
                ),
                const Spacer(),
                Text(
                  '${totalPrice - totalDiscount}' '  ' +
                      LanguageController.taka().toUpperCase(),
                  style: boldText(16.sp, color: white),
                ),
                SizedBox(
                  width: 8.w,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 55.h,
            child: Row(
              children: [
                SizedBox(
                  width: 8.w,
                ),
                Flexible(
                  child: _paymentItem(
                    'assets/images/card.png',
                    LanguageController.card(),
                  ),
                ),
                Container(
                  height: 53.h,
                  width: .4.h,
                  color: background,
                ),
                Flexible(
                  child: _paymentItem(
                    'assets/images/bkash.png',
                    LanguageController.bkash(),
                  ),
                ),
                Container(
                  height: 53.h,
                  width: .4.h,
                  color: background,
                ),
                Flexible(
                  child: _paymentItem(
                    'assets/images/cash.png',
                    LanguageController.cash(),
                  ),
                ),
              ],
            ),
          ),
          Container(height: .4.h, color: background)
        ],
      ),
    );
  }
}
