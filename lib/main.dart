import 'dart:async';
import 'package:flutter/material.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  String displayWord = 'CheatRoulette';
  //テキストフィールドにアクセスするためのコントローラー
  TextEditingController addController = TextEditingController();

//関数
  //スタートボタン関数
  void startTimer(){
    if (elem.length > 0 && checkedElem.length > 1){
      isStart = !isStart;
      if(isStart){
        timer = Timer.periodic(Duration(milliseconds: 100), onTimer);
      }else{
        //setStateは、StatefulWidget の「状態」を管理する State に対して、
        //その状態が変化したことを教えて画面の再描画を依頼する
        setState(() {
          timer.cancel();
        });
      }
    }
  }

  //ルーレット起動中の関数?
  void onTimer(Timer timer){
    setState(() {
      index++;
      if(index > checkedElem.length -1){
        index = 0;
      }
      //ここにelseifを入れればチート機能いけそう
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Expandedは、RowやColumnの子Widget間の隙間を目一杯埋めたい時に使う
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    displayWord,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      // color: Colors.black
                    ),
                  ),
                ),
              ),
            ),
            //ここに非表示の入力欄を作る
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Icon(
                      Icons.outlet,
                      color: Colors.green,
                      size: 40,
                    ),
                  ),
                ],
              )),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //要素追加欄左のアイコン
                Expanded(
                  child: Icon(
                    Icons.flutter_dash,
                    color: Colors.blue,
                    size: 40,
                  ),
                ),
                //要素入力欄
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: addController,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.all(4), 
                      //input欄の薄い文字
                      hintText: '追加項目を入力',
                      // border: OutlineInputBorder(),
                    ),
                  ),
                ),
                //要素追加ボタン
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: (){
                      addElem();
                    },
                    child: Text('Add'),
                  ),
                ),
              ],
            ),
            // 下の項目表示欄
            Expanded(
              flex: 6,
              child: Container(
                width: double.infinity,
                color: Colors.blue[100],
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
                              value: checkBox[index],
                              title: Text(
                                //追加された項目を表示
                                elem[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
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
        //スタートされたら、ボタンの色変える。ストップしたら戻る
        child: isStart == true
          ? Icon(
            Icons.whatshot,
            color: Colors.pink,
          )
          : Icon(Icons.whatshot),
        onPressed:(){
          startTimer();
        },
      ),

    );
  }
}
