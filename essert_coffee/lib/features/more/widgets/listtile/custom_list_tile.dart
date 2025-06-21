 
import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/utilities/extensions/screens/get_size_screen.dart';
import 'package:flutter/material.dart';

/// A customizable list tile widget  used in "More" screen.
///
/// This widget provides a flexible list item with a leading icon or a custom widget (e.g., a country flag),
/// a title, and a trailing arrow icon that triggers an onPressed action.
/// It's ideal for navigation options or displaying simple information rows.
class CustomListTile extends StatelessWidget {
   const CustomListTile({
    super.key,
    required this.onPressed,
    required this.title,
    required this.icon,

    required this.height,
    this.isCoutrty = false,

    this.contry
  });
  final Function()? onPressed;
  final String title;
  final IconData icon;
  final double height;
  final bool isCoutrty;
  final Widget? contry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(),
      height: height,
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(top:  context.getHeight()*.008),
            leading: !isCoutrty ?Icon(icon, size: context.getWidth()*.09,):contry,
            title: Text( title, style: StyleText.bold24),
            trailing: IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.arrow_forward_ios),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
