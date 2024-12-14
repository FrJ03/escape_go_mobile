class Location{
  final country;
  final city;
  final street;
  final streetNumber;
  final coordinates;

  const Location({
    required this.country,
    required this.city,
    required this.street,
    required this.streetNumber,
    required this.coordinates
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    switch (json) {
      case {
      'country': String country,
      'city': String city,
      'street': String street,
      'street_number': int streetNumber,
      'coordinates': String coordinates
      }:
        return Location(
          country: country,
          city: city,
          street: street,
          streetNumber: streetNumber,
          coordinates: coordinates,
        );
      default:
        throw const FormatException('Failed to load location.');
    }
  }
}