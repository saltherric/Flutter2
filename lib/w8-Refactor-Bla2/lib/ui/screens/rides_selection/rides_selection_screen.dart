import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/respositories/ride/rides_repository.dart';
import '../../state/ride_pref_state.dart';
import '../rides_selection/view_model/ride_selection_model.dart';
import '../rides_selection/widgets/ride_selection_content.dart';

class RidesSelectionScreen extends StatelessWidget {
  const RidesSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RideSelectionModel>(
      create: (_) => RideSelectionModel(
        ridePreferenceState: context.read<RidePreferenceState>(),
        ridesRepository: context.read<RidesRepository>(),
      ),
      child: Consumer<RideSelectionModel>(
        builder: (context, viewModel, child) {
          return RideSelectionContent(viewModel: viewModel);
        },
      ),
    );
  }
}