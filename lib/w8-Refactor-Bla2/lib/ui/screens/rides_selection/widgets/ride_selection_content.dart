import 'package:flutter/material.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/model/ride/ride.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/model/ride_pref/ride_pref.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/ui/screens/rides_selection/view_model/ride_selection_model.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/ui/screens/rides_selection/widgets/ride_preference_modal.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/ui/screens/rides_selection/widgets/rides_selection_header.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/ui/screens/rides_selection/widgets/rides_selection_tile.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/ui/theme/theme.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/utils/animations_util.dart';

///
///  The Ride Selection screen allows user to select a ride, once ride preferences have been defined.
///  The screen also allow user to:
///   -  re-define the ride preferences
///   -  activate some filters.
///
class RideSelectionContent extends StatelessWidget {
  final RideSelectionModel viewModel;

  const RideSelectionContent({super.key, required this.viewModel});

  void onBackTap(BuildContext context) {
    Navigator.pop(context);
  }

  void onFilterPressed() {
    // TODO
  }

  void onRideSelected(Ride ride) {
    // Later
  }

  void onPreferencePressed(BuildContext context) async {
    // 1 - Navigate to the rides preference picker
    RidePreference? newPreference = await Navigator.of(context)
        .push<RidePreference>(
          AnimationUtils.createRightToLeftRoute(
            RidePreferenceModal(initialPreference: viewModel.selectedRidePreference),
          ),
        );

    if (newPreference != null) {
      viewModel.selectRidePreference(newPreference);
    }
  }

 @override
  Widget build(BuildContext context) {
    final selectedRidePreference = viewModel.selectedRidePreference;
    final matchingRides = viewModel.matchingRides;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            RideSelectionHeader(
              ridePreference: selectedRidePreference,
              onBackPressed: () => onBackTap(context),
              onFilterPressed: onFilterPressed,
              onPreferencePressed: () => onPreferencePressed(context),
            ),
            const SizedBox(height: 100),
            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (ctx, index) => RideSelectionTile(
                  ride: matchingRides[index],
                  onPressed: () => onRideSelected(matchingRides[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
