import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void dismissKeyboard(){
  FocusManager.instance.primaryFocus?.unfocus();
}

double getScreenScaleFactor({Size sampleUiSize = const Size(430, 932)}){
  try{
    return ((Get.width/sampleUiSize.width) + (Get.height/sampleUiSize.height))/2;
  }
  catch(e){
    return 1;
  }
}



void vibrateNow(){
  try{
    HapticFeedback.selectionClick();
    // HapticFeedback.heavyImpact();
  }
  catch(e){
    null;
  }
}

Future<void> superTryCatch({
  required Function() function,
  required Function(dynamic e) onCatch,
}) async {
  try {
    await function();
  } catch (e) {
    String callerFrame = '-';
    try {
      final stackTrace = StackTrace.current;
      callerFrame = stackTrace.toString();
    } catch (e) {
      null;
    }
    // AppLoggerService().addToLogger(
    //     appLog: AppLog(
    //         when: DateTime.now(),
    //         where: callerFrame,
    //         what: e.toString(),
    //         code: 1)
    // );
    onCatch(e);
  }
}

void superPrint(var content, {var title = 'Super Print'}) {
  String callerFrame = '';

  if (kDebugMode) {
    try {
      final stackTrace = StackTrace.current;
      final frames = stackTrace.toString().split("\n");
      callerFrame = frames[1];
    } catch (e) {
      debugPrint(e.toString(), wrapWidth: 1024);
    }

    DateTime dateTime = DateTime.now();
    String dateTimeString =
        '${dateTime.hour} : ${dateTime.minute} : ${dateTime.second}.${dateTime.millisecond}';
    debugPrint('', wrapWidth: 1024);
    debugPrint(
        '- ${title.toString()} - ${callerFrame.split('(').last.replaceAll(')', '')}',
        wrapWidth: 1024);
    debugPrint('____________________________');
    try {
      debugPrint(
          const JsonEncoder.withIndent('  ')
              .convert(const JsonDecoder().convert(content)),
          wrapWidth: 1024);
    } catch (e1) {
      try {
        debugPrint(
            const JsonEncoder.withIndent('  ')
                .convert(const JsonDecoder().convert(jsonEncode(content))),
            wrapWidth: 1024);
      } catch (e2) {
        debugPrint(content.toString());
      }
    }
    debugPrint('____________________________ $dateTimeString');
  }
}

class AppFunctions {

  // Future<XFile?> pickImage(
  //     {required ImageSource imageSource}) async {
  //   var image = await ImagePicker()
  //       .pickImage(source: imageSource, maxHeight: 720, maxWidth: 1080);
  //   if(image!= null){
  //     return image;
  //   }else{
  //     return null;
  //   }
  // }

  String hideMiddleCharacters(String input, int start) {
    if (input.length < 6) {
      // Not enough characters to hide
      return input;
    }

    // Replace characters in the middle with asterisks
    int startIndex = start;
    int endIndex = input.length - 4;
    String hiddenPart = '*' * (endIndex - startIndex + 1);
    String result = input.replaceRange(startIndex, endIndex + 1, hiddenPart);

    return result;
  }

  String convertMinutesToHoursAndMinutes(int minutes) {
    if (minutes < 0) {
      return "Invalid input";
    }

    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    if (hours == 0) {
      return "${remainingMinutes}min";
    } else if (remainingMinutes == 0) {
      return "${hours}hr";
    } else {
      return "${hours}hr ${remainingMinutes}min";
    }
  }

  dynamic parseEnum<T>({
    required List<Enum> values,
    required String query,
    required Enum defaultValue,
  }) {
    dynamic result = defaultValue;
    try {
      result = values.where((element) {
        return query.toUpperCase() == element.name.toUpperCase();
      }).firstOrNull ??
          defaultValue;
    } catch (e) {
      superPrint(e);
      null;
    }
    return result;
  }

  bool isSameDay({required DateTime dateTime1,required DateTime dateTime2}){
    return dateTime1.toString().substring(0,10) == dateTime2.toString().substring(0,10);
  }

  List<DateTime> getBetweenDates({required DateTimeRange dtr}){
    List<DateTime> result = [];
    DateTime tempDate = dtr.start;
    do{
      result.add(tempDate);
      tempDate = tempDate.add(const Duration(days: 1));
    }
    while(!isSameDay(dateTime1: tempDate, dateTime2: dtr.end.add(const Duration(days: 1))));
    return result;
  }

  List<int?> getCalendarData({required DateTime dateTime}){
    //1=Monday, 7=Sunday
    DateTimeRange dateTimeRange = AppFunctions().getCurrentMonth(dateTime: dateTime);
    final start = dateTimeRange.start;
    final end = dateTimeRange.end;
    int currentDay = 1;
    int currentWeek = 1;
    List<int?> data = List.generate(42, (index) => null);
    do{
      DateTime thatDay = start.copyWith(day: currentDay);
      int weekday = (thatDay.weekday);
      int index = (((currentWeek-1)*7) + weekday) - 1;
      data[index] = currentDay;
      currentDay++;
      if(weekday==7){
        //sunday
        currentWeek++;
      }
    }
    while(currentDay <= end.day);
    return data;
  }


  DateTimeRange getCurrentMonth({required DateTime dateTime}){
    DateTime start = DateTime.now();
    DateTime end = DateTime.now();
    try{
      start = DateTime(dateTime.year,dateTime.month,1,0,0);
      end = DateTime(start.year,start.month+1,1,23,59,59,999).subtract(const Duration(days: 1));
    }
    catch(e){
      superPrint(e);
    }
    final DateTimeRange dateTimeRange = DateTimeRange(start: start, end: end);
    return dateTimeRange;
  }

  DateTimeRange getNextMonth({required DateTime dateTime}){
    DateTime start = DateTime.now();
    DateTime end = DateTime.now();
    try{
      start = DateTime(dateTime.year,dateTime.month+1,1,0,0);
      end = DateTime(start.year,start.month+1,1,23,59,59,999).subtract(const Duration(days: 1));
    }
    catch(e){
      superPrint(e);
    }
    final DateTimeRange dateTimeRange = DateTimeRange(start: start, end: end);
    return dateTimeRange;
  }

  DateTimeRange getPrevMonth({required DateTime dateTime}){
    DateTime start = DateTime.now();
    DateTime end = DateTime.now();
    try{
      start = DateTime(dateTime.year,dateTime.month-1,1,0,0);
      end = DateTime(start.year,start.month+1,1,23,59,59,999).subtract(const Duration(days: 1));
    }
    catch(e){
      superPrint(e);
    }
    final DateTimeRange dateTimeRange = DateTimeRange(start: start, end: end);
    return dateTimeRange;
  }

  DateTimeRange getCurrentWeek({required DateTime focusedDate}){

    int weekday = focusedDate.weekday;
    DateTime start = DateTime.now();

    if(weekday==7){
      start = focusedDate;
    }
    else{
      do{
        focusedDate = focusedDate.subtract(const Duration(days: 1));
        weekday = focusedDate.weekday;
      }while(weekday!=7);
      start = focusedDate;
    }
    return DateTimeRange(
      start: start,
      end: start.add(const Duration(days: 6))
    );

  }


}

