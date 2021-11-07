class BillCustomer {
  final String name;
  final String? address;
  final String mobile;
  final String? mail;

  const BillCustomer({
    required this.name,
    required this.mobile,
    this.address,
    this.mail
  });
}
