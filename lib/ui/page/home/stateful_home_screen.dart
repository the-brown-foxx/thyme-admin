import 'package:flutter/material.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/admin_authenticator.dart';
import 'package:thyme_to_park_admin/service/registry/car_registry.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/page/home/home_screen.dart';

class StatefulHomeScreen extends StatefulWidget {
  final CarRegistry _carRegistry;
  final AdminAuthenticator _adminAuthenticator;

  const StatefulHomeScreen({
    super.key,
    required final CarRegistry carRegistry,
    required final AdminAuthenticator adminAuthenticator,
  })  : _carRegistry = carRegistry,
        _adminAuthenticator = adminAuthenticator;

  @override
  State<StatefulHomeScreen> createState() => _StatefulHomeScreenState();
}

class _StatefulHomeScreenState extends State<StatefulHomeScreen> {
  bool loading = false;
  List<Car> cars = [];

  @override
  Widget build(final BuildContext context) {
    return HomeScreen(
      cars: cars,
      onRegisterCar: () {},
      onChangePassword: () {},
      onLogout: () {},
    );
  }
}
