import 'package:flutter/material.dart';

import '../../../../model/ride_pref/ride_pref.dart';
import '../../../../utils/animations_util.dart';
import '../../../theme/theme.dart';
import '../../../widgets/pickers/bla_ride_preference_picker.dart';
import '../../rides_selection/rides_selection_screen.dart';
import '../view_model/home_model.dart';
import '../widgets/home_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  void onRidePrefSelected(
    BuildContext context,
    RidePreference selectedPreference,
  ) async {
    // 1- Update the current preference in the state
    viewModel.selectRidePreference(selectedPreference);

    // 2 - Navigate to the rides screen
    await Navigator.of(context).push(
      AnimationUtils.createBottomToTopRoute(
        const RidesSelectionScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_buildBackground(), _buildForeground(context)]);
  }

  Widget _buildForeground(BuildContext context) {
    return Column(
      children: [
        // 1 - THE HEADER
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Your pick of rides at low price",
            style: BlaTextStyles.heading.copyWith(color: Colors.white),
          ),
        ),
        const SizedBox(height: 100),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 2 - THE FORM
              BlaRidePreferencePicker(
                initRidePreference: viewModel.selectedPreference,
                onRidePreferenceSelected: (selectedPreference) =>
                    onRidePrefSelected(context, selectedPreference),
              ),
              const SizedBox(height: BlaSpacings.m),

              // 3 - THE HISTORY
              _buildHistory(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistory(BuildContext context) {
    List<RidePreference> history = viewModel.history;

    return SizedBox(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: history.length,
        itemBuilder: (ctx, index) => HomeHistoryTile(
          ridePref: history[index],
          onPressed: () => onRidePrefSelected(context, history[index]),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}