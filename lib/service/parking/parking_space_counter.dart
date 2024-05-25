import 'model/parking_space_count.dart';

abstract interface class ParkingSpaceCounter {
  Future<bool> get parkingSpaceSet;

  Stream<ParkingSpaceCount> get parkingSpaceCount;

  Future<void> setParkingSpaceCount(final ParkingSpaceCount parkingSpaceCount);
}