import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/widget_with_placeholder.dart';
import 'package:thyme_to_park_admin/ui/page/home/component/cars_list_view.dart';
import 'package:thyme_to_park_admin/ui/page/home/component/home_top_bar.dart';

class HomeScreen extends StatelessWidget {
  final List<Car> cars;
  final TextEditingController searchController;
  final int vacantSpace;
  final VoidCallback onUpdateParkingSpaceCount;
  final VoidCallback onRegisterCar;
  final VoidCallback onOpenLogs;
  final VoidCallback onChangePassword;
  final VoidCallback onLogout;
  final Function(Car) onCarTap;
  final bool loading;

  const HomeScreen({
    super.key,
    required this.cars,
    required this.searchController,
    required this.vacantSpace,
    required this.onUpdateParkingSpaceCount,
    required this.onRegisterCar,
    required this.onOpenLogs,
    required this.onChangePassword,
    required this.onLogout,
    required this.onCarTap,
    required this.loading,
  });

  @override
  Widget build(final BuildContext context) {
    final placeholderMessage = searchController.text.isEmpty
        ? 'There are no registered cars'
        : 'Nothing matched your query';

    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        onPressed: onRegisterCar,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeTopBar(
            searchController: searchController,
            vacantSpace: vacantSpace,
            onUpdateParkingSpaceCount: onUpdateParkingSpaceCount,
            onOpenLogs: onOpenLogs,
            onChangePassword: onChangePassword,
            onLogout: onLogout,
            loading: loading,
            maxContentWidth: 1080,
          ),
          Expanded(
            child: WidgetWithPlaceholder.withEmptyIndicator(
              flipImage: true,
              empty: cars.isEmpty,
              emptyMessage: placeholderMessage,
              child: CarsListView(
                cars: cars,
                maxContentWidth: 1080,
                onCarTap: onCarTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
