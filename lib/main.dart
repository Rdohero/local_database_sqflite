import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locak_database_sqflite/create.dart';
import 'package:locak_database_sqflite/database_instance.dart';
import 'package:locak_database_sqflite/model/product_model.dart';
import 'package:locak_database_sqflite/update.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseInstance? databaseInstance;

  Future _refresh() async {
    setState(() {
    });
  }

  Future initDatabase () async {
    await databaseInstance!.database();
    setState(() {
    });
  }

  Future delete(int id) async {
    await databaseInstance!.delete(id);
  }


  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Local Database'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const CreateScreen())?.then((value){
                setState(() {
                });
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: databaseInstance != null ? FutureBuilder<List<ProductModel>?>(
          future: databaseInstance!.all(),
          builder: (context, snapshot){
            if(snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text("Data Masih Kosong."),);
              }
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      onDismissed: (direction) async {
                        await delete(snapshot.data![index].id!);
                        setState(() {
                          snapshot.data!.removeAt(index);
                        });
                      },
                      key: Key(snapshot.data![index].id.toString()),
                      background: deleteBgItem()  ,
                      child: ListTile(
                        title: Text(snapshot.data![index].name ?? ''),
                        subtitle: Text(snapshot.data![index].category ?? ''),
                        trailing: IconButton(
                          onPressed: (){
                            Get.to(() => UpdateScreen(
                              productModel: snapshot.data![index],
                            ))?.then((value){
                              setState(() {
                              });
                            });
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                    );
                  }
              );
            } else {
              return const Center(child: CircularProgressIndicator(color: Colors.green,),);
            }
          },
        ) : const Center(child: CircularProgressIndicator(color: Colors.green,),),
      ),
    );
  }
}

Widget deleteBgItem() {
  return Container(
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.only(right: 20),
    color: Colors.red,
    child: const Icon(Icons.delete, color: Colors.white,),
  );
}
