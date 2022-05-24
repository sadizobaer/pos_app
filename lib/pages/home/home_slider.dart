import 'package:dorkar/config/colors.dart';
import 'package:dorkar/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSlider extends StatelessWidget {
  HomeSlider({Key? key}) : super(key: key);

  //=============variables============
  //----------------------------------

  int _current = 0;
  List<int> items = [1, 2, 3, 4];

  //=============functions============
  //----------------------------------

  ///This function indicates categories contains
  ///+ Category Image
  ///+ Category Name
  Column _categoryItem(int index) {
    return Column(
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
          child: Image.asset(
            'assets/demo_images/demo$index.png',
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Mouse',
          style: semiBoldText(10.sp),
        ),
      ],
    );
  }

  ///This is the slider section contains
  ///+ Several Items
  ///+ Page Indicator
  Padding _slider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: GridView.builder(
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 2.h,
          crossAxisSpacing: 8.w,
          mainAxisExtent: 80.h,
        ),
        itemBuilder: (context, index) {
          return _categoryItem(index);
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
                  height: 184.h,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return _slider(context);
                }),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: items.map((url) {
                    int index = items.indexOf(url);
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
