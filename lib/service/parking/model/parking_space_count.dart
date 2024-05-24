class ParkingSpaceCount {
  final int totalSpace;
  final int vacantSpace;

  const ParkingSpaceCount({
    required this.totalSpace,
    required this.vacantSpace,
  });

  factory ParkingSpaceCount.fromJson(final Map<String, dynamic> json) {
    return ParkingSpaceCount(
      totalSpace: json['total_space'],
      vacantSpace: json['vacant_space'],
    );
  }
}
