import 'package:shops_manager/admin/Screens/admin_same_brand_products.dart';
import 'package:shops_manager/export.dart';

class Homepage extends StatefulWidget {
  var shopName;
  var userName;
  Homepage({Key? key, this.shopName, this.userName}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int data = 21;
  var dataLength = 0;
  var shopsData;
  var shopName = '';
  var brands = [];
  var temp = [];
  var eachBrandData = [];
  Stream<QuerySnapshot>? productsStream;

  @override
  void initState() {
    super.initState();
    productsStream = FirebaseFirestore.instance
        .collection('shops')
        .doc(widget.shopName ?? "shop")
        .collection('products')
        .snapshots();
  }

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
      body: StreamBuilder<QuerySnapshot>(
        stream: productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            var docs = snapshot.data?.docs;
            shopsData = docs;
            // print(docs!.length);
            var tempAllBrands = [];
            var tempBrands = [];
            try {
              for (var i = 0; i < docs!.length; i++) {
                var brd = docs[i]['product_brand'];
                tempAllBrands.add(brd);
              }
              print(tempAllBrands);
              for (var i = 0; i < tempAllBrands.length; i++) {
                print(tempAllBrands[i]);
                if (tempBrands.contains(
                      tempAllBrands[i].toString().toLowerCase().trim(),
                    ) ==
                    false) {
                  tempBrands.add(
                    tempAllBrands[i].toString().toLowerCase().trim(),
                  );
                }
              }
              brands = tempBrands;
            } catch (e) {
              print("[Error in AdminStockProductScreen => 112]");
            }
          }

          return Container(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: brands.length + 3,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return brands.length > index
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SameBrandProducts(
                                shopName: shopName,
                                brandsData: shopsData,
                                brand: brands[index],
                              ),
                            ),
                          );
                        },
                        child: new Card(
                          elevation: 0,
                          child: Center(
                            child: Text(brands[index] ?? ""),
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
          );
        },
      ),
    );
  }
}
