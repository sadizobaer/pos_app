import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/colors.dart';
import '../../config/text_styles.dart';
import '../../controller/providers/home_provider.dart';
import 'home_product_model.dart';

class HomeProduct extends StatelessWidget {
  final int? bottomPadding, index;
  final HomeProductModel product;
  const HomeProduct(
      {Key? key, this.bottomPadding = 5, required this.product, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5.h),
        Row(
          children: [
            Container(
              height: 40.h,
              width: 40.w,
              padding: EdgeInsets.all(6.sp),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: textGrey),
              ),
              child: Image.asset(
                product.productImage!,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 20.w),
            SizedBox(
              width: 64.w,
              child: Text(
                product.productName!,
                maxLines: 1,
                style: mediumText(12.sp, color: textGrey),
              ),
            ),
            SizedBox(width: 20.w),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Provider.of<HomeProvider>(context, listen: false)
                        .updateProductQuantity(
                            index!, product.productQuantity! - 1);
                  },
                  child: Container(
                    height: 24.h,
                    width: 20.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: background,
                    ),
                    child: Icon(Icons.remove, size: 12.sp),
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  product.productQuantity!.toString(),
                  style: mediumText(12.sp, color: textGrey),
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: () {
                    Provider.of<HomeProvider>(context, listen: false)
                        .updateProductQuantity(
                            index!, product.productQuantity! + 1);
                  },
                  child: Container(
                    height: 24.h,
                    width: 20.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: background,
                    ),
                    child: Icon(
                      Icons.add,
                      size: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 21.w),
            SizedBox(
              width: 56.w,
              child: Text(
                '${product.productPrice!*product.productQuantity!} TK',
                style: mediumText(12.sp, color: textGrey),
              ),
            ),
            SizedBox(width: 10.w),
            InkWell(
              onTap: () {
                Provider.of<HomeProvider>(context, listen: false)
                    .deleteProduct(index!);
              },
              child: Container(
                height: 15.h,
                width: 15.w,
                padding: EdgeInsets.all(4.sp),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryRed,
                ),
                child: Icon(
                  Icons.close,
                  color: white,
                  size: 8.sp,
                ),
              ),
            )
          ],
        ),
        SizedBox(height: bottomPadding!.h),
        Container(height: .4.h, color: textGrey),
      ],
    );
  }
}
