import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('MediaQuery Example'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

final List<String> mName = <String>['Hung', 'Ti', 'Teo'];
final mColor = [Colors.blue, Colors.red, Colors.green, Colors.yellow];
bool isPortrait = false;
String thongTin = '';

class DanhSach extends StatelessWidget {
  final Function(String) onItemSelected;
  const DanhSach({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    // return const Placeholder();
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: mName.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            if (isPortrait) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SecondRoute(
                          selectedName: mName[index],
                        )),
              );
            } else {
              onItemSelected(mName[index]);
            }
            // // Xử lý sự kiện nhấn vào mục này
            // print('Đã nhấn vào thằng ${mName[index]}');
            // // Ví dụ: Hiển thị một SnackBar
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text('Đã nhấn vào thằng ${mName[index]}'),
            //   ),
            // );
          },
          child: Container(
            height: 50,
            color: mColor[index],
            child: Center(child: Text('thằng ${mName[index]}')),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Kiểm tra màn hình đang ở chế độ nào
    isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (isPortrait) {
          return DanhSach(
            onItemSelected: (String value) {
              setState(() => thongTin = value);
            },
          );
        } else {
          return Row(
            children: [
              Container(
                width: 250, // Chiều rộng cố định cho sidebar
                child: DanhSach(
                  onItemSelected: (String value) {
                    setState(() => thongTin = value);
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.yellow,
                  child: Center(child: Text('Đã nhấn vào thằng $thongTin')),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

// class FirstRoute extends StatelessWidget {
//   const FirstRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('First Route'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: const Text('Open route'),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const SecondRoute()),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class SecondRoute extends StatelessWidget {
  final String? selectedName;

  const SecondRoute({super.key, this.selectedName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(children: [
          Center(
            child: Text('Đã nhấn vào thằng $selectedName'),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Go back!'),
          ),
        ]),
      ),
    );
  }
}
