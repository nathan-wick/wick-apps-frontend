enum WickEnumDateFormat {
  yearMonthDay('YYYY/MM/DD'),
  monthDayYear('MM/DD/YYYY'),
  dayMonthYear('DD/MM/YYYY');

  final String value;

  const WickEnumDateFormat(this.value);
}
