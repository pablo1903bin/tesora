

import 'package:flutter/material.dart';
import 'package:tesora/app/domain/models/gasto/combined_model.dart';

class DatePicker extends StatefulWidget {
  final CombinedModel cModel;
  const DatePicker({super.key, required this.cModel});

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String selecteDay = 'Hoy';

  @override
  void initState() {
    if(widget.cModel.day == 0){
      widget.cModel.year = DateTime.now().year;
      widget.cModel.month = DateTime.now().month;
      widget.cModel.day = DateTime.now().day;
    } else {
      selecteDay = 'Otro día';
    }
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {

    DateTime date = DateTime.now();
    var widgets = <Widget>[];

    widgets.insert(0, const Icon(Icons.date_range_outlined, size: 35.0));
    widgets.insert(1, const SizedBox(width: 4));

    calendar(){
      showDatePicker(
        context: context, 
        locale: const Locale('es', 'ES'),
        initialDate: date.subtract(const Duration(hours: 24 * 2)), 
        firstDate: date.subtract(const Duration(hours: 24 * 30)), 
        lastDate: date.subtract(const Duration(hours: 24 * 2)),
      ).then((value){
        setState(() {
          if(value != null){
            widget.cModel.year = value.year;
            widget.cModel.month = value.month;
            widget.cModel.day = value.day;
          } else {
            setState(() {
              selecteDay = 'Hoy';
            });
          }
        });
      });
    }

    Map<String, DateTime> items = {
      'Hoy'      : date,
      'Ayer'     : date.subtract(const Duration(hours: 24)),
      'Otro día' : date
    };

    items.forEach((name, date){
      widgets.add(
        Expanded(
          child: GestureDetector(
            onTap: (){
              setState(() {
                selecteDay = name;
                widget.cModel.year = date.year;
                widget.cModel.month = date.month;
                widget.cModel.day = date.day;
                if(name == 'Otro día') calendar();
              });
            },
            child: DateContainWidget(
              cModel: widget.cModel,
              name: name,
              isSelected: name == selecteDay,
            ),
          ),
        )
      );
    });

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: widgets
      ),
    );
  }
}

class DateContainWidget extends StatelessWidget {
  final CombinedModel cModel;
  final String name;
  final bool isSelected;
  const DateContainWidget({
    super.key,
    required this.cModel,
    required this.name,
    required this.isSelected
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: isSelected
              ? Colors.green
              : Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(25.0)
            ),
            child: Center(
              child: Text(name),
            ),
          ),
        ),
        isSelected
        ? FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            '${cModel.year}/${cModel.month}/${cModel.day}'
          ),
        )
        : const Text('')
      ],
    );
  }
}