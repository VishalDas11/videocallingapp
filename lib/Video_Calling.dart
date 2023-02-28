import 'package:flutter/material.dart';
import 'package:videocallingapp/utils.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'dart:math' as math;

final String localUserID = math.Random().nextInt(10000).toString();


class VideoCalling extends StatefulWidget {
  const VideoCalling({Key? key}) : super(key: key);

  @override
  State<VideoCalling> createState() => _VideoCallingState();
}

class _VideoCallingState extends State<VideoCalling> {

  final _callingId  = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _callingId,
              decoration: const InputDecoration(
                hintText: "Enter Call Id",
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CallPage(callingId: _callingId.text.toString(),)));
            }, child: Text("Call"))
          ],
        ),
      ),
    );
  }
}

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callingId}) : super(key: key);

  final String callingId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ZegoUIKitPrebuiltCall(
          appID: Utils.appId,
          appSign: Utils.appSignIn,
          callID: callingId,
          userID: localUserID,
          userName: 'user_$localUserID',
          config: ZegoUIKitPrebuiltCallConfig.groupVideoCall()
          ..onOnlySelfInRoom = (context){
            Navigator.pop(context);
          },

        )
    );
  }
}

