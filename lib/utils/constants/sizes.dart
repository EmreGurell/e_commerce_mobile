enum ProjectBorderRadius { ButtonRadius, ImageAndCardRadius, InputFieldRadius }

extension ProjectBorderRadiusExtension on ProjectBorderRadius {
  double value() {
    switch (this) {
      case ProjectBorderRadius.ButtonRadius:
        return 5.0;
      case ProjectBorderRadius.ImageAndCardRadius:
        return 10.0;
      case ProjectBorderRadius.InputFieldRadius:
        return 5.0;
    }
  }
}

enum ProjectPadding { pagePadding, topPadding, appBarPadding }

extension ProjectPaddingExtension on ProjectPadding {
  double value() {
    switch (this) {
      case ProjectPadding.pagePadding:
        return 16.0;
      case ProjectPadding.topPadding:
        return 10.0;
      case ProjectPadding.appBarPadding:
        return 56.0;
    }
  }
}

enum ProjectFontSizes { fontSizeSmall, fontSizeMedium, fontSizeLarge }

extension ProjectFontSizesExtension on ProjectFontSizes {
  double value() {
    switch (this) {
      case ProjectFontSizes.fontSizeSmall:
        return 14.0;
      case ProjectFontSizes.fontSizeMedium:
        return 16.0;
      case ProjectFontSizes.fontSizeLarge:
        return 18.0;
    }
  }
}

class ProjectSizes {
  static const spaceBtwItems = 16.0;
  static const small = 8.0;
  static const md = 12.0;

  static const pagePadding = 16.0;
  static const IconXS = 12.0;
  static const IconS = 16.0;
  static const IconM = 24.0;
  static const IconL = 32.0;
  static const imageAndCardRadius = 10.0;
  static const lg = 18.0;
}
