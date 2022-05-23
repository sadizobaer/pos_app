import 'package:flutter/material.dart';
import '../config/colors.dart';
import '../config/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownSelection extends StatelessWidget {
  final String? initialItem;
  DropdownSelection({Key? key, this.initialItem}) : super(key: key);

  String? _currentItemSelected;
  final List<String> dropdownButtons = ['No data available'];

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return PopupMenuButton<String>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            itemBuilder: (context) {
              return dropdownButtons.map((str) {
                return PopupMenuItem(
                  value: str,
                  child: Text(
                    str,
                    style: mediumText(
                      12.sp,
                      color: textGrey,
                    ),
                  ),
                );
              }).toList();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _currentItemSelected ?? initialItem!,
                  style: mediumText(
                    10.sp,
                    color: textGrey,
                  ),
                ),
                const ImageIcon(
                  AssetImage('assets/icons/arrow_down.png'),
                  size: 14,
                  color: textGrey,
                ),
              ],
            ),
            onSelected: (v) {
              _currentItemSelected = v;
            },
          );
        });
  }
}
