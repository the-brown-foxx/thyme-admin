import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/admin_authenticator.dart';
import 'package:thyme_to_park_admin/service/registry/car_registry.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/page/home/home_screen.dart';
import 'package:thyme_to_park_admin/ui/page/home/register/stateful_register_car_dialog.dart';

class StatefulHomeScreen extends StatefulWidget {
  final AdminAuthenticator _adminAuthenticator;
  final CarRegistry _carRegistry;

  const StatefulHomeScreen({
    super.key,
    required final CarRegistry carRegistry,
    required final AdminAuthenticator adminAuthenticator,
  })  : _adminAuthenticator = adminAuthenticator,
        _carRegistry = carRegistry;

  @override
  State<StatefulHomeScreen> createState() => _StatefulHomeScreenState();
}

class _StatefulHomeScreenState extends State<StatefulHomeScreen> {
  bool loading = false;
  List<Car> cars = [];

  @override
  void initState() {
    navigateToCorrectPage();

    widget._carRegistry.loading.listen((final loading) {
      setState(() => this.loading = loading);
    });

    widget._carRegistry.cars.listen((final cars) {
      setState(() => this.cars = cars);
    });

    super.initState();
  }

  void navigateToCorrectPage() {
    widget._adminAuthenticator.loggedIn.listen((final loggedIn) {
      if (!loggedIn && mounted) {
        context.pop();
      }
    });
  }

  @override
  Widget build(final BuildContext context) {
    return HomeScreen(
      cars: cars,
      onRegisterCar: onRegisterCar,
      onChangePassword: onChangePassword,
      onLogout: onLogout,
      loading: loading,
    );
  }

  Future<void> onRegisterCar() async {
    showDialog(
      context: context,
      builder: (final _) {
        return StatefulRegisterCarDialog(carRegistry: widget._carRegistry);
      },
    );
  }

  void onChangePassword() {
    context.go('/home/change-password');
  }

  Future<void> onLogout() async {
    widget._adminAuthenticator.logout();
  }
}
