import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class CheatPage extends StatefulWidget {
  const CheatPage({Key? key}) : super(key: key);

  @override
  State<CheatPage> createState() => _CheatPageState();
}

class _CheatPageState extends State<CheatPage> {
  @override
  Widget build(BuildContext context) {
    final receive = "";
    var name = "";


    return WillPopScope(
      onWillPop: () {
        // 第2引数に渡す値を設定
        Navigator.pop(context,);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(66, 65, 64, 1),
          title: Text(
            "Let's Prank",
            style: GoogleFonts.shadowsIntoLight(
              textStyle: TextStyle(
              fontSize: 32
            )),
          ),
        ),
        body: Container(
          width: double.infinity,
          color: Color.fromRGBO(66, 65, 64, 0.8),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                'ターゲット選択👿',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                'ルーレットで当選させたい名前を入力してください',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white
                ),
              ),
              SizedBox(height: 8),
              Text(
                // textAlign: TextAlign.center,
                '※ルーレット画面(トップ画面)で入力した名前と、異なる名前で登録するとバレる危険性があります。\n※ターゲットの設定はルーレットを回す度にリセットされます。',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Container(
                width: 240,
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: 24),
                  decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  ),
                    // border: InputBorder.none,
                    hintText: 'ターゲット名',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  onChanged: (text){
                    name = text;
                    // print(text);
                  },
                ),
              ),
              SizedBox(
                height: 24,
              ),
              // TextButton(
              //   child: Text('Return'),
              //   onPressed: () =>
              //   Navigator.of(context).pop(name),
              // ),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(66, 65, 64, 1), //ボタンの背景色
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    shadowColor: Colors.black,
                    elevation: 16,
                  ),
                  onPressed: () {
                    //ボタンを押したときの挙動
                    Navigator.of(context).pop(name);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),


            ],
          ),
        ),
      ),
    );
  }
}