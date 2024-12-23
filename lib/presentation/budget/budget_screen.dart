import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/presentation/common/my_app_button.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';
import 'package:cost_share/utils/route/route_name.dart';
import 'package:flutter/material.dart';

class BudgetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Assets.icon.svg.iconArrowLeft.svg(),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Assets.icon.svg.iconArrowRight.svg(),
          )
        ],
        backgroundColor: AppColors.colorGreen100,
        centerTitle: true,
        title: Text(
          'May',
          style: AppTextStyles.title3.copyWith(color: AppColors.colorLight100),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.colorGreen100,
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColors.colorLight100,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      // ListView inside an Expanded for proper layout
                      Expanded(
                        child: ListView.builder(
                          itemCount: 100,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Tinh'),
                            );
                          },
                        ),
                      ),
                      // Padding for the button
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 24),
                        child: MyAppButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RouteName.addBudget);
                          },
                          message: "Add Budget",
                          isPrimary: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
