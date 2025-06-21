import 'package:essert_coffee/features/branches/bloc/branch_bloc.dart';
import 'package:essert_coffee/features/branches/widgets/branch_detail_widget.dart';
import 'package:essert_coffee/models/branch_model.dart';
import 'package:essert_coffee/style/style_text.dart';
import 'package:essert_coffee/widgets/branch_widget.dart';
import 'package:essert_coffee/style/style_color.dart';
import 'package:essert_coffee/style/style_size.dart';
import 'package:essert_coffee/utilities/extensions/screens/get_size_screen.dart';
import 'package:essert_coffee/widgets/buttom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// A stateless widget that displays a map with branch markers,
/// user location, and a list of nearby branches.
///
/// This screen uses [BranchBloc] to manage user location and branch selection.
/// It shows a [GoogleMap] widget with tappable markers, and a scrollable list of branch details.
class BranchesScreen extends StatelessWidget {
  const BranchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the BranchBloc for state management.
    return BlocProvider(
      create: (context) => BranchBloc(),
      child: Builder(
        builder: (context) {
          final bloc = context.read<BranchBloc>();
          // Trigger fetching of the user's current location.
          bloc.add(CurrentLocationEvent());
          // Create a set of markers from branch data.
          final Set<Marker> markers = branches.map((branch) {
            return Marker(
              markerId: MarkerId(branch.id),
              position: branch.location,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueCyan,
              ),
              onTap: () {
                bloc.add(LocationEvent(branch.id));
              },
            );
          }).toSet();
          return Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                preferredSize: Size(
                  context.getWidth(),
                  context.getHeight() * 0.1,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBuilder<BranchBloc, BranchState>(
                    builder: (context, state) {
                      return BranchWidget(
                        branch: bloc.branchGetIt.branchName(),
                      );
                    },
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Google Map view with user location and branch markers.
                      SizedBox(
                        width: context.getWidth(),
                        height: context.getHeight() * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: GoogleMap(
                              myLocationButtonEnabled: true,
                              myLocationEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target:
                                    bloc.currentLocation ??
                                    LatLng(24.7136, 46.6753),
                                zoom: 10,
                              ),
                              markers: markers,
                            ),
                          ),
                        ),
                      ),
                      // Show branch details when a marker is selected.
                      BlocBuilder<BranchBloc, BranchState>(
                        builder: (context, state) {
                          if (state is ErrorState) {
                            return Center(
                              child: Text(
                                state.message,
                                style: StyleText.regular16Error,
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          if (state is UpdateState) {
                            return Column(
                              children: branches.map((branch) {
                                final distance = branch.id == '1'
                                    ? bloc.distanceToBranch1
                                    : bloc.distanceToBranch2;

                                return GestureDetector(
                                  onTap: () {
                                    bloc.add(LocationEvent(branch.id));
                                  },
                                  child: BranchDetailWidget(
                                    branchName: branch.name,
                                    branchDistance: distance!.toInt(),
                                    cardColor:
                                        state.selectedMarkerId == branch.id
                                        ? StyleColor.teal
                                        : StyleColor.white,
                                  ),
                                );
                              }).toList(),
                            );
                          }
                          // If no branch selected yet, show a placeholder.
                          return Text('No Branch Selected');
                        },
                      ),
                      StyleSize.sizeH8,
                      ButtomWidget(onTab: () {}, textElevatedButton: 'Next'),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
