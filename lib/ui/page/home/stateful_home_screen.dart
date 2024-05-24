import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thyme_to_park_admin/service/authenticator/admin/admin_authenticator.dart';
import 'package:thyme_to_park_admin/service/log/car_logger.dart';
import 'package:thyme_to_park_admin/service/parking/parking_space_counter.dart';
import 'package:thyme_to_park_admin/service/registry/car_registry.dart';
import 'package:thyme_to_park_admin/service/registry/model/car.dart';
import 'package:thyme_to_park_admin/ui/component/search.dart';
import 'package:thyme_to_park_admin/ui/page/home/home_screen.dart';
import 'package:thyme_to_park_admin/ui/page/home/info/stateful_car_info_dialog.dart';
import 'package:thyme_to_park_admin/ui/page/home/parking/stateful_set_parking_space_count_dialog.dart';
import 'package:thyme_to_park_admin/ui/page/home/register/stateful_register_car_dialog.dart';

class StatefulHomeScreen extends StatefulWidget {
  final AdminAuthenticator _adminAuthenticator;
  final CarRegistry _carRegistry;
  final CarLogger _carLogger;
  final ParkingSpaceCounter _parkingSpaceCounter;

  const StatefulHomeScreen({
    super.key,
    required final CarRegistry carRegistry,
    required final AdminAuthenticator adminAuthenticator,
    required final CarLogger carLogger,
    required final ParkingSpaceCounter parkingSpaceCounter,
  })  : _adminAuthenticator = adminAuthenticator,
        _carRegistry = carRegistry,
        _carLogger = carLogger,
        _parkingSpaceCounter = parkingSpaceCounter;

  @override
  State<StatefulHomeScreen> createState() => _StatefulHomeScreenState();
}

class _StatefulHomeScreenState extends State<StatefulHomeScreen> {
  final searchController = TextEditingController();
  int vacantSpace = 0;
  bool loading = false;
  List<Car> allCars = [];
  List<Car> cars = [];

  @override
  void initState() {
    navigateToCorrectPage();

    widget._parkingSpaceCounter.parkingSpaceCount.listen((final count) {
      if (!mounted) return;
      setState(() => vacantSpace = count.vacantSpace);
    });

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

    // TODO: auto open parking dialog if parking space count is not set
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
      vacantSpace: vacantSpace,
      cars: cars,
      onUpdateParkingSpaceCount: onUpdateParkingSpaceCount,
      onOpenLogs: onOpenLogs,
      onRegisterCar: onRegisterCar,
      onChangePassword: onChangePassword,
      onLogout: onLogout,
      onCarTap: onCarTap,
      loading: loading,
    );
  }

  void onOpenLogs() async {
    context.go('/home/logs');
  }

  void onUpdateParkingSpaceCount() {
    showDialog(
      context: context,
      builder: (final _) => StatefulSetParkingSpaceCountDialog(
        parkingSpaceCounter: widget._parkingSpaceCounter,
      ),
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
