class CarLog {
  final DateTime dateTime;
  final String carRegistrationId;
  final bool entering;
  final String image;
  final bool sus;
  
  const CarLog({
    required this.dateTime,
    required this.carRegistrationId,
    required this.entering,
    required this.image,
    required this.sus,
  });
}