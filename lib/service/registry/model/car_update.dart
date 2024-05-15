class CarUpdate {
  final String registrationId;
  final String? make;
  final String? model;
  final int? year;
  final String? color;
  final String? owner;
  final String? password;

  const CarUpdate({
    required this.registrationId,
    this.make,
    this.model,
    this.year,
    this.color,
    this.owner,
    this.password,
  });
}