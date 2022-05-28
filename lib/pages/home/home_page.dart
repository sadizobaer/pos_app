import 'package:dorkar/config/colors.dart';
import 'package:dorkar/config/stateful_wrapper.dart';
import 'package:dorkar/config/strings.dart';
import 'package:dorkar/config/text_styles.dart';
import 'package:dorkar/controller/blocs/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/providers/home_provider.dart';
import '../../widgets/dropdown_selection.dart';
import 'home_product.dart';
import 'home_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  //=============functions===============
  //-------------------------------------

  ///This function helps to show image icon
  ImageIcon _showImageIcon(String img, {int size = 20, Color color = white}) {
    return ImageIcon(
      AssetImage(img),
      color: color,
      size: size.sp,
    );
  }

  ///This function refers pop-up-menu-items and contains
  ///+ __showImageIcon
  Flexible _dropdownButton({String? initialItem}) {
    return Flexible(
      child: Container(
        height: 30.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r),
          color: background,
        ),
        child: Row(
          children: [
            SizedBox(width: 11.w),
            Flexible(
              child: DropdownSelection(initialItem: initialItem),
            ),
            SizedBox(width: 8.w),
          ],
        ),
      ),
    );
  }

  ///This function indicates the top-bar and contains
  ///+ __showImageIcon
  Container _appbar(BuildContext context) {
    return Container(
      height: Provider.of<HomeProvider>(context, listen: true).isSettingsTapped
          ? 136.h
          : 92.h,
      color: primaryRed,
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Row(
            children: [
              SizedBox(width: 17.w),
              SizedBox(
                height: 22.h,
                width: 108.w,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.fill,
                  color: white,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Provider.of<HomeProvider>(context, listen: false)
                      .setSettingsTapped(
                          !Provider.of<HomeProvider>(context, listen: false)
                              .isSettingsTapped);
                },
                child: Container(
                  height: 24.h,
                  width: 24.w,
                  padding: EdgeInsets.all(5.sp),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Provider.of<HomeProvider>(context, listen: true)
                            .isSettingsTapped
                        ? white.withOpacity(.2)
                        : white.withOpacity(.0),
                  ),
                  child: _showImageIcon('assets/icons/settings.png', size: 24),
                ),
              ),
              SizedBox(width: 12.w),
              _showImageIcon('assets/icons/notification.png'),
              SizedBox(width: 12.w),
              _showImageIcon('assets/icons/scan.png', size: 17),
              SizedBox(width: 17.w),
            ],
          ),
          Provider.of<HomeProvider>(context, listen: true).isSettingsTapped
              ? SizedBox(height: 6.h)
              : SizedBox(height: 12.h),
          Provider.of<HomeProvider>(context, listen: true).isSettingsTapped
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  child: Row(
                    children: [
                      _dropdownButton(initialItem: 'Warehouse 1'),
                      SizedBox(width: 6.w),
                      _dropdownButton(initialItem: 'Yousuf Ali (ask)'),
                    ],
                  ),
                )
              : Container(),
          Provider.of<HomeProvider>(context, listen: true).isSettingsTapped
              ? SizedBox(height: 6.h)
              : SizedBox(height: 0.h),
          Row(
            children: [
              SizedBox(width: 17.w),
              Text(
                quickAdd.toUpperCase(),
                style: semiBoldText(13.sp, color: white),
              ),
              SizedBox(width: 16.w),
              InkWell(
                onTap: () {
                  Provider.of<HomeProvider>(context, listen: false)
                      .setSliderCollapsed(
                          !Provider.of<HomeProvider>(context, listen: false)
                              .isSliderCollapsed);
                },
                child: Provider.of<HomeProvider>(context, listen: true)
                        .isSliderCollapsed
                    ? _showImageIcon(
                        'assets/icons/arrow_up.png',
                        size: 14,
                      )
                    : _showImageIcon(
                        'assets/icons/arrow_down.png',
                        size: 14,
                      ),
              ),
              const Spacer(),
              Text(
                category.toUpperCase(),
                style: semiBoldText(13.sp, color: white),
              ),
              SizedBox(width: 16.w),
              InkWell(
                onTap: () {
                  Provider.of<HomeProvider>(context, listen: false)
                      .setSliderCollapsed(
                          !Provider.of<HomeProvider>(context, listen: false)
                              .isSliderCollapsed);
                },
                child: Provider.of<HomeProvider>(context, listen: true)
                        .isSliderCollapsed
                    ? _showImageIcon(
                        'assets/icons/arrow_up.png',
                        size: 14,
                      )
                    : _showImageIcon(
                        'assets/icons/arrow_down.png',
                        size: 14,
                      ),
              ),
              SizedBox(width: 17.w),
            ],
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  ///This function refers the title
  Text _titleText(String title) {
    return Text(
      title.toUpperCase(),
      style: boldText(12.sp),
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

  ///This function refers the main body and contains
  ///+ _paymentItem
  ///+ _bottomItemInformation
  ///+ _products
  ///+ _titleText
  ///+ _dropdownButton
  ///+ _showImageIcon
  ///+ _bottomItem
  Container _mainBody(BuildContext context) {
    int totalQuantity =
        Provider.of<HomeProvider>(context, listen: true).getProductsLength;
    double totalPrice =
        Provider.of<HomeProvider>(context, listen: true).getTotalPrice;
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
              Provider.of<HomeProvider>(context, listen: true).isSliderCollapsed
                  ? 10.r
                  : 0.r),
        ),
      ),
      child: Column(
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
                  _showImageIcon(
                    'assets/icons/search.png',
                    size: 13,
                    color: textGrey,
                  ),
                  SizedBox(width: 11.w),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: TextField(
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
                Provider.of<HomeProvider>(context, listen: true)
                            .getProducts
                            .length ==
                        0
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Text(
                          noProducts,
                          style: regularText(
                            14.sp,
                          ),
                        ),
                      )
                    : Column(
                        children: List.generate(
                          Provider.of<HomeProvider>(context, listen: true)
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
                                  product: Provider.of<HomeProvider>(context,
                                          listen: true)
                                      .getProducts[index],
                                )
                              : HomeProduct(
                                  index: index,
                                  product: Provider.of<HomeProvider>(context,
                                          listen: true)
                                      .getProducts[index],
                                ),
                        ),
                      ),
              ],
            ),
          ),
          _bottomItem(['item', 'total', 'dis'],
              ['$totalQuantity', '$totalPrice', '0.0']),
          Container(height: .4.h, color: white),
          _bottomItem(['coupon', 'tax', 'shipping'], ['0.0', '0.0', '0.0']),
          Container(
            height: 42.h,
            color: primaryRed,
            child: Row(
              children: [
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  'Total'.toUpperCase(),
                  style: boldText(14.sp, color: white),
                ),
                const Spacer(),
                Text(
                  '$totalPrice TK',
                  style: boldText(16.sp, color: white),
                ),
                SizedBox(
                  width: 8.w,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 53.h,
            child: Row(
              children: [
                Flexible(
                  child: _paymentItem('assets/images/cash.png', 'CASH'),
                ),
                Container(
                  height: 53.h,
                  width: .4.h,
                  color: background,
                ),
                Flexible(
                  child: _paymentItem('assets/images/bkash.png', 'bKASH'),
                ),
                Container(
                  height: 53.h,
                  width: .4.h,
                  color: background,
                ),
                Flexible(
                  child: _paymentItem('assets/images/card.png', 'CARD'),
                ),
              ],
            ),
          ),
          Container(height: .4.h, color: background)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        HomeBloc _homeBloc;
        _homeBloc = context.read<HomeBloc>();
        _homeBloc.add(HomeCategoryProductsEvent());
      },
      child: Scaffold(
        backgroundColor: background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(92.h),
          child: _appbar(context),
        ),
        body: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          children: [
            Provider.of<HomeProvider>(context, listen: true).isSliderCollapsed
                ? BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
                    if (state is HomeConnectionErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No Internet!'),
                        ),
                      );
                    } else if (state is HomeFailureState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.errorString),
                        ),
                      );
                    }
                  }, builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (state is HomeLoadedState) {
                      //=========products adding from slider page==========
                      //---------------------------------------------------
                      return HomeSlider(
                        pageWiseItem: state.pageWiseItem,
                        productsModel: state.productsModel,
                      );
                    }
                    return Container();
                  })
                : Container(),
            Provider.of<HomeProvider>(context, listen: true).isSliderCollapsed
                ? SizedBox(height: 12.h)
                : const SizedBox.shrink(),
            _mainBody(context),
          ],
        ),
      ),
    );
  }
}
