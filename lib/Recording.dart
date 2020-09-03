import 'package:audio_recorder/audio_recorder.dart' as ARecord;
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'dart:io';
import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

void main(){
  runApp(new AudioRecording());
}
class AudioRecording extends StatefulWidget{
  @override
  _AudioRecordingState createState() => new _AudioRecordingState();
}

class _AudioRecordingState extends State<AudioRecording> {
  bool _isRecording = false;
  bool _isPlaying = false;
  StreamSubscription _recorderSubscription;
  StreamSubscription _dbPeakSubscription;
  StreamSubscription _playerSubscription;
  FlutterSound flutterSound;

  String _recorderTxt = "00:00:00";
  String _playerTxt = "00:00:00";
  double _dbLevel;

  double slider_current_position = 0.0;
  double max_duration = 1.0;

  @override
  void initState() {
    super.initState();
    flutterSound = new FlutterSound();
    flutterSound.setSubscriptionDuration(0.01);
    flutterSound.setDbPeakLevelUpdate(0.8);
    flutterSound.setDbLevelEnabled(true);
    initializeDateFormatting();
  }

  void startRecorder() async {
    try {
      String path = await flutterSound.startRecorder();
      print("start Recorder $path");

      _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
        DateTime date = new DateTime.fromMicrosecondsSinceEpoch(
            e.currentPosition.toInt(),
            isUtc: true);
        String txt = DateFormat('mm:ss:SS', 'pt_BR').format(date);
        this.setState(() {
          this._recorderTxt = txt.substring(0, 8);
        });
      });

      _dbPeakSubscription =
          flutterSound.onRecorderDbPeakChanged.listen((value) {
            print("go update value-> $value");
            setState(() {
              this._dbLevel = value;
            });
          });

      this.setState(() {
        this._isRecording = true;
      });
    } catch (err) {
      print("Start recorder error : $err");
    }
  }

  void stopRecorder() async{
    try{
      String result = await flutterSound.stopRecorder();
      print("Stop recorder: $result");

      if(_recorderSubscription != null){
        _recorderSubscription.cancel();
        _recorderSubscription = null;
      }
      if(_dbPeakSubscription != null){
        _dbPeakSubscription.cancel();
        _dbPeakSubscription = null;
      }
      setState(() {
        this._isRecording = false;
      });
    }catch (err){
      print("Stop recording err $err");
    }
  }

  void startPlayer() async {
    String path = await flutterSound.startPlayer(null);
    await flutterSound.setVolume(1.0);
    print("Start player: $path");

    try {
      _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
        if (e != null) {
          slider_current_position = e.currentPosition;
          max_duration = e.duration;
          DateTime date = new DateTime.fromMicrosecondsSinceEpoch(
              e.currentPosition.toInt(),
              isUtc: true
          );
          String txt = DateFormat("mm:ss:SS", "pt_BR").format(date);
          this.setState(() {
            this._isPlaying = true;
            this._playerTxt = txt.substring(0, 8);
          });
        }
      });
    } catch (err) {
      print("Start Player error $err");
    }
  }

  void stopPlayer() async{
    try{
      String result = await flutterSound.stopPlayer();
      print("stop play: $result");
      saveToAudioFile(result);
      if(_playerSubscription != null){
        _playerSubscription.cancel();
        _playerSubscription = null;
      }
      this.setState((){
        this._isPlaying = false;
      });
    }catch (err){
      print("Stop player err $err");
    }
  }

  void pausePlayer() async{
    String result = await flutterSound.pausePlayer();
    print("Pausing player: $result");
  }
  void resumePlayer() async{
    String result = await flutterSound.resumePlayer();
    print("Resuming player: $result");
  }
  void seekToPlay(int millSec) async{
    String result = await flutterSound.seekToPlayer(millSec);
    print("Seek player $result");
  }

  var recorder;
  void audioRecordingStart() async{
    // Check permissions before starting
    bool hasPermissions = await ARecord.AudioRecorder.hasPermissions;
    if(hasPermissions) {
// Get the state of the recorder
      bool isRecording = await ARecord.AudioRecorder.isRecording;

// Start recording
      recorder = await ARecord.AudioRecorder.start(
          path: "sound1", audioOutputFormat: ARecord.AudioOutputFormat.AAC);
//      ARecord.Recording recording = await recorder.stop();
//      print("Path : ${recording.path},  Format : ${recording.audioOutputFormat},  Duration : ${recording.duration},  Extension : ${recording.extension},");

    }
  }
  void audioRecordingStop() async{
    // Stop recording
    ARecord.Recording recording = await recorder.stop();
    print("Path : ${recording.path},  Format : ${recording.audioOutputFormat},  Duration : ${recording.duration},  Extension : ${recording.extension},");

  }

  void flutterRecorderStart() async{
    try {
      print("Recording started");
      bool hasPermission = await FlutterAudioRecorder.hasPermissions;
      DateTime date = new DateTime.now();
      String fileTime = DateFormat("mm:ss:SS", "pt_BR").format(date);
      recorder = FlutterAudioRecorder(
          "Sound_1.wav", audioFormat: AudioFormat.AAC, sampleRate: 16000);
      recorder.initialized;
      await recorder.start();
      var recording = await recorder.current(channel: 0);
    } catch(e){
      print("Error "+e.toString());
    }
  }
  void flutterRecorderPause() async{
    recorder.pause();
  }
  void flutterRecorderResume() async{
    recorder.resume();
  }
  void flutterRecorderStop() async{
    var recording = await recorder.stop();
    print("Stop recording");
    print("Path : ${recording.path},  Format : ${recording.audioOutputFormat},  Duration : ${recording.duration},  Extension : ${recording.extension},");
    saveToAudioFile(recording);
  }
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print("path "+directory.path);
    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/Sound_1.wav');
  }
  Future<File> saveToAudioFile(var result) async {
    final file = await _localFile;
    print("Save recording to $file");
    // Write the file.
    return file.writeAsString(result.path);
  }

  Future<int> getAudioFileContent() async {
    try {
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0.
      return 0;
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Audio Recorder"),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top:24.0,bottom: 16.0),
                  child: Text(
                    this._recorderTxt,
                    style: TextStyle(
                      fontSize: 48.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                _isRecording
                    ? LinearProgressIndicator(
                  value: 100.0/160.0 * (this._dbLevel??1)/100,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ) : Container()
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 56.0,
                  height: 56.0,
                  margin: EdgeInsets.all(10.0),
                  child: FloatingActionButton(
                    onPressed: (){
                      startPlayer();
                    },
                    heroTag: 'btnPlay',
                    child: Icon(Icons.pause),
                  ),
                ),Container(
                  width: 56.0,
                  height: 56.0,
                  margin: EdgeInsets.all(10.0),
                  child: FloatingActionButton(
                    onPressed: (){
                      audioRecordingStart();
                    },
                    heroTag: 'btnStartRecord',
                    child: Icon(Icons.keyboard_voice),
                  ),
                ),Container(
                  width: 56.0,
                  height: 56.0,
                  margin: EdgeInsets.all(10.0),
                  child: FloatingActionButton(
                    onPressed: (){
                      audioRecordingStop();
                    },
                    heroTag: 'btnStopRecord',
                    child: Icon(Icons.stop),
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
            Container(
              height: 56.0,
              child: Slider(
                value: slider_current_position,
                min: 0.0,
                max: max_duration,
                onChanged: (double value) async{
                  await flutterSound.seekToPlayer(value.toInt());
              },
                divisions: max_duration.toInt()
              )
              ),
          ],
        ),
      )
    );
  }
}