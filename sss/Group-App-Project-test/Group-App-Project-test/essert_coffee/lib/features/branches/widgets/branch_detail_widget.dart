import 'package:essert_coffee/style/style_color.dart';
import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/utilities/extensions/screens/get_size_screen.dart';
import 'package:flutter/material.dart';

/// A widget that displays details of a branch including its name,
/// distance from the user, and a customizable card color.
class BranchDetailWidget extends StatelessWidget {
  /// The display name of the branch.
  final String branchName;

  /// Distance to the branch in kilometers.
  final int branchDistance;

  /// Background color of the card.
  final Color cardColor;
  const BranchDetailWidget({
    super.key,
    required this.branchName,
    required this.branchDistance,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(),
      height: context.getHeight() * 0.15,
      child: Card(
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(branchName, style: StyleText.bold16),
              Row(
                children: [
                  Icon(Icons.location_on, color: StyleColor.black),
                  Text('$branchDistance Km', style: StyleText.bold16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
