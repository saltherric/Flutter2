import 'package:flutter/material.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/ui/screens/home/view_model/home_model.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/ui/screens/home/widgets/home_content.dart';
import 'package:flutter2/w8-Refactor-Bla2/lib/ui/state/ride_pref_state.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(
        ridePreferenceState: context.read<RidePreferenceState>()
      ),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return HomeContent(viewModel:viewModel);
        }
      ),
    );
  }
}