import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_calendar/mini_calendar.dart';
import 'package:flutter_my_picker/flutter_my_picker.dart';
import 'package:flutter_my_picker/common/date.dart';

class readplan extends StatefulWidget {
  @override
  _MonthPageViewDemoState createState() => _MonthPageViewDemoState();
}

class _MonthPageViewDemoState extends State<readplan> {
  List<DateTime> ans = [];
  DateTime date = new DateTime.now();
  String dateStr = MyDate.format("HH:mm");
  bool flag = true;
  _change(formatString) {
    return (_date) {
      date = _date;
      dateStr = MyDate.format(formatString, _date);
    };
  }

  final DateDay minDay = DateDay.now().subtract(Duration(days: 57));
  final DateDay maxDay = DateDay.now().add(Duration(days: 89));
  MonthPageController _controller;
  DateMonth _month = DateMonth.now();
  DateDay _firstDay, _secondDay, _day;
  List<DateDay> _days = [];
  int _selectType = 1;
  String _data = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("读书计划"),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            tooltip: '保存',
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 104, 212, 122),
                  border: new Border.all(
                      width: 1, color: Color.fromARGB(255, 79, 78, 78))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.alarm),
                  Text("开启阅读提醒"),
                  Switch(
                      value: this.flag,
                      onChanged: (value) {
                        setState(() {
                          this.flag = value;
                        });
                      }),
                ],
              ),
            ),

            // _buildSelectTime(),
            MonthPageView<String>(
              option: MonthOption(
                //enableContinuous: true,
                marks: {
                  // DateDay.now().copyWith(day: 1): '111',
                  // DateDay.now().copyWith(day: 5): '222',
                  //  DateDay.now().copyWith(day: 13): '333',
                  //  DateDay.now().copyWith(day: 19): '444',
                  //DateDay.now().copyWith(day: 26): '444',
                },
                minDay: minDay,
                maxDay: maxDay,
                // enableDays: List.generate(20,
                //     (index) => DateDay.now().add(Duration(days: index + 1))),
                enableMultiple: true,
              ),
              width: 400,
              padding: EdgeInsets.all(1),
              scrollDirection: Axis.horizontal,
              showWeekHead: true,
              onContinuousSelectListen: (firstDay, endFay) {
                _firstDay = firstDay;
                _secondDay = endFay;
                setState(() {});
              },
              onMultipleSelectListen: (list) {
                _days = list;
                setState(() {});
              },
              onMonthChange: (month) {
                _month = month;
                setState(() {});
              },
              onDaySelected: (day, data, enable) {
                if (enable) {
                  _day = day;
                  _data = data;
                  setState(() {});
                } else {}
              },
              onCreated: (controller) => _controller = controller,
              localeType: CalendarLocaleType.zh,
              onClear: () {
                _controller?.option.setCurrentDay(null);
                _controller?.option.setFirstSelectDay(null);
                _controller?.option.setSecondSelectDay(null);
                _controller?.option.setMultipleDays([]);
                _controller?.reLoad();
                _firstDay = _controller?.option.firstSelectDay;
                _secondDay = _controller?.option.secondSelectDay;
                _days = _controller?.option.multipleDays ?? [];
                _day = _controller?.option.currentDay;
                setState(() {});
              },
            ),
            /* Container(
              child: Text(
                  '''当前月份：${_month.toString(yearSuffix: '年', monthSuffix: '月')}
可选范围：$minDay 至  $maxDay 
选择模式：${_selectType == 2 ? '连选' : _selectType == 3 ? '多选' : '单选'} 
单选日期：${_day?.toString(yearSuffix: '年', monthSuffix: '月', daySuffix: '日') ?? ''}   Mark： ${_data ?? ''}
连选日期：${_firstDay?.toString(yearSuffix: '年', monthSuffix: '月', daySuffix: '日') ?? ''}  至  ${_secondDay?.toString(yearSuffix: '年', monthSuffix: '月', daySuffix: '日') ?? ''}
连续日期：${_days.join('，')}
'''),
            )*/
            Row(
              children: [
                // Text(" ${_days.join('，')} "),
                Text("共选择${_days.length}天"),
                Spacer(),
                OutlinedButton(
                    onPressed: () {
                      MyPicker.showPicker(
                        context: context,
                        current: date,
                        mode: MyPickerMode.time,
                        onChange: _change('HH:mm'),
                      );
                    },
                    child: Text("确定"))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSelectTime() {
    Map<int, Widget> map = {
      1: Container(width: 40, alignment: Alignment.center, child: Text('单选')),
      2: Container(width: 40, alignment: Alignment.center, child: Text('连续')),
      3: Container(width: 40, alignment: Alignment.center, child: Text('多选')),
    };
    return Container(
      alignment: Alignment.topRight,
      child: CupertinoSegmentedControl<int>(
        onValueChanged: (index) {
          _selectType = index;
          _controller?.setEnableContinuous(_selectType == 2);
          _controller?.setEnableMultiple(_selectType == 3);
          _controller?.reLoad();
          setState(() {});
        },
        children: map,
        groupValue: _selectType,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
