Future<void> _startSigning1() async {
  setState(() {
    _isLoading = true;
  });

  try {
    final response = await ApiService.post(
      'QContract/WA_Contract_Contract_Get',  // Replace with your actual contract update API endpoint
      body: {
        'ContractCode': widget.contract.contractCode,
        'UserSignSatus': 'CONFIRMED',
        // Add any other necessary parameters
      },
    );
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      print(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hợp đồng đã được ký thành công.'),
        ),
      );
      Navigator.pop(context);  // Navigate back after successful signing
    } else {
      // Handle API response errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Có lỗi xảy ra trong quá trình ký hợp đồng. ${response.statusCode}'),
        ),
      );
    }
  } catch (error) {
    // Handle API call errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Có lỗi xảy ra trong quá trình ký hợp đồng. $error'),
      ),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}