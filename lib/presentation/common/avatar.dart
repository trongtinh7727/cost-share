import 'package:cost_share/gen/assets.gen.dart';
import 'package:cost_share/utils/app_colors.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    this.url = "https://i.pravatar.cc/150?img=32",
    this.border = 2.0,
    this.add = false,
    this.remove = false,
    this.borderRadius = 16.0,
    this.size = 32.0,
    this.padding = 0,
    this.onTap,
  }) : super(key: key);

  final String url;
  final double border;
  final double borderRadius;
  final double size;
  final bool add;
  final bool remove;
  final VoidCallback? onTap;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding),
        width: size + padding * 2,
        height: size + padding * 2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Border and Avatar Image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: border > 0
                    ? Border.all(
                        color: AppColors.colorViolet100,
                        width: border,
                      )
                    : null,
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius - border / 2),
                  child: Image.network(
                    url,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
      
            if (add)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                alignment: Alignment.center,
                child: Assets.icon.svg.iconAdd.svg(
                  width: size * 0.4,
                  height: size * 0.4,
                  colorFilter: ColorFilter.mode(
                    AppColors.colorDark25,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            if (remove)
              Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  alignment: Alignment.center,
                  child: SizedBox()),
            if (remove)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorLight40,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  alignment: Alignment.center,
                  child: Assets.icon.svg.iconClose.svg(
                    width: size * 0.4,
                    height: size * 0.4,
                    colorFilter: ColorFilter.mode(
                      AppColors.colorDark25,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
