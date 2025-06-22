 
import 'package:essert_coffee/features/more/widgets/sizebox/country_sizebox.dart';
import 'package:essert_coffee/style/style_color.dart';
import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/utilities/extensions/screens/get_size_screen.dart';
import 'package:flutter/material.dart';

/// A customizable ListTile widget designed to display country information.
///
/// This widget is typically used in a list to represent a country,
/// featuring a flag image, a country name, and an optional tap action.
/// It has a rounded background with a customizable border color.

class CountryListtile extends StatelessWidget {
  const CountryListtile({
    super.key,
    this.onTap,
    required this.title,
    required this.imagePath, required this.color,
      
  });
  final Function()? onTap;
  final String title;
  final String imagePath;
   final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: context.getWidth()*.03,right: context.getWidth()*.03,top: context.getWidth()*.03),
      width: context.getWidth(),
      height: context.getHeight() * .08,
      decoration: BoxDecoration(
        color:StyleColor.floralWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color,width: 1)
      ),
      child: ListTile(
        onTap: onTap,
        title: Text( title, style: StyleText.bold24,),
        leading: CountrySizebox(imagePath: imagePath),
      ),
    );
  }
}
