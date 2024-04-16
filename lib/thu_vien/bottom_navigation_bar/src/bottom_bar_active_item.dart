import 'package:flutter/material.dart';
import 'package:learn_flutter/thu_vien/bottom_navigation_bar/src/constants/constants.dart';

class BottomBarActiveItem extends StatelessWidget {
  const BottomBarActiveItem(
    this.index, {
    required this.itemWidget,
    required this.onTap,
    required this.scrollPosition,
    required this.kIconSize,
    required this.showLabel,
    this.label,
    this.labelStyle,
  });

  /// item index
  final int index;

  /// String to indicate the label item
  final String? label;

  /// Value to indicate the label Style
  final TextStyle? labelStyle;

  /// Boolean to show the item label
  final bool showLabel;

  final double kIconSize;

  /// item
  final Widget itemWidget;

  /// Double value to indicate the item position
  final double scrollPosition;

  /// Function called when an item was tapped
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final icon = itemWidget;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: SizedBox.fromSize(
              size: Size(kIconSize, kIconSize),
              child: Opacity(
                  opacity: kPi * 2 * (scrollPosition % 1) == 0 ? 1 : 0,
                  child: icon),
            ),
            onTap: () => onTap(index),
          ),
          if (label != null && showLabel) ...[
            const SizedBox(height: 35.0),
            Text(
              label!,
              style: labelStyle ??
                  TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
            ),
          ],
        ],
      ),
      // ],
    );
  }
}
