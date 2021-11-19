import 'package:intl/intl.dart';
import 'package:get/get.dart';

class DateFormatHelper {
  static DateFormat _yearMonthDay = new DateFormat('d MMMM y');
  static DateFormat _serverFormat = new DateFormat('y-MMMM-dTHmsZ');
  static DateFormat _weekDayMonth = new DateFormat('EEEE - d MMMM');
  static DateFormat _hour24MinuteSecond = new DateFormat('H:m:s');
  static DateFormat _hourMinuteSecond = new DateFormat('jm');
  static DateFormat yearMonthDayServer = new DateFormat('d-MMMM-y');
  static DateFormat serverFormatApi = new DateFormat('yyyy-MM-dd');
  static String yearMonthDay(String date) {
    // ignore: unnecessary_null_comparison
    if (date != null) {
      var formattedDate = _yearMonthDay.format(DateTime.parse(date));
      return formattedDate;
    } else {
      return '';
    }
  }

  static int getTimezoneOffset() {
    var d = DateTime.now().timeZoneOffset.inMinutes;
    print(d);
    return d;
  }

  static String formatServerRequest(String date) {
    var formattedDate = _serverFormat.format(DateTime.parse(date));
    return formattedDate;
  }

  static String weekDayMonth(String date) {
    // ignore: unnecessary_null_comparison
    if (date != null) {
      var formattedDate = _weekDayMonth.format(DateTime.parse(date));
      return formattedDate;
    } else {
      return '';
    }
  }

  static String hour24MinuteSecond(String date) {
    // ignore: unnecessary_null_comparison
    if (date != null) {
      var formattedDate = _hour24MinuteSecond.format(DateTime.parse(date));
      return formattedDate;
    } else {
      return '';
    }
  }

  static String hourMinuteSecond(DateTime date) {
    // ignore: unnecessary_null_comparison
    if (date != null) {
      var formattedDate = _hourMinuteSecond.format(date);
      return formattedDate;
    } else {
      return '';
    }
  }

  static String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  static String apiFormatYearMonthDayServer(String date) {
    if (date.isNotEmpty) {
      var formattedDate = serverFormatApi.format(DateTime.parse(date));
      return formattedDate;
    } else {
      return '';
    }
  }

  static String formatYearMonthDayServer(String date) {
    if (date.isNotEmpty) {
      var formattedDate = yearMonthDayServer.format(DateTime.parse(date));
      return formattedDate;
    } else {
      return '';
    }
  }

  static String getVerboseDateTimeRepresentation(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime justNow = now.subtract(Duration(minutes: 1));
    DateTime localDateTime = dateTime.toLocal();
    if (!localDateTime.difference(justNow).isNegative) {
      return ('dateFormatter_just_now').tr;
    }

    String roughTimeString = 'Today'.tr; //DateFormat('jm').format(dateTime);
    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return roughTimeString;
    }
    DateTime yesterday = now.subtract(Duration(days: 1));
    if (localDateTime.day == yesterday.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return ('dateFormatter_yesterday').tr;
    }
    if (now.difference(localDateTime).inDays < 4) {
      String weekday = DateFormat('EEEE').format(localDateTime);
      return '$weekday';
    }
    return '${DateFormat(
      'MMMMEEEEd',
    ).format(dateTime)}';
  }
}
