class Course {
  String contactName;
  String date;
  String directions;
  String imageUrl;
  String name;
  String time;
  String venue;
  String number;

  Course({
    required this.contactName,
    required this.date,
    required this.directions,
    required this.imageUrl,
    required this.name,
    required this.time,
    required this.venue,
    required this.number,
  });

  Course.fromMap(Map<dynamic, dynamic> courseData)
      : contactName = courseData['course_contact_name'] ?? 'N/A',
        date = courseData['course_date'] ?? 'N/A',
        directions = courseData['course_directions'] ?? 'N/A',
        imageUrl = courseData['course_image'] ?? 'N/A',
        name = courseData['course_name'] ?? 'N/A',
        time = courseData['course_time'] ?? 'N/A',
        venue = courseData['course_venue'] ?? 'N/A',
        number = courseData['course_contact_number'] ?? 'N/A';
}
