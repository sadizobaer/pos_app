import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../config/colors.dart';
import '../../config/text_styles.dart';
import '../../controller/providers/home_provider.dart';
import '../../data/models/products_model.dart';

class SearchProduct extends StatelessWidget {
  final Products product;
  const SearchProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 282.h,
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(vertical: 8.w),
      decoration: BoxDecoration(
        color: primaryRed.withOpacity(.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          SizedBox(width: 16.w),
          Container(
            height: 40.h,
            width: 40.w,
            padding: EdgeInsets.all(6.sp),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: black),
            ),
            child: product.image == null
                ? Image.asset(
                    'assets/images/default.png',
                    fit: BoxFit.fill,
                  )
                : Image.network(
                    product.image,
                    fit: BoxFit.fill,
                  ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  style: mediumText(
                    14.sp,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  '${product.price * product.quantity} TK',
                  style: mediumText(10.sp),
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(width: 16.w),
          InkWell(
            onTap: () {
              Provider.of<HomeProvider>(context, listen: false)
                  .addProduct(product: product);
              Provider.of<HomeProvider>(context, listen: false)
                  .setSearchText('');
            },
            child: const Icon(Icons.add),
          ),
          SizedBox(width: 16.w),
        ],
      ),
    );
  }
}
