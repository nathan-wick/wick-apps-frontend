enum DateFormat {
  yearMonthDay('YYYY/MM/DD'),
  monthDayYear('MM/DD/YYYY'),
  dayMonthYear('DD/MM/YYYY');

  final String value;

  const DateFormat(this.value);
}
