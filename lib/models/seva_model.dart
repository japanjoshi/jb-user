class Seva {
  String sevaName;
  String time;
  String number;
  String directions;
  String venue;

  Seva({
    required this.sevaName,
    required this.time,
    required this.directions,
    required this.venue,
    required this.number,
  });

  Seva.fromMap(Map<dynamic, dynamic> sevaData)
      : sevaName = sevaData['seva_name'] ?? 'N/A',
        time = sevaData['seva_time'] ?? 'N/A',
        directions = sevaData['seva_directions'] ?? 'N/A',
        venue = sevaData['seva_venue'] ?? 'N/A',
        number = sevaData['seva_number'] ?? 'N/A';
}
