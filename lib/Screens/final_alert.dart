import '../export.dart';

class FinalAlert extends StatelessWidget {
  const FinalAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: btn(
        btnTitle: "PAID",
        action: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Homepage(),
            ),
          );
        },
      ),
      body: ListView(
        children: [
          TitleText(
            title: "Final Alert",
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "MI Note 10 2gb 64gb",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Total Amount 10,000/-",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "1234",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    // controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Code',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
