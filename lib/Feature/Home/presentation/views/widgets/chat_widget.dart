import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../generated/assets.dart';
import 'text_widget.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.msg,
    required this.chatIndex,
    this.shouldAnimate = false,
  });

  final String msg;
  final int chatIndex;
  final bool shouldAnimate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: chatIndex == 0 ? 40 : 20,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
            // Wrap Container with IntrinsicWidth
            child: Container(
              decoration: BoxDecoration(
                  color: chatIndex == 0 ? Color(0xff2f2f2f) : Color(0xff272727),
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(
                      width: 8,
                    ),
                    chatIndex == 0
                        ? Padding(
                      padding: const EdgeInsets.only(
                        right: 4.0, top: 2, bottom: 2,),
                      child: TextWidget(
                        label: msg,
                      ),
                    )
                        : shouldAnimate
                        ? DefaultTextStyle(
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                      child: AnimatedTextKit(
                        isRepeatingAnimation: false,
                        repeatForever: false,
                        displayFullTextOnTap: true,
                        totalRepeatCount: 1,
                        animatedTexts: [
                          TyperAnimatedText(
                            msg.trim(),
                          ),
                        ],
                      ),
                    )
                        : Text(
                      msg.trim(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                    chatIndex == 0
                        ? const SizedBox.shrink()
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


////////////////////////////////////////////////////////////////////////////////////////

class ChatWidget2 extends StatelessWidget {
  const ChatWidget2({
    super.key,
    required this.msg,
    required this.chatIndex,
    this.shouldAnimate = false,
  });

  final String msg;
  final int chatIndex;
  final bool shouldAnimate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              // Calculate the text size
              TextPainter textPainter = TextPainter(
                text: TextSpan(
                  text: msg,
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                textDirection: TextDirection.ltr,
                maxLines: 1, // Limit to single line
              )
                ..layout(maxWidth: constraints.maxWidth);

              // Determine if the text width exceeds 50% of screen width
              bool exceedsHalfScreen = textPainter.size.width < MediaQuery
                  .of(context)
                  .size
                  .width * 0.5;

              // Use IntrinsicWidth if necessary
              return exceedsHalfScreen && chatIndex == 0
                  ? Row(mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  IntrinsicWidth(
                    child: Container(
                      decoration: BoxDecoration(
                        color: chatIndex == 0
                            ? const Color(0xff526E04)
                            : const Color(0xff272727),
                        borderRadius: BorderRadius.only(topRight: Radius
                            .circular(8),
                            topLeft: Radius.circular(8),
                            bottomRight: chatIndex == 0
                                ? Radius.circular(0)
                                : Radius.circular(8),
                            bottomLeft: chatIndex == 0
                                ? Radius.circular(8)
                                : Radius.circular(0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextWidget(
                                label: msg,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  : Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Container(
                  decoration: BoxDecoration(
                    color: chatIndex == 0
                        ? const Color(0xff2f2f2f)
                        : const Color(0xff272727),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                        bottomRight: chatIndex == 0
                            ? Radius.circular(0)
                            : Radius.circular(8),
                        bottomLeft: chatIndex == 0 ? Radius.circular(8) : Radius
                            .circular(0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      // mainAxisAlignment: chatIndex == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (chatIndex == 1)

                          const SizedBox(width: 8),
                        chatIndex == 0
                            ? Expanded(
                          child: TextWidget(
                            label: msg,
                          ),
                        )
                            : Expanded(
                          child: shouldAnimate
                              ? DefaultTextStyle(
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                            child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              repeatForever: false,
                              displayFullTextOnTap: true,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TyperAnimatedText(
                                  msg.trim(),
                                ),
                              ],
                            ),
                          )
                              : Text(
                            msg.trim(),
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        if (chatIndex == 0)
                          const SizedBox.shrink()
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              SizedBox(width: 5),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final String label;

  const TextWidget({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Text(
        label,
        style: GoogleFonts.cairo(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    );
  }
}
