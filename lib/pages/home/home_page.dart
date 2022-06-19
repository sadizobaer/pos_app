import 'package:dorkar/config/colors.dart';
import 'package:dorkar/config/stateful_wrapper.dart';
import 'package:dorkar/config/strings.dart';
import 'package:dorkar/config/text_styles.dart';
import 'package:dorkar/controller/blocs/home/home_bloc.dart';
import 'package:dorkar/pages/home/home_footer.dart';
import 'package:dorkar/pages/home/search_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controller/blocs/search/search_bloc.dart';
import '../../controller/providers/home_provider.dart';
import '../../widgets/dropdown_selection.dart';
import 'home_body.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

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

  ///This function indicates the header portion and contains
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
                      .setSwitchToggle(
                          !Provider.of<HomeProvider>(context, listen: false)
                              .isSwitched);
                },
                child: Stack(
                  children: [
                    Container(
                      height: 16.h,
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                    Provider.of<HomeProvider>(context, listen: true).isSwitched
                        ? Positioned(
                            left: 0,
                            child: Container(
                              height: 16.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                color: textGrey,
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Center(
                                child: Text(
                                  'BN',
                                  style: boldText(9.sp, color: white),
                                ),
                              ),
                            ),
                          )
                        : Positioned(
                            right: 0,
                            child: Container(
                              height: 16.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                color: black,
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              child: Center(
                                child: Text(
                                  'EN',
                                  style: boldText(9.sp, color: white),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
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
              InkWell(
                onTap: () async {
                  String barcodeScanRes;
                  barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    "#ff6666",
                    "Cancel",
                    false,
                    ScanMode.DEFAULT,
                  );
                  showDialog(
                      context: context,
                      builder: (i) {
                        return Scaffold(
                          body: SizedBox(
                            height: 200,
                            width: 200,
                            child: Center(
                              child: Text(barcodeScanRes),
                            ),
                          ),
                        );
                      });
                },
                child: _showImageIcon('assets/icons/scan.png', size: 17),
              ),
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
              InkWell(
                onTap: () {
                  Provider.of<HomeProvider>(context, listen: false)
                      .setSelectedView('QUICK_ADD');
                  Provider.of<HomeProvider>(context, listen: false)
                      .setCategoryItemName('');
                },
                child: Text(
                  EnglishString.quickAdd.toUpperCase(),
                  style: semiBoldText(13.sp,
                      color: Provider.of<HomeProvider>(context, listen: false)
                                  .getSelectedView ==
                              "QUICK_ADD"
                          ? white
                          : textGrey),
                ),
              ),
              SizedBox(width: 10.w),
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
                        color: Provider.of<HomeProvider>(context, listen: false)
                                    .getSelectedView ==
                                "QUICK_ADD"
                            ? white
                            : textGrey,
                        size: 14,
                      )
                    : _showImageIcon(
                        'assets/icons/arrow_down.png',
                        color: Provider.of<HomeProvider>(context, listen: false)
                                    .getSelectedView ==
                                "QUICK_ADD"
                            ? white
                            : textGrey,
                        size: 14,
                      ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Provider.of<HomeProvider>(context, listen: false)
                      .setSelectedView("CATEGORY");
                },
                child: Text(
                  EnglishString.category.toUpperCase(),
                  style: semiBoldText(13.sp,
                      color: Provider.of<HomeProvider>(context, listen: false)
                                  .getSelectedView ==
                              "CATEGORY"
                          ? white
                          : textGrey,),
                ),
              ),
              SizedBox(width: 10.w),
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
                        color: Provider.of<HomeProvider>(context, listen: false)
                                    .getSelectedView ==
                                "CATEGORY"
                            ? white
                            : textGrey,
                        size: 14,
                      )
                    : _showImageIcon(
                        'assets/icons/arrow_down.png',
                        color: Provider.of<HomeProvider>(context, listen: false)
                                    .getSelectedView ==
                                "CATEGORY"
                            ? white
                            : textGrey,
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

  ///This function refers the slider and product part
  HomeBody _mainBody(BuildContext context) {
    return HomeBody();
  }

  ///This function refers the footer part
  HomeFooter _footer(BuildContext context) {
    int totalQuantity =
        Provider.of<HomeProvider>(context, listen: true).getProductsLength;
    double totalPrice =
        Provider.of<HomeProvider>(context, listen: true).getTotalPrice;
    double totalDiscount =
        Provider.of<HomeProvider>(context, listen: true).getTotalDiscount;
    return HomeFooter(
      totalPrice: totalPrice,
      totalQuantity: totalQuantity,
      totalDiscount: totalDiscount,
    );
  }

  ///This function refers body part
  Stack _body(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(child: _mainBody(context)),
            _footer(context),
          ],
        ),
        Provider.of<HomeProvider>(context, listen: false).getSearchText == ''
            ? Container()
            : Positioned(
                top: Provider.of<HomeProvider>(context, listen: false)
                        .isSliderCollapsed
                    ? 56.h
                    : 44.h,
                child: Container(
                  width: 326.w,
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
                  child: BlocConsumer<SearchBloc, SearchState>(
                    listener: (context, state) {
                      if (state is SearchConnectionErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No Internet!'),
                          ),
                        );
                      } else if (state is SearchFailureState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.errorString),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is SearchLoadedState) {
                        return SingleChildScrollView(
                          child: state.products.isEmpty
                              ? Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.h),
                                    child: Text(
                                      'No products found!',
                                      style: mediumText(14.sp),
                                    ),
                                  ),
                                )
                              : Column(
                                  children: List.generate(
                                    state.products.length,
                                    (index) => SearchProduct(
                                      product: state.products[index],
                                    ),
                                  ),
                                ),
                        );
                      } else if (state is SearchLoadingState) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const CircularProgressIndicator.adaptive(),
                          ),
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
        resizeToAvoidBottomInset: true,
        floatingActionButton: FloatingActionButton.small(
          backgroundColor: black,
          onPressed: () {
            Provider.of<HomeProvider>(context, listen: false).setShowBottomItem(
                !Provider.of<HomeProvider>(context, listen: false)
                    .isShowedBottomItem);
          },
          child: Provider.of<HomeProvider>(context, listen: false)
                  .isShowedBottomItem
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.remove_red_eye_sharp),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(92.h),
          child: _appbar(context),
        ),
        body: _body(context),
      ),
    );
  }
}
