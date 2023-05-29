import 'package:dipterv/core/locator.dart';
import 'package:dipterv/route/login/login_bloc.dart';
import 'package:dipterv/route/login/login_page.dart';
import 'package:dipterv/route/profile/profile_bloc.dart';
import 'package:dipterv/services/safe_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  final safeStoreService = locator.get<SafeStoreService>();

  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  ProfileBloc get _bloc => context.read<ProfileBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          var currentState = state;
          if(currentState is ProfileLogoutState) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider(
                        create: (context) => LoginBloc()..add(LoginInitEvent()),
                        child: LoginPage(),)),
                    (route) => false);
          }
        },
        builder: (context, state) {
          var currentState = state;
          if(currentState is ProfileLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(currentState is ProfileBasicState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 80,),
                  CircleAvatar(backgroundImage: Image.network(currentState.profile!.profilePicture).image, radius: 100,),
                  SizedBox(height: 10,),
                  Text(currentState.profile!.name,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30
                  ),),
                  SizedBox(height: 5,),
                  Text(currentState.profile!.rank,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20
                  ),),
                  SizedBox(height: 30,),
                  Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.blue,),
                          SizedBox(width: 5,),
                          Text(currentState.profile!.mobileNumber,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17
                              ),
                            maxLines: 2,
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.email_outlined, color: Colors.blue,),
                          SizedBox(width: 5,),
                          Text(currentState.profile!.emailAddress,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17
                            ),
                            maxLines: 2,)
                        ],
                      ),
                    ],
                  ),),
                  SizedBox(height: 30,),
                  ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        )),
                      ),
                      onPressed:() {_bloc.add(ProfileLogoutEvent(showDialog: _showAlertDialog));},
                      child: Text('Kijelentkezés'))
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }

  Future<bool> _showAlertDialog() async {
    var returnValue = false;
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: Text('Log out'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want to log out?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                returnValue = false;
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                returnValue = true;
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            ),
          ],
        )
    );
    return returnValue;
  }
}