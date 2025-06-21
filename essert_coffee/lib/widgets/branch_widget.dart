import 'package:essert_coffee/style/style_color.dart';
import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/utilities/extensions/screens/get_size_screen.dart';
import 'package:flutter/material.dart';

/// A widget that displays the currently selected pickup branch including title
/// and a row with a location icon and the branch name.
class BranchWidget extends StatelessWidget {
  /// The name of the selected branch.
  final String branch;
  const BranchWidget({super.key, required this.branch});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(),
      height: context.getHeight() * 0.09,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Pick Up From', style: StyleText.bold16),
              Row(
                children: [
                  Icon(Icons.location_on, color: StyleColor.teal),
                  Text(branch, style: StyleText.bold16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
