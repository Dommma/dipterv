import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:dipterv/bloc/event/event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styles/custom_colors.dart';

class CreateEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create event"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: BlocConsumer<EventCubit, EventState>(
          listenWhen: (_, state) => state is! EventInitialState,
          listener: (context, state) {
            if (state is EventLoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                },
              );
            }
            if(state is EventErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
            if (state is EventFinishedState) {
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is EventInitialState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: state.nameController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        cursorColor: CustomColor.mainColor,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          hintText: "Title",
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: state.descriptionController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        cursorColor: CustomColor.mainColor,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          hintText: "Description",
                          contentPadding: EdgeInsets.all(20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            )),
                          ),
                          onPressed: () async {
                            var newDate = await showOmniDateTimePicker(
                              context: context,
                              type: OmniDateTimePickerType.dateAndTime,
                              is24HourMode: false,
                              isShowSeconds: false,
                              startInitialDate: DateTime.now(),
                              startFirstDate: DateTime(2010),
                              startLastDate: DateTime(2030),
                              borderRadius: const Radius.circular(16),
                            );
                            if (newDate != null) {
                              context
                                  .read<EventCubit>()
                                  .saveSelectedDate(newDate);
                            }
                          },
                          child: Text(state.dateTime.year != 0
                              ? state.dateTime.toString()
                              : "Select date")),
                      ElevatedButton(
                              onPressed: () => context.read<EventCubit>().createEvent(),
                              child: const Text("Save"))
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
