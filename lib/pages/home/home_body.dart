import 'package:dorkar/controller/blocs/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/colors.dart';
import '../../config/strings.dart';
import '../../config/text_styles.dart';
import '../../controller/blocs/category_search/category_search_bloc.dart';
import '../../controller/blocs/home/home_bloc.dart';
import '../../controller/providers/home_provider.dart';
import 'home_product.dart';
import 'home_slider.dart';
import 'home_slider_category_item.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  ///This function refers the title
  Text _titleText(String title) {
    return Text(
      title.toUpperCase(),
      style: boldText(12.sp),
    );
  }

  BlocConsumer<HomeBloc, HomeState> _sliderWithCategory() {
    return BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
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
        return HomeSlider(
          pageWiseCategoryItem: state.pageWiseCategoryItem,
          pageWiseProductItem: state.pageWiseProductItem,
        );
      }
      return Container();
    });
  }

  BlocConsumer<CategorySearchBloc, CategorySearchState>
      _sliderWithCategoryItem() {
    return BlocConsumer<CategorySearchBloc, CategorySearchState>(
        listener: (context, state) {
      if (state is CategorySearchConnectionErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No Internet!'),
          ),
        );
      } else if (state is CategorySearchFailureState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorString),
          ),
        );
      }
    }, builder: (context, state) {
      if (state is CategorySearchLoadingState) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      } else if (state is CategorySearchLoadedState) {
        return state.productPerPageList.isEmpty
            ? Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Text(
                    'No products found!',
                    style: mediumText(14.sp),
                  ),
                ),
              )
            : HomeCategoryItemSlider(
                pageWiseSearchProductItem: state.productPerPageList,
              );
      }
      return Container();
    });
  }

  Column _sliderPortion(BuildContext context) {
    return Column(
      children: [
        //===========This portion contains the slider============
        //-------------------------------------------------------
        (Provider.of<HomeProvider>(context, listen: true).isSliderCollapsed) &&
                (Provider.of<HomeProvider>(context, listen: true)
                        .getSearchText ==
                    '')
            ? (Provider.of<HomeProvider>(context, listen: true)
                        .getCategoryItemName ==
                    '')
                ? _sliderWithCategory()
                : _sliderWithCategoryItem()
            : Container(),
        Provider.of<HomeProvider>(context, listen: true).isSliderCollapsed
            ? SizedBox(height: 12.h)
            : const SizedBox.shrink(),
      ],
    );
  }

  Container _sliverAppbar(BuildContext context) {
    return Container(
      color: white,
      child: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
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
                          if (v == '') {
                            FocusScopeNode currentScope =
                                FocusScope.of(context);
                            if (!currentScope.hasPrimaryFocus &&
                                currentScope.hasFocus) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            }
                          }
                          context.read<SearchBloc>().add(SearchProductEvent(v));
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
        ],
      ),
    );
  }

  Container _productPart(BuildContext context) {
    return Container(
      color: white,
      child: Column(
        children: [
          SizedBox(height: 20.h),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: _sliderPortion(context),
        ),
        SliverAppBar(
          titleSpacing: 0,
          backgroundColor: white,
          elevation: 0,
          primary: false,
          pinned: true,
          title: _sliverAppbar(context),
        ),
        SliverToBoxAdapter(
          child: _productPart(context),
        ),
      ],
    );
  }
}
