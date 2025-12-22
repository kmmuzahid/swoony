import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:swoony/core/utils/extensions/extension.dart';

abstract class CommonRichTextContent {}


class CommonRichTextSpan extends CommonRichTextContent {
  CommonRichTextSpan({required this.textSpan});
  final TextSpan textSpan;
}

class CommonSimpleRichTextContent extends CommonRichTextContent {
  CommonSimpleRichTextContent({required this.text, this.style, this.ontap});
  final Function()? ontap;
  final String text;
  final TextStyle? style;
}

/// Author: Km Muzahid
/// Email: km.muzahid@gmail.com
/// Date: 2025-12-22
/// Version: 1.0.0
/// Description: Common rich text widget for the app
class CommonRichText extends StatelessWidget {
  ///usage:
  ///richTextContent: [CommonSimpleRichTextContent(text: '', style: TextStyle, ontap: (){}),
  ///CommonRichTextSpan(textSpan : TextSpan() , ontap: (){})]
  const CommonRichText({required this.richTextContent, super.key});
  final List<CommonRichTextContent> richTextContent;

  @override
  Widget build(BuildContext context) {
    return _content();
  }

  Widget _content() {
    return Text.rich(
      TextSpan(
        children: List.generate(richTextContent.length, (index) {
          final rContent = richTextContent[index];

          if (rContent is CommonSimpleRichTextContent) {
            final style = rContent.style ?? getTheme.textTheme.bodyMedium!;
            return TextSpan(
              text: rContent.text,
              style: style,
              recognizer: rContent.ontap == null
                  ? null
                  : (TapGestureRecognizer()..onTap = rContent.ontap),
            );
          } else if (rContent is CommonRichTextSpan) {
            return rContent.textSpan;
          } else {
            return const TextSpan(text: '');
          }
        }),
      ),
      softWrap: true,
      overflow: TextOverflow.visible,
      textAlign: TextAlign.start,
    );
  }
}
