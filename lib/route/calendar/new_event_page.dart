import 'package:dio/dio.dart';
import 'package:dipterv/core/locator.dart';
import 'package:dipterv/models/event_model.dart';
import 'package:dipterv/services/event_service.dart';
import 'package:dipterv/services/safe_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class NewEventPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  final _eventService = locator.get<EventService>();
  final _safeStorageService = locator.get<SafeStoreService>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  var selectedDate = DateTime.now();

  bool _titleIsValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(children: [
              Icon(Icons.calendar_month, size: 30, color: Colors.blueAccent,),
              SizedBox(width: 10,),
              Text('Új esemény', style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 30
              ),),
            ],),
            SizedBox(height: 40),
            TextFormField(
              controller: _titleController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: Colors.blueAccent,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                hintText: "Cím",
                errorText: _titleIsValid ? null : "Ne hagyja üresen a mezőt!",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.title),
                ),
              ),
            ),
            Divider(thickness: 2, height: 40, color: Colors.blueAccent.shade100,),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  Icon(Icons.watch_later_outlined),
                  SizedBox(width: 15,),
                  GestureDetector(
                    child: Text(selectedDayText(), style: TextStyle(
                      fontSize: 19
                    ),),
                    onTap: () async {
                      await showDateTimePicker();
                    } ,)
                ],
              ),
            ),
            Divider(thickness: 2, height: 40, color: Colors.blueAccent.shade100,),
            TextFormField(
              controller: _descriptionController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: Colors.blueAccent,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                hintText: "Leírás",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.description),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text('Mégse', style: TextStyle(
                      color: Colors.blueAccent
                    ),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(width: 40,),
                ElevatedButton(
                    onPressed: () async {
                      await _saveEvent();
                    },
                    child: Text('Mentés'))
              ],
            ),
          ],
        ),
      )
    );
  }

  Future<void> _saveEvent() async {
    setState(() {
      _titleIsValid = _titleController.text.isNotEmpty;
    });
    if(_titleController.text.isEmpty) {
      return;
    } else {
      var email = await _safeStorageService.username;
      try {
        await _eventService.saveEvent(EventModel(
            _titleController.text,
            selectedDate,
            _descriptionController.text.isEmpty ? ' ' : _descriptionController.text,
            email!,
            null
        ));
        Navigator.pop(context, true);
      } catch (e, s) {
        if(e is DioError) {
          print(e.message);
        }
      }
    }
  }

  String selectedDayText() {
    String pad(int num, int width) => num.toString().padLeft(width, '0');
    return '${selectedDate.year}.${pad(selectedDate.month, 2)}.${pad(selectedDate.day, 2)}   ${pad(selectedDate.hour, 2)}:${pad(selectedDate.minute, 2)}';
  }

  Future<void> showDateTimePicker() async {
    DateTime? date = await showOmniDateTimePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:
      DateTime(1600).subtract(const Duration(days: 3652)),
      lastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      selectableDayPredicate: (dateTime) {
        // Disable 25th Feb 2023
        if (dateTime == DateTime(2023, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );
    if(date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

}