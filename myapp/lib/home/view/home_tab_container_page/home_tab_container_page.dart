import 'package:myapp/widgets/app_bar/custom_app_bar.dart';
import 'package:myapp/widgets/app_bar/appbar_title_searchview.dart';
import 'widgets/carousel_item_widget.dart';
import 'package:myapp/home/view/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/app_export.dart';
import 'package:myapp/UniversityInfo/view/uiinfo_screen.dart';

// ignore_for_file: must_be_immutable
class HomeTabContainerPage extends StatefulWidget {
  const HomeTabContainerPage({Key? key})
      : super(
          key: key,
        );

  @override
  HomeTabContainerPageState createState() => HomeTabContainerPageState();
}

class HomeTabContainerPageState extends State<HomeTabContainerPage>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 40.v),
            child: Column(
              children: [
                _buildArchiveCoun(context),
                SizedBox(height: 26.v),
                _buildCarousel(context),
                SizedBox(height: 28.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Text(
                      "Top Universities! ",
                      style: CustomTextStyles.titleSmallPoppins,
                    ),
                  ),
                ),
                SizedBox(height: 6.v),
                _buildTabview(context),
                _buildTabBarView(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarTitleSearchview(
        hintText: "Find your exchange",
        controller: searchController,
      ),
    );
  }

  /// Section Widget
  Widget _buildArchiveCoun(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 22.h,
        right: 16.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgLinkedin,
            height: 28.v,
            width: 23.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 7.h,
              top: 4.v,
              bottom: 5.v,
            ),
            child: Text(
              "Countries",
              style: theme.textTheme.labelLarge,
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.v),
            child: Text(
              "See all",
              style: CustomTextStyles.labelMediumOrange700,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCarousel(BuildContext context) {
    return SizedBox(
      height: 210.v,
      child: ListView.separated(
        padding: EdgeInsets.only(
          left: 10.h,
          right: 16.h,
        ),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            width: 8.h,
          );
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return CarouselItemWidget();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildTabview(BuildContext context) {
    return Container(
      height: 18.v,
      width: 379.h,
      child: TabBar(
        controller: tabviewController,
        labelPadding: EdgeInsets.zero,
        labelColor: appTheme.orange700,
        unselectedLabelColor: appTheme.black900,
        tabs: [
          Tab(
            child: Text(
              "All",
            ),
          ),
          Tab(
            child: Text(
              "Popular",
            ),
          ),
          Tab(
            child: Text(
              "Recom",
            ),
          ),
          Tab(
            child: Text(
              "Viewed",
            ),
          ),
          Tab(
            child: Text(
              "Fav",
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTabBarView(BuildContext context) {
    return SizedBox(
      height: 275.v,
      child: TabBarView(
        controller: tabviewController,
        children: [
          HomePage(),
        ],
      ),
    );
  }
}
