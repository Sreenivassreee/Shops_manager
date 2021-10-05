import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shops_manager/export.dart';

class AcceptExchange extends StatelessWidget {
  const AcceptExchange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(title: "Accept Exchange"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              "10/10/2001",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int i) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 0.0,
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.3,
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(2),
                            color: Colors.lightBlue[50],
                            height: 70,
                            child: Center(
                              child: Text(
                                (i + 1).toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            width: 40,
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "Mi Note 2gb 64gb",
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: Text(
                                "Selling Price : 10,000/-",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      IconSlideAction(
                        caption: 'Reject',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          _showSnackBar(context, "Reject");
                        },
                      ),
                    ],
                    secondaryActions: <Widget>[
                      IconSlideAction(
                          caption: "Accept",
                          color: Colors.indigo,
                          icon: Icons.check,
                          onTap: () {
                            _showSnackBar(context, "Accept");
                          }),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }
}
