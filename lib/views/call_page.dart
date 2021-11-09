// import 'dart:async';

// import 'package:advisories_lawyer/utils/utils.dart';
// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// class CallPage extends StatefulWidget {
//   CallPage({this.channelName, Key? key}) : super(key: key);
//   var channelName;

//   @override
//   _CallPageState createState() => _CallPageState();
// }

// class _CallPageState extends State<CallPage> {
//   static final _users = <int>[];
//   final _infoStrings = <String>[];
//   bool muted = false;
//   late RtcEngine _engine;
  
//   bool _joined = false;
//   int _remoteUid = 0;
//   bool _switch = false;

//    @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   Future<void> initPlatformState() async {
//     await [Permission.camera, Permission.microphone].request();

//     if(appID.isEmpty) {
//       setState(() {
//         _infoStrings.add(
//           'APP_ID missing, please provide your APP_ID in settings.dart',
//         );
//         _infoStrings.add('Agora Engine is not starting');
//       });
//       return;
//     }

//     await _initAgoraRtcEngine();
//      _addAgoraEventHandlers();
//     await _engine.joinChannel(null, widget.channelName, null, 0);
//   }

//   Future<void> _initAgoraRtcEngine() async {
//     _engine = await RtcEngine.create(appID);
//     await _engine.enableVideo();
//   }

//   void _addAgoraEventHandlers() {
//     _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
//       setState(() {
//         final info = 'onError: $code';
//         _infoStrings.add(info);
//       });
//     }, joinChannelSuccess: (channel, uid, elapsed) {
//       setState(() {
//         final info = 'onJoinChannel: $channel, uid: $uid';
//         _infoStrings.add(info);
//         _joined = true;
//       });
//     }, leaveChannel: (stats) {
//       setState(() {
//         _infoStrings.add('onLeaveChannel');
//         _users.clear();
//       });
//     }, userJoined: (uid, elapsed) {
//       setState(() {
//         final info = 'userJoined: $uid';
//         _infoStrings.add(info);
//         _users.add(uid);
//          _remoteUid = uid;
//       });
//     }, userOffline: (uid, elapsed) {
//       setState(() {
//         final info = 'userOffline: $uid';
//         _infoStrings.add(info);
//         _users.remove(uid);
//         _remoteUid = 0;
//       });
//     }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
//       setState(() {
//         final info = 'firstRemoteVideo: $uid ${width}x $height';
//         _infoStrings.add(info);
//       });
//     }));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Advisory Lawyer'),
//         ),
//         body: Stack(
//           children: [
//             Center(
//               child: _switch ? _renderRemoteVideo() : _renderLocalPreview(),
//             ),
//             Align(
//               alignment: Alignment.topLeft,
//               child: Container(
//                 width: 100,
//                 height: 100,
//                 color: Colors.blue,
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _switch = !_switch;
//                     });
//                   },
//                   child: Center(
//                     child:
//                     _switch ? _renderLocalPreview() : _renderRemoteVideo(),
//                   ),
//                 ),
//               ),
//             ),
//             _panel(),
//             _toolbar(),
//           ],
//         ),
//       ),
//     );
//   }
//  // Local preview
//   Widget _renderLocalPreview() {
//     if (_joined) {
//       return RtcLocalView.SurfaceView();
//     } else {
//       return Text(
//         'Please join channel first',
//         textAlign: TextAlign.center,
//       );
//     }
//   }

//   // Remote preview
//  Widget _renderRemoteVideo() {
//     if (_remoteUid != 0) {
//       return RtcRemoteView.SurfaceView(
//         uid: _remoteUid,
//         // channelId: "123",
//       );
//     } else {
//       return Text(
//         'Please wait remote user join',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
  
//   Widget _panel() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 48),
//       alignment: Alignment.bottomCenter,
//       child: FractionallySizedBox(
//         heightFactor: 0.5,
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 48),
//           child: ListView.builder(
//             reverse: true,
//             itemCount: _infoStrings.length,
//             itemBuilder: (BuildContext context, int index) {
//               if (_infoStrings.isEmpty) {
//                 return Text(
//                     "null"); // return type can't be null, a widget was required
//               }
//               return Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 3,
//                   horizontal: 10,
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Flexible(
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 2,
//                           horizontal: 5,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.yellowAccent,
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: Text(
//                           _infoStrings[index],
//                           style: TextStyle(color: Colors.blueGrey),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _toolbar() {
//     return Container(
//       alignment: Alignment.bottomCenter,
//       padding: const EdgeInsets.symmetric(vertical: 48),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           RawMaterialButton(
//             onPressed: _onToggleMute,
//             child: Icon(
//               muted ? Icons.mic_off : Icons.mic,
//               color: muted ? Colors.white : Colors.blueAccent,
//               size: 20.0,
//             ),
//             shape: CircleBorder(),
//             elevation: 2.0,
//             fillColor: muted ? Colors.blueAccent : Colors.white,
//             padding: const EdgeInsets.all(12.0),
//           ),
//           RawMaterialButton(
//             onPressed: () => _onCallEnd(context),
//             child: Icon(
//               Icons.call_end,
//               color: Colors.white,
//               size: 35.0,
//             ),
//             shape: CircleBorder(),
//             elevation: 2.0,
//             fillColor: Colors.redAccent,
//             padding: const EdgeInsets.all(15.0),
//           ),
//           RawMaterialButton(
//             onPressed: _onSwitchCamera,
//             child: Icon(
//               Icons.switch_camera,
//               color: Colors.blueAccent,
//               size: 20.0,
//             ),
//             shape: CircleBorder(),
//             elevation: 2.0,
//             fillColor: Colors.white,
//             padding: const EdgeInsets.all(12.0),
//           )
//         ],
//       ),
//     );
//   }

//   void _onSwitchCamera() {
//     _engine.switchCamera();
//   }

//   void _onToggleMute() {
//     setState(() {
//       muted = !muted;
//     });
//     _engine.muteLocalAudioStream(muted);
//   }

//   void _onCallEnd(BuildContext context) {
//     Navigator.pop(context);
//   }
// }
