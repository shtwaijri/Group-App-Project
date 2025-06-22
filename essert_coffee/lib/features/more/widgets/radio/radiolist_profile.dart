import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/utilities/extensions/screens/get_size_screen.dart';
import 'package:flutter/material.dart';

/// A customizable radio button widget designed for edit profile screen.
///
/// This widget allows users to select a specific option, commonly used for
/// gender selection or other mutually exclusive choices. It displays
/// a radio button alongside a descriptive text (e.g., "Male", "Female").


class RadiotProfile extends StatelessWidget {
  const RadiotProfile({  
    super.key,
    required this.gender, 
    required this.value,  
    required this.groupValue, 
    required this.onChanged, 
  });

  final String gender;
  final String value;
  final String groupValue;
  final void Function(String?) onChanged;  

  @override
  Widget build(BuildContext context) {
    return SizedBox(  
      height: context.getHeight()*.05,
      width: context.getWidth()*.46,
     
      child: Row( 
        mainAxisAlignment: MainAxisAlignment.start,  
        children: [
          Radio<String>(
            activeColor: const Color(0xFF84C5B1),
            fillColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return const Color(0xFF84C5B1);
                }
                return const Color(0xFFC8E6C9);  
              },
            ),
            value: value,  
            groupValue: groupValue, 
            onChanged: onChanged,  
          ),
          Text(
            gender,
            style:StyleText.bold16
          ),
        ],
      ),
    );
  }
}