import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/page/home/component/cars_list_view.dart';
import 'package:thyme_to_park_admin/ui/page/home/component/top_bar.dart';

class HomeScreen extends StatelessWidget {
  final List<Car> cars;
  final TextEditingController searchController;
  final VoidCallback onRegisterCar;
  final VoidCallback onChangePassword;
  final VoidCallback onLogout;
  final Function(Car) onCarTap;
  final bool loading;

  const HomeScreen({
    super.key,
    required this.cars,
    required this.searchController,
    required this.onRegisterCar,
    required this.onChangePassword,
    required this.onLogout,
    required this.onCarTap,
    required this.loading,
  });

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        onPressed: onRegisterCar,
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TopBar(
            searchController: searchController,
            onChangePassword: onChangePassword,
            onLogout: onLogout,
            loading: loading,
            maxContentWidth: 1080,
          ),
          Expanded(
            child: CarsListView(
              cars: cars,
              maxContentWidth: 1080,
              onCarTap: onCarTap,
            ),
          ),
        ],
      ),
    );
  }
}
