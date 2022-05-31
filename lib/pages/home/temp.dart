import 'package:dorkar/pages/home/search_product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/colors.dart';
import '../../config/strings.dart';
import '../../config/text_styles.dart';
import '../../controller/blocs/home_bloc.dart';
import '../../controller/providers/home_provider.dart';
import 'home_product.dart';

class Temp extends StatelessWidget {
  const Temp({Key? key}) : super(key: key);


  Text _titleText(String title) {
    return Text(
      title.toUpperCase(),
      style: boldText(12.sp),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Container(
                height: 30.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: background,
                ),
                child: Row(
                  children: [
                    SizedBox(width: 11.w),
                    const ImageIcon(
                      AssetImage('assets/icons/search.png'),
                      size: 13,
                      color: textGrey,
                    ),
                    SizedBox(width: 11.w),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: TextField(
                          onChanged: (v) {
                            Provider.of<HomeProvider>(context, listen: false)
                                .setSearchText(v);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: searchProduct,
                            hintStyle: mediumText(12.sp, color: textGrey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 27.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      _titleText(product),
                      SizedBox(width: 16.w),
                      _titleText(name),
                      SizedBox(width: 44.w),
                      _titleText(quantity),
                      SizedBox(width: 40.w),
                      _titleText(price),
                    ],
                  ),
                  SizedBox(height: 13.h),
                  Container(height: .4.h, color: textGrey),
                  SizedBox(
                    height: Provider.of<HomeProvider>(context, listen: false)
                        .isSliderCollapsed
                        ? 124.h
                        : 336.h,
                    child: Provider.of<HomeProvider>(context, listen: true)
                        .getProducts
                        .length ==
                        0
                        ? Center(
                      child: Text(
                        addProductMsg,
                        style: regularText(
                          14.sp,
                        ),
                      ),
                    )
                        : SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          Provider.of<HomeProvider>(context,
                              listen: true)
                              .getProducts
                              .length,
                              (index) => index ==
                              Provider.of<HomeProvider>(context,
                                  listen: true)
                                  .getProducts
                                  .length -
                                  1
                              ? HomeProduct(
                            bottomPadding: 17,
                            index: index,
                            product: Provider.of<HomeProvider>(
                                context,
                                listen: true)
                                .getProducts[index],
                          )
                              : HomeProduct(
                            index: index,
                            product: Provider.of<HomeProvider>(
                                context,
                                listen: true)
                                .getProducts[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Provider.of<HomeProvider>(context, listen: false).getSearchText == ''
            ? Container()
            : Positioned(
          top: 46.h,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 17.w),
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(5.r),
                boxShadow: [
                  BoxShadow(
                    color: textGrey.withOpacity(.4),
                    offset: const Offset(0, 1),
                    blurRadius: 1,
                    spreadRadius: 1,
                  )
                ]),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadedState) {
                  return Column(
                    children: [
                      SizedBox(
                        height: Provider.of<HomeProvider>(context,
                            listen: false)
                            .isSliderCollapsed
                            ? 336.h
                            : 380.h,
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              state.pageWiseProductItem[0].length,
                                  (index) => SearchProduct(
                                product: state.pageWiseProductItem[0]
                                [index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

