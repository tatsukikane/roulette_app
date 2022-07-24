import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roulette_app/splash_screen.dart';

import 'cheat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CheatRoulette',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Hangover Tomorrow...'),
      // home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //audioplayers用定義
  final audioPlayer = AudioPlayer();
  bool isPlaying = false; //再生中かどうか
  Duration duration = Duration.zero; //bgmの長さ
  Duration position = Duration.zero; //現在再生位置
  var isPlayingnum = 1;  //loopをするとisPlayingがバグる為代替、2の倍数だったら再生状態。

  //---------------------------------------------
  var target = "";
//各変数
  //画面に表示する要素のインデックス番号を格納
  int index = 0;
  //ルーレットの起動有無フラグ
  bool isStart = false;
  //Timerオブジェクトを格納する ?
  var timer;
  //ルーレットに選択肢として追加した要素を格納しておく配列
  List<String> elem = [];
  //要素にチェックが入っているかをboolで格納しておく配列 ?
  List<bool> checkBox = [];
  //チェックボックスで選択されている要素を格納する配列
  List<String> checkedElem = [];
  //画面上部に表示する要素を格納する タイトル
  String displayWord = 'Roulette';
  //テキストフィールドにアクセスするためのコントローラー
  TextEditingController addController = TextEditingController();

  //audioplayers処理----------------------------------------
  @override
  void initState() {
    super.initState();
    // setAudio();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
     });
  }
  @override
  void dispose() {
    audioPlayer.dispose();

    super.dispose();
  }
  //--------------------------------------------------

//関数
  //スタートボタン関数
  void startTimer(){
    if (elem.length > 0 && checkedElem.length > 1){
      isStart = !isStart;
      if(isStart){
        timer = Timer.periodic(Duration(milliseconds: 100), onTimer);
      }else if(!isStart && target != ""){
        timer.cancel();
        displayWord = target;
        setState(() {
        });
        //ターゲットリセット
        target = '';
      } else{
        //setStateは、StatefulWidget の「状態」を管理する State に対して、
        //その状態が変化したことを教えて画面の再描画を依頼する
        setState(() {
          timer.cancel();
        });
      }
    }
  }

  //ルーレット起動後、名前が常に入れ替わって表示される関数
  void onTimer(Timer timer){
    setState(() {
      index++;
      //リスト内の名前の数を超えたらリセット。1からスタート
      if(index > checkedElem.length -1){
        index = 0;
      }
      //ここにルーレット起動中の参加者の名前が常に代入されていく
      displayWord = checkedElem[index];
    });
  }

  //選択肢を追加した時の処理
  void addElem(){
    if (addController.text != '' && !isStart){
      setState(() {
        elem.add(addController.text);
        checkBox.add(true);
        checkedElem.add(addController.text);
        addController.text = '';
      });
    }
  }


  // Stream<void> get onPlayerComplete =>
  //   _platform.completeStream.filter(playerId);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(66, 65, 64, 1),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.title,
            style: GoogleFonts.shadowsIntoLight(
              textStyle: TextStyle(
                fontSize: 32
            )),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Expandedは、RowやColumnの子Widget間の隙間を目一杯埋めたい時に使う
            Expanded(
              flex: 5,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/newlogo.png'),
                  fit: BoxFit.cover,
                )),
                width: double.infinity,
                // color: Colors.blue,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 104.0),
                    child: Text(
                      displayWord,
                      style: GoogleFonts.secularOne(
                        textStyle: TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.bold
                      )),

                      // style: TextStyle(
                      //   fontWeight: FontWeight.bold,
                      //   fontSize: 40,
                      //   // color: Colors.black
                      // ),
                    ),
                  ),
                ),
              ),
            ),
            //ここに非表示の入力欄を作る
            // Expanded(
            //   flex: 1,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Icon(
            //           Icons.outlet,
            //           color: Colors.green,
            //           size: 40,
            //         ),
            //       ),
            //     ],
            //   )),
            Container(
              color: Color.fromRGBO(66, 65, 64, 1),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //要素追加欄左のアイコン
                  Expanded(
                    child: IconButton(
                      icon: Icon(
                        // Icons.flutter_dash,
                        Icons.touch_app,
                        color: Colors.white
                      ),
                      onPressed: () async {
                        var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheatPage(),
                          ),
                        );
                        if(result != null){
                          target = result;
                        }
                        print(target);
                      },
)
                  ),
                  //要素入力欄
                  Expanded(
                    flex: 5,
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                      controller: addController,
                      decoration: InputDecoration(
                        // fillColor: Colors.white,
                        // filled: true,
                        // contentPadding: EdgeInsets.all(4), 
                        //input欄の薄い文字
                        hintText: 'メンバーを追加',
                        hintStyle: TextStyle(color: Colors.white),
                        // border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  //要素追加ボタン
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size.fromHeight(42),
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      // style: ButtonStyle(
                      //   backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(66, 65, 64, 1)),
                      // ),
                      onPressed: (){
                        addElem();
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: Color.fromRGBO(66, 65, 64, 1),
                          fontSize: 28,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 下の項目表示欄
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                // color: Colors.blue[100],
                color: Color.fromRGBO(66, 65, 64, 0.4),
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListView.builder(
                          //listviewで表示させる数
                          itemCount: checkBox.length,
                          //itemBuilderプロパティで返すWidgetを複数生成する
                          itemBuilder: (BuildContext context, int index){
                            return CheckboxListTile(
                              activeColor: Color.fromRGBO(66, 65, 64, 1),
                              value: checkBox[index],
                              title: Text(
                                //追加された項目を表示
                                elem[index],
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.white
                                ),
                              ),
                              //チェックボックスを先頭に配置を変更
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (val){
                                //スタートしていなければ。 ルーレットが回っている間は編集不可にしている
                                if(!isStart){
                                  setState(() {
                                  checkBox[index] = val!;
                                  if (val){
                                    //チェックした項目を追加
                                    checkedElem.add(elem[index]);
                                  } else{
                                    //チェックした項目を削除
                                    checkedElem.remove(elem[index]);
                                  }
                                  // チェックした選択肢を追加、削除した際にはRangeErrorを回避するために一旦結果表示をリセット
                                  //RangeError オブジェクトは、値が配列内に存在しない、または値が許容範囲にない場合のエラーを表す
                                  displayWord = 'Roulette';
                                  });
                                }
                              },
                            );
                          }
                        )
                      )
                    ],
                  ),
                ),
              ))
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(66, 65, 64, 1),
        //スタートされたら、ボタンの色変える。ストップしたら戻る
        child: isStart == true
          ? Icon(
            Icons.whatshot,
            color: Colors.pink,
          )
          : Icon(Icons.whatshot),
        onPressed:() async{
          isPlayingnum += 1;
          print(isPlayingnum);
          //BGM用
          if (isPlayingnum % 2 != 0){
            print('ポーズ');
            await audioPlayer.pause();
          }else{
            print('スタート');
            audioPlayer.setReleaseMode(ReleaseMode.LOOP);
            final player = AudioCache(prefix: 'assets/');
            final url = await player.load('roulette_bgm.mp3');
            await audioPlayer.play(url.path, isLocal: true);
          }
          //-------------------------------------
          startTimer();
        },
      ),

    );
  }
}
