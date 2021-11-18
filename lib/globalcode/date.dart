import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart'; // for date format
// void main() {
//   var now = DateTime.now();
//   print(DateFormat().format(now)); // This will return date using the default locale
//   print(DateFormat('yyyy-MM-dd hh:mm:ss').format(now));
//   print(DateFormat.yMMMMd().format(now)); // print long date
//   print(DateFormat.yMd().format(now)); // print short date
//   print(DateFormat.jms().format(now)); // print time
//
//   initializeDateFormatting('es'); // This will initialize Spanish locale
//   print(DateFormat.yMMMMd('es').format(now)); // print long date in Spanish format
//   print(DateFormat.yMd('es').format(now)); // print short date in Spanish format
//   print(DateFormat.jms('es').format(now)); // print time in Spanish format
// }

String getDate() {
  initializeDateFormatting();
  DateTime now = DateTime.now();
  var dateString = DateFormat('dd-MM-yyyy').format(now);
  final String configFileName = 'lastConfig.$dateString.json';
  return dateString;
}

String revGetDate() {
  initializeDateFormatting();
  DateTime now = DateTime.now();
  var dateString = DateFormat('yyy-MM-dd').format(now);
  final String configFileName = 'lastConfig.$dateString.json';
  return dateString;
}

String getTimeStamp({time}) {
  var t = (time as Timestamp).toDate();
  return DateFormat('dd/MM/yyyy, hh:mm a').format(t);
}


String getMoney({money}){
  final formatCurrency =
  NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'INR');
  var price = formatCurrency.format(int.parse(money)).split('.')[0];
  print(price);
  return price;
}