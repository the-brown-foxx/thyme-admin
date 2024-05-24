import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/admin_authenticator.dart';
import 'package:thyme_to_park_admin/service/log/car_logger.dart';
import 'package:thyme_to_park_admin/service/registry/car_registry.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/search.dart';
import 'package:thyme_to_park_admin/ui/page/home/home_screen.dart';
import 'package:thyme_to_park_admin/ui/page/home/info/stateful_car_info_dialog.dart';
import 'package:thyme_to_park_admin/ui/page/home/register/stateful_register_car_dialog.dart';

class StatefulHomeScreen extends StatefulWidget {
  final AdminAuthenticator _adminAuthenticator;
  final CarRegistry _carRegistry;
  final CarLogger _carLogger;

  const StatefulHomeScreen({
    super.key,
    required final CarRegistry carRegistry,
    required final AdminAuthenticator adminAuthenticator,
    required final CarLogger carLogger,
  })  : _adminAuthenticator = adminAuthenticator,
        _carRegistry = carRegistry,
        _carLogger = carLogger;

  @override
  State<StatefulHomeScreen> createState() => _StatefulHomeScreenState();
}

class _StatefulHomeScreenState extends State<StatefulHomeScreen> {
  final searchController = TextEditingController();
  bool loading = false;
  List<Car> allCars = [];
  List<Car> cars = [];

  @override
  void initState() {
    navigateToCorrectPage();

    widget._carRegistry.loading.listen((final loading) {
      if (!mounted) return;
      setState(() => this.loading = loading);
    });

    widget._carRegistry.cars.listen((final cars) {
      if (!mounted) return;
      setState(() {
        allCars = cars;
        search();
      });
    });

    searchController.addListener(() => setState(() => search()));

    super.initState();
  }

  void navigateToCorrectPage() {
    widget._adminAuthenticator.loggedIn.listen((final loggedIn) {
      if (!loggedIn && mounted) {
        context.pop();
      }
    });
  }

  void search() {
    cars = allCars.search(
      searchController.text,
      keys: [
        (final car) => car.registrationId,
        (final car) => car.modelInfo,
        (final car) => car.owner,
      ],
    );
  }

  @override
  Widget build(final BuildContext context) {
    return HomeScreen(
      searchController: searchController,
      cars: cars,
      onOpenLogs: onOpenLogs,
      onRegisterCar: onRegisterCar,
      onChangePassword: onChangePassword,
      onLogout: onLogout,
      onCarTap: onCarTap,
      loading: loading,
    );
  }

  void onOpenLogs() async {
    throw UnimplementedError();
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
    await widget._adminAuthenticator.logout();
  }

  void onCarTap(final Car car) {
    showDialog(
      context: context,
      builder: (final _) => StatefulCarInfoDialog(
        car: car,
        carRegistry: widget._carRegistry,
        carLogger: widget._carLogger,
      ),
    );
  }
}
