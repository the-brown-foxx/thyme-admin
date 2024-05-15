import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/page/home/component/cars_list_view.dart';
import 'package:thyme_to_park_admin/ui/page/home/component/top_bar.dart';

class HomeScreen extends StatelessWidget {
  final List<Car> cars;
  final VoidCallback onRegisterCar;
  final VoidCallback onChangePassword;
  final VoidCallback onLogout;
  final bool loading;

  const HomeScreen({
    super.key,
    required this.cars,
    required this.onRegisterCar,
    required this.onChangePassword,
    required this.onLogout,
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
            maxContentWidth: 1080,
            onChangePassword: onChangePassword,
            onLogout: onLogout,
            loading: loading,
          ),
          Expanded(
            child: CarsListView(
              cars: cars,
              maxContentWidth: 1080,
            ),
          ),
        ],
      ),
    );
  }
}
