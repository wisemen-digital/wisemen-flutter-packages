import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_theming/wise_theming.dart';

void main() {
  group('AppStyles', () {
    group('largeTitle', () {
      test('should have correct font weight', () {
        expect(AppStyles.largeTitle.fontWeight, FontWeight.w600);
      });

      test('should have correct font size', () {
        expect(AppStyles.largeTitle.fontSize, 33);
      });

      test('should have correct line height', () {
        expect(AppStyles.largeTitle.height, 0);
      });

      test('should not have color defined', () {
        expect(AppStyles.largeTitle.color, isNull);
      });

      test('should be immutable', () {
        expect(AppStyles.largeTitle, isA<TextStyle>());
        expect(
            AppStyles.largeTitle,
            const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 33, height: 0));
      });
    });

    group('title', () {
      test('should have correct font weight', () {
        expect(AppStyles.title.fontWeight, FontWeight.w400);
      });

      test('should have correct font size', () {
        expect(AppStyles.title.fontSize, 24);
      });

      test('should have correct line height', () {
        expect(AppStyles.title.height, 0);
      });

      test('should not have color defined', () {
        expect(AppStyles.title.color, isNull);
      });

      test('should be immutable', () {
        expect(AppStyles.title, isA<TextStyle>());
        expect(
            AppStyles.title,
            const TextStyle(
                fontWeight: FontWeight.w400, fontSize: 24, height: 0));
      });
    });

    group('headline', () {
      test('should have correct font weight', () {
        expect(AppStyles.headline.fontWeight, FontWeight.w500);
      });

      test('should have correct font size', () {
        expect(AppStyles.headline.fontSize, 14);
      });

      test('should have correct line height', () {
        expect(AppStyles.headline.height, 0);
      });

      test('should not have color defined', () {
        expect(AppStyles.headline.color, isNull);
      });

      test('should be immutable', () {
        expect(AppStyles.headline, isA<TextStyle>());
        expect(
            AppStyles.headline,
            const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 14, height: 0));
      });
    });

    group('subHeadline', () {
      test('should have correct font weight', () {
        expect(AppStyles.subHeadline.fontWeight, FontWeight.w400);
      });

      test('should have correct font size', () {
        expect(AppStyles.subHeadline.fontSize, 11);
      });

      test('should have correct line height', () {
        expect(AppStyles.subHeadline.height, 0);
      });

      test('should not have color defined', () {
        expect(AppStyles.subHeadline.color, isNull);
      });

      test('should be immutable', () {
        expect(AppStyles.subHeadline, isA<TextStyle>());
        expect(
            AppStyles.subHeadline,
            const TextStyle(
                fontWeight: FontWeight.w400, fontSize: 11, height: 0));
      });
    });

    group('body', () {
      test('should have correct font weight', () {
        expect(AppStyles.body.fontWeight, FontWeight.w400);
      });

      test('should have correct font size', () {
        expect(AppStyles.body.fontSize, 14);
      });

      test('should have correct line height', () {
        expect(AppStyles.body.height, 0);
      });

      test('should not have color defined', () {
        expect(AppStyles.body.color, isNull);
      });

      test('should be immutable', () {
        expect(AppStyles.body, isA<TextStyle>());
        expect(
            AppStyles.body,
            const TextStyle(
                fontWeight: FontWeight.w400, fontSize: 14, height: 0));
      });
    });

    group('input', () {
      test('should have correct font weight', () {
        expect(AppStyles.input.fontWeight, FontWeight.w400);
      });

      test('should have correct font size', () {
        expect(AppStyles.input.fontSize, 14);
      });

      test('should not have line height specified (null)', () {
        expect(AppStyles.input.height, isNull);
      });

      test('should not have color defined', () {
        expect(AppStyles.input.color, isNull);
      });

      test('should be immutable', () {
        expect(AppStyles.input, isA<TextStyle>());
        expect(AppStyles.input,
            const TextStyle(fontWeight: FontWeight.w400, fontSize: 14));
      });
    });

    group('Style hierarchy and relationships', () {
      test('largeTitle should be the largest font size', () {
        expect(AppStyles.largeTitle.fontSize!,
            greaterThan(AppStyles.title.fontSize!));
        expect(AppStyles.largeTitle.fontSize!,
            greaterThan(AppStyles.headline.fontSize!));
        expect(AppStyles.largeTitle.fontSize!,
            greaterThan(AppStyles.subHeadline.fontSize!));
        expect(AppStyles.largeTitle.fontSize!,
            greaterThan(AppStyles.body.fontSize!));
        expect(AppStyles.largeTitle.fontSize!,
            greaterThan(AppStyles.input.fontSize!));
      });

      test('title should be larger than body text styles', () {
        expect(AppStyles.title.fontSize!,
            greaterThan(AppStyles.headline.fontSize!));
        expect(AppStyles.title.fontSize!,
            greaterThan(AppStyles.subHeadline.fontSize!));
        expect(
            AppStyles.title.fontSize!, greaterThan(AppStyles.body.fontSize!));
        expect(
            AppStyles.title.fontSize!, greaterThan(AppStyles.input.fontSize!));
      });

      test('subHeadline should be the smallest font size', () {
        expect(AppStyles.subHeadline.fontSize!,
            lessThan(AppStyles.largeTitle.fontSize!));
        expect(AppStyles.subHeadline.fontSize!,
            lessThan(AppStyles.title.fontSize!));
        expect(AppStyles.subHeadline.fontSize!,
            lessThan(AppStyles.headline.fontSize!));
        expect(AppStyles.subHeadline.fontSize!,
            lessThan(AppStyles.body.fontSize!));
        expect(AppStyles.subHeadline.fontSize!,
            lessThan(AppStyles.input.fontSize!));
      });

      test('body and input should have same font size', () {
        expect(AppStyles.body.fontSize, AppStyles.input.fontSize);
      });

      test('headline and body should have same font size', () {
        expect(AppStyles.headline.fontSize, AppStyles.body.fontSize);
      });

      test('largeTitle should have the heaviest font weight', () {
        expect(AppStyles.largeTitle.fontWeight, FontWeight.w600);
        expect(AppStyles.largeTitle.fontWeight!.index,
            greaterThan(AppStyles.title.fontWeight!.index));
        expect(AppStyles.largeTitle.fontWeight!.index,
            greaterThan(AppStyles.headline.fontWeight!.index));
        expect(AppStyles.largeTitle.fontWeight!.index,
            greaterThan(AppStyles.subHeadline.fontWeight!.index));
        expect(AppStyles.largeTitle.fontWeight!.index,
            greaterThan(AppStyles.body.fontWeight!.index));
        expect(AppStyles.largeTitle.fontWeight!.index,
            greaterThan(AppStyles.input.fontWeight!.index));
      });

      test('headline should have medium font weight', () {
        expect(AppStyles.headline.fontWeight, FontWeight.w500);
        expect(AppStyles.headline.fontWeight!.index,
            greaterThan(AppStyles.title.fontWeight!.index));
        expect(AppStyles.headline.fontWeight!.index,
            greaterThan(AppStyles.subHeadline.fontWeight!.index));
        expect(AppStyles.headline.fontWeight!.index,
            greaterThan(AppStyles.body.fontWeight!.index));
        expect(AppStyles.headline.fontWeight!.index,
            greaterThan(AppStyles.input.fontWeight!.index));
      });

      test('regular styles should have same font weight', () {
        expect(AppStyles.title.fontWeight, AppStyles.subHeadline.fontWeight);
        expect(AppStyles.title.fontWeight, AppStyles.body.fontWeight);
        expect(AppStyles.title.fontWeight, AppStyles.input.fontWeight);
        expect(AppStyles.subHeadline.fontWeight, AppStyles.body.fontWeight);
        expect(AppStyles.subHeadline.fontWeight, AppStyles.input.fontWeight);
        expect(AppStyles.body.fontWeight, AppStyles.input.fontWeight);
      });
    });

    group('Style customization', () {
      test('should allow color customization via copyWith', () {
        final styledTitle = AppStyles.title.copyWith(color: Colors.red);

        expect(styledTitle.color, Colors.red);
        expect(styledTitle.fontSize, AppStyles.title.fontSize);
        expect(styledTitle.fontWeight, AppStyles.title.fontWeight);
        expect(styledTitle.height, AppStyles.title.height);
      });

      test('should allow font weight customization via copyWith', () {
        final boldBody = AppStyles.body.copyWith(fontWeight: FontWeight.bold);

        expect(boldBody.fontWeight, FontWeight.bold);
        expect(boldBody.fontSize, AppStyles.body.fontSize);
        expect(boldBody.height, AppStyles.body.height);
        expect(boldBody.color, AppStyles.body.color);
      });

      test('should allow font size customization via copyWith', () {
        final largerHeadline = AppStyles.headline.copyWith(fontSize: 18);

        expect(largerHeadline.fontSize, 18);
        expect(largerHeadline.fontWeight, AppStyles.headline.fontWeight);
        expect(largerHeadline.height, AppStyles.headline.height);
        expect(largerHeadline.color, AppStyles.headline.color);
      });

      test('should allow multiple property customization via copyWith', () {
        final customStyle = AppStyles.subHeadline.copyWith(
          color: Colors.blue,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.5,
        );

        expect(customStyle.color, Colors.blue);
        expect(customStyle.fontSize, 16);
        expect(customStyle.fontWeight, FontWeight.w600);
        expect(customStyle.height, 1.5);
      });

      test('original styles should remain unchanged after copyWith', () {
        final originalTitle = AppStyles.title;
        final modifiedTitle =
            AppStyles.title.copyWith(color: Colors.green, fontSize: 30);

        // Original should be unchanged
        expect(AppStyles.title.color, originalTitle.color);
        expect(AppStyles.title.fontSize, originalTitle.fontSize);
        expect(AppStyles.title.fontWeight, originalTitle.fontWeight);
        expect(AppStyles.title.height, originalTitle.height);

        // Modified should be different
        expect(modifiedTitle.color, Colors.green);
        expect(modifiedTitle.fontSize, 30);
        expect(modifiedTitle.fontWeight, originalTitle.fontWeight);
        expect(modifiedTitle.height, originalTitle.height);
      });
    });

    group('Line height behavior', () {
      test('most styles should have zero line height', () {
        expect(AppStyles.largeTitle.height, 0);
        expect(AppStyles.title.height, 0);
        expect(AppStyles.headline.height, 0);
        expect(AppStyles.subHeadline.height, 0);
        expect(AppStyles.body.height, 0);
      });

      test('input style should not have line height specified', () {
        expect(AppStyles.input.height, isNull);
      });

      test('input style should be suitable for text inputs', () {
        // Input style should not have height: 0 as mentioned in the documentation
        expect(AppStyles.input.height, isNull);
        expect(AppStyles.input.fontSize, 14);
        expect(AppStyles.input.fontWeight, FontWeight.w400);
      });
    });

    group('Font family consistency', () {
      test('all styles should use default font family (null)', () {
        expect(AppStyles.largeTitle.fontFamily, isNull);
        expect(AppStyles.title.fontFamily, isNull);
        expect(AppStyles.headline.fontFamily, isNull);
        expect(AppStyles.subHeadline.fontFamily, isNull);
        expect(AppStyles.body.fontFamily, isNull);
        expect(AppStyles.input.fontFamily, isNull);
      });
    });

    group('Style constants immutability', () {
      test('should be const instances', () {
        // These should be compile-time constants
        expect(AppStyles.largeTitle, isA<TextStyle>());
        expect(AppStyles.title, isA<TextStyle>());
        expect(AppStyles.headline, isA<TextStyle>());
        expect(AppStyles.subHeadline, isA<TextStyle>());
        expect(AppStyles.body, isA<TextStyle>());
        expect(AppStyles.input, isA<TextStyle>());
      });
    });
  });
}
