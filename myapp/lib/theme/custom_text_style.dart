import 'package:flutter/material.dart';
import 'package:myapp/core/utils/size_utils.dart';
import 'package:myapp/theme/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeInterGray90001 =>
      theme.textTheme.bodyLarge!.inter.copyWith(
        color: appTheme.gray90001,
      );
  static get bodyLargeInterWhiteA700 =>
      theme.textTheme.bodyLarge!.inter.copyWith(
        color: appTheme.whiteA700,
      );
  static get bodyLargePoppinsGray800 =>
      theme.textTheme.bodyLarge!.poppins.copyWith(
        color: appTheme.gray800,
      );
  static get bodyLargePoppinsGray900 =>
      theme.textTheme.bodyLarge!.poppins.copyWith(
        color: appTheme.gray900,
      );
  static get bodyLargeQuattrocentoSans =>
      theme.textTheme.bodyLarge!.quattrocentoSans;
  static get bodyMediumGray60001 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray60001,
      );
  static get bodyMediumInterBluegray600 =>
      theme.textTheme.bodyMedium!.inter.copyWith(
        color: appTheme.blueGray600,
        fontSize: 14.fSize,
      );
  static get bodyMediumLight => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w300,
      );
  static get bodySmallBlack900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallGray900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray900,
        fontSize: 10.fSize,
      );
  static get bodySmallRobotoBlack900 =>
      theme.textTheme.bodySmall!.roboto.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallRobotoBlack900Regular =>
      theme.textTheme.bodySmall!.roboto.copyWith(
        color: appTheme.black900,
        fontSize: 11.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallRobotoGray600 =>
      theme.textTheme.bodySmall!.roboto.copyWith(
        color: appTheme.gray600,
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
      );
  static get bodySmallff000000 => theme.textTheme.bodySmall!.copyWith(
        color: Color(0XFF000000),
        fontWeight: FontWeight.w400,
      );
  static get bodySmallff4b4949 => theme.textTheme.bodySmall!.copyWith(
        color: Color(0XFF4B4949),
        fontWeight: FontWeight.w400,
      );
  // Headline text style
  static get headlineSmallInterGray90001 =>
      theme.textTheme.headlineSmall!.inter.copyWith(
        color: appTheme.gray90001,
        fontWeight: FontWeight.w500,
      );
  static get headlineSmallRobotoOnPrimary =>
      theme.textTheme.headlineSmall!.roboto.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  // Label text style
  static get labelLargeRobotoBluegray900 =>
      theme.textTheme.labelLarge!.roboto.copyWith(
        color: appTheme.blueGray900,
        fontWeight: FontWeight.w700,
      );
  static get labelMediumOrange700 => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.orange700,
      );
  static get labelMediumOrange7004c => theme.textTheme.labelMedium!.copyWith(
        color: appTheme.orange7004c.withOpacity(0.92),
      );
  // Title text style
  static get titleLargeGray5001 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.gray5001,
      );
  static get titleLargeSemiBold => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static get titleMediumInterGray500 =>
      theme.textTheme.titleMedium!.inter.copyWith(
        color: appTheme.gray500,
        fontSize: 16.fSize,
      );
  static get titleMediumOnPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumRobotoDeeporangeA200 =>
      theme.textTheme.titleMedium!.roboto.copyWith(
        color: appTheme.deepOrangeA200,
        fontSize: 16.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 16.fSize,
      );
  static get titleSmallBluegray400 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray400,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallDeeporangeA200 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.deepOrangeA200,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallInterPrimaryContainer =>
      theme.textTheme.titleSmall!.inter.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallInterff156cf7 =>
      theme.textTheme.titleSmall!.inter.copyWith(
        color: Color(0XFF156CF7),
        fontWeight: FontWeight.w600,
      );
  static get titleSmallInterff282a37 =>
      theme.textTheme.titleSmall!.inter.copyWith(
        color: Color(0XFF282A37),
        fontWeight: FontWeight.w600,
      );
  static get titleSmallPoppins => theme.textTheme.titleSmall!.poppins.copyWith(
        fontSize: 15.fSize,
      );
  static get titleSmallWhiteA700 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w500,
      );
}

extension on TextStyle {
  TextStyle get roboto {
    return copyWith(
      fontFamily: 'Roboto',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get quattrocentoSans {
    return copyWith(
      fontFamily: 'Quattrocento Sans',
    );
  }
}
