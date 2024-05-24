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

  factory CarLog.fromJson(final Map<String, dynamic> json) {
    return CarLog(dateTime: DateTime.parse(json['date_time']),
      carRegistrationId: json['car_registration_id'],
      entering: json['entering'],
      image: json['image'],
      sus: json['sus'],
    );
  }
}