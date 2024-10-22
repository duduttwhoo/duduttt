//memasukkan oackage yang dibutuhkan oleh aplikasi
import 'package:english_words/english_words.dart'; //paket bahasa inggris
import 'package:flutter/material.dart'; //paket untuk tampilan ui(material ui)
import 'package:provider/provider.dart'; //paket untuk interaksi aplikasi

void main() {
  runApp(MyApp());
}


//membuat abstrak apliasi dari statelesswidget (template aplikasi),aplikasinya bernama myapp
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // menunjukkan bahwa aplikasi ini akan tetap,tidak berubah setelah dibuild

  @override //mengganti nilai lama yang sudah ada ditemplate,mengganti dengan nilai nilai yang baru (replace/overwrite)
  Widget build(BuildContext context) { //fungsi build adalah fungsi yg membangun ui (mengatur posisi widget,dst)
  //changenotifierprovider mendengarkan/mendeteksi semua interaksi yg terjadi diapliksi
    return ChangeNotifierProvider(
      create: (context) => MyAppState(), //membuat satu state bernama myappstate
      child: MaterialApp( //pada state ini menggunakan style desain meterial ui 
        title: 'Namer App', //deiberi judul name app
        theme: ThemeData( //data tema aplikasi ,diberi warna deeporange
          useMaterial3: true, //versi material ui yang dipakai versi 3
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 34, 203, 255)),
        ),
        home: MyHomePage(),//nama halaman "myhomepage" yang menggunakan state "myappstate".
      ),
    );
  }
}
// mendifinisikan myappstate
class MyAppState extends ChangeNotifier {
  //state myappstate diisi dengan 2 kata random yg digabung ,kata random tersebut disimpan divariable wordpair
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}
//membuat layout pada halaman homepage
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;// variabel pair menyimpan data yang sedang tampil
    //dibawah ini adalah kode program untuk menyusun layout 
    return Scaffold( //base (canvas) dari layout
      body: Center(
        child: Column( //diatas scaffold,ada body . bodynya diberi kolom 
        mainAxisAlignment: MainAxisAlignment.center,
          children: [ //didalam kolom diberi text 
            Text('A random AWESOME idea:'),
            BigCard(pair: pair), //mengambil random card dari appstate pada variable wordpair current,lalu diubah menjadi huruf kecil semua,dan ditampilkan sebagai teks
        
            ElevatedButton(
              onPressed: () {
                appState.getNext();
              },
              child: Text('Next'), //berkan text 'Next' pada button (sebagai child)
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),


        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}