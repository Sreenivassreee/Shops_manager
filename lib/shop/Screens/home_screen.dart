import 'package:shops_manager/export.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int data = 21;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(title: 'Stock'),
      bottomSheet: Container(
          height: 120,
          child: Column(
            children: [
              btn(
                btnTitle: "TODAY SALES",
                action: () {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tBtn(
                    btnTitle: "TODAY EXCHANGES",
                    action: () {},
                  ),
                  tBtn(
                    btnTitle: "ACCEPT EXCHANGE",
                    action: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => AcceptExchange(),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          )),
      body: Container(
        height: MediaQuery.of(context).size.height - 210,
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: data + 3,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return data > index
                ? InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ProductScreen(),
                        ),
                      );
                    },
                    child: new Card(
                      elevation: 0,
                      child: Center(
                        child: Text("MI +$index"),
                      ),
                    ),
                  )
                : Container(
                    child: SizedBox(
                      height: 100,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
