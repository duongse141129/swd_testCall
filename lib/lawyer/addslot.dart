import 'package:advisories_lawyer/lawyer/infor_user.dart';
import 'package:advisories_lawyer/lawyer/input_field.dart';
import 'package:advisories_lawyer/lawyer/main_lawyer.dart';
import 'package:advisories_lawyer/lawyer/model_lawyer/slot.dart';
import 'package:advisories_lawyer/lawyer/network_lawyer/network_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

/*class AddSlotTask2 extends StatelessWidget {
  const AddSlotTask2({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
          title: Text("Create Task"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InputField(title: "Title", hint: "Enter your title"),
              InputField(title: "Date", hint: DateForm),
            ],
          ),
        ),

      ),
    );
  }
}*/

class AddSlotTask extends StatefulWidget {
  const AddSlotTask({Key? key}) : super(key: key);

  @override
  _AddSlotState createState() => _AddSlotState();
}

class _AddSlotState extends State<AddSlotTask> {
  DateTime _selectedDate = DateTime.now();
  final inputController = TextEditingController();
  var _endTime = "9:30 PM";
  var _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int slotPrice = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        title: Text("Create Task"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //InputField(title: "Title", hint: "Enter your title"),
              InputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: InputField(
                    title: "Start Date",
                    hint: _startTime,
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isStartTime: true);
                      },
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                      child: InputField(
                    title: "End Date",
                    hint: _endTime,
                    widget: IconButton(
                      onPressed: () {
                        _getTimeFromUser(isStartTime: false);
                      },
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  )
                  ),
                ],
              ),
              Container(
                child: TextFormField(
                  key: ValueKey('Price \$'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Price is missed';
                    }
                    return null;
                  },
                  controller: inputController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Price \$',
                  ),
                  /*onSaved: (value) {
                    print("price" + value!);
                    slotPrice = int.parse(value);
                  },*/
                ),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  _startTime=ChangeTime12To24(_startTime);
                  _endTime=ChangeTime12To24(_endTime);
                  final df = new DateFormat('dd/MM/yyyy');
                  String dateTo= df.format(_selectedDate);
                  print("Date to "+dateTo);
                  String sTimeString =dateTo +" " +_startTime;
                  String eTimeString = dateTo+" " +_endTime;
                  SlotDTO slotDTO = SlotDTO(
                      id: 0,
                      bookingId: 0,
                      startAt: sTimeString,
                      endAt: eTimeString,
                      lawyerId: InforUser.getIdUser(),
                      price: int.parse(inputController.text));
                  print(slotDTO.toString());
                  NetworkRequest.createSlot(slotDTO);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LawyerMain()));
                },
                
                child: Text(
                  "Create Task",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.deepPurple[600],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String ChangeTime12To24(String timeToChange) {
    String result;
    String apM = timeToChange.split(' ')[1];
    if (apM.compareTo("PM") == 0) {
      int hour = int.parse(timeToChange.split(':')[0]) + 12;
      //int mini = int.parse(timeToChange.split(' ')[0].split(':')[1]);
      String minu= timeToChange.split(' ')[0];
      minu=minu.split(':')[1];
      print("Gio chieu " + hour.toString());
      result=hour.toString()+":"+minu.toString();
      return result;
    } else {
      print("Gio sang "+timeToChange);
      result=timeToChange.split(' ')[0];
      return result;
    }
  }
  String themSoKhong(int ym) {
    String result;
    if(ym<10){
      result="0"+ym.toString();
      return result;
    }
    return ym.toString();
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2023),
    );

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        print('Date pick $_selectedDate');
      });
    } else {
      print("null pick date");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickerTime = await _showTimePicker();
    String _formatedTime = pickerTime.format(context);
    if (pickerTime == null) {
      print("Time cancel");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
        print('Time start $_startTime');
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
        print('Time end $_endTime');
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ));
  }

  _showTimePicker24() {
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, childWidget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 24-Hour format
                  alwaysUse24HourFormat: true),
              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
              child: childWidget!);
        });
  }
}
