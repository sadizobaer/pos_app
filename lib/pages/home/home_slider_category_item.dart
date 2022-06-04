import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/colors.dart';
import '../../config/text_styles.dart';
import '../../controller/providers/home_provider.dart';
import '../../data/models/products_model.dart';

class HomeSlider extends StatelessWidget {
  final List<List<Products>> pageWiseSearchProductItem;
  HomeSlider({
    Key? key,
    required this.pageWiseSearchProductItem,
  }) : super(key: key);

  //=============variables============
  //----------------------------------

  int _current = 0;

  //=============functions============
  //----------------------------------

  ///This function indicates categories contains
  ///+ Category Image
  ///+ Category Name
  InkWell _productItem(Products productData, BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<HomeProvider>(context, listen: false)
            .addProduct(product: productData);
        Provider.of<HomeProvider>(context, listen: false)
            .setCategoryItemName('');
        FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Column(
        children: [
          SizedBox(height: 12.h),
          Container(
            height: 50.h,
            width: 50.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: white,
            ),
            padding: EdgeInsets.all(9.sp),
            child: productData.image == null
                ? Image.asset(
              'assets/images/default.png',
              fit: BoxFit.fill,
            )
                : Image.network(
              productData.image,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            productData.name,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: semiBoldText(10.sp),
          ),
        ],
      ),
    );
  }

  ///This is the slider section contains
  ///+ Several Items
  ///+ Page Indicator
  Padding _slider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 0.h, 12.w, 12.h),
      child: GridView.builder(
        itemCount: pageWiseSearchProductItem[_current].length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 2.h,
          crossAxisSpacing: 8.w,
          mainAxisExtent: 92.h,
        ),
        itemBuilder: (context, index) {
          return _productItem(pageWiseSearchProductItem[_current][index], context,);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            CarouselSlider.builder(
                options: CarouselOptions(
                  autoPlay: false,
                  enableInfiniteScroll: false,
                  height: 200.h,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                itemCount: pageWiseSearchProductItem.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return _slider(context);
                }),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: pageWiseSearchProductItem.map((url) {
                    int index = pageWiseSearchProductItem.indexOf(url);
                    return Container(
                      margin: EdgeInsets.only(right: 4.w),
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == index ? primaryRed : textGrey,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}