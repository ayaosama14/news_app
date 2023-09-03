import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  // year
  String year = dateTime.year.toString();
  // month
  String month = dateTime.month.toString();
  // day
  String day = dateTime.day.toString();

  final formattedData = '$year/$month/$day';
  return formattedData;
}
