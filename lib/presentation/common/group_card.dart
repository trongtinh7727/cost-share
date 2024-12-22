// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cost_share/model/group_detail.dart';
import 'package:flutter/material.dart';

import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/presentation/common/avatar.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:cost_share/utils/app_textstyle.dart';

enum CardState { active, addNew, inactive }

class GroupCard extends StatelessWidget {
  const GroupCard({
    Key? key,
    this.groupDetail,
    this.onTap,
    required this.cardState,
  }) : super(key: key);

  final GroupDetail? groupDetail;
  final CardState cardState;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Widget trailingWidget;

    switch (cardState) {
      case CardState.active:
        backgroundColor = AppColors.colorViolet40; // Light purple
        trailingWidget = Assets.icon.svg.iconSettings.svg();
        break;
      case CardState.addNew:
        backgroundColor = AppColors.colorViolet20; // Lightest purple
        trailingWidget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.colorBlue100, width: 2),
              ),
              child: Icon(Icons.add, color: AppColors.colorBlue100),
            ),
            const SizedBox(width: 8.0),
            Text(
              'Add new',
              style: AppTextStyles.body2.copyWith(
                color: AppColors.colorBlue100,
              ),
            )
          ],
        );
        break;
      case CardState.inactive:
        backgroundColor = AppColors.colorLight100; // White
        trailingWidget = const SizedBox.shrink();
        break;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
          16), // Ensure ripple effect respects border radius
      child: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (cardState != CardState.addNew)
              Expanded(
                child: Row(
                  children: [
                    Avatar(
                        url: groupDetail!.groupPhoto,
                        size: 50,
                        border: 0), // Custom avatar
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          groupDetail!.groupName,
                          style: AppTextStyles.body1.copyWith(
                            color: AppColors.colorDark100,
                          ),
                        ),
                        Text(
                          '${groupDetail!.memberCount} Member',
                          style: AppTextStyles.small.copyWith(
                            color: AppColors.colorBlue100,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Avatar(
                                url: groupDetail!.authorPhoto,
                                size: 16,
                                border: 0), // Smaller avatar
                            const SizedBox(width: 4),
                            Text(
                              groupDetail!.authorName,
                              style: AppTextStyles.small.copyWith(
                                color: AppColors.colorDark50,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            trailingWidget,
          ],
        ),
      ),
    );
  }
}
