import 'package:flutter/material.dart';
import '../styles/custom_colors.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network("https://nextgenerationtechnologies.in/uploads/page/37/flutter_logo.png", fit: BoxFit.contain, height: 40,),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: CustomColor.mainColor,
              decoration: InputDecoration(
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: CustomColor.mainColor,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(Icons.lock),
                ),
                suffix: IconButton(
                  onPressed: () {
                    //ref.read(passwordFieldProvider.notifier).state = !passwordVisibilty;
                  },
                  icon: Icon(true ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MailPage()));
                },
                child: const Text("Bejelentkezés"))
          ],
        ),
      ),
    );
  }

}