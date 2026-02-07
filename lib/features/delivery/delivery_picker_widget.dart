import 'package:flutter/material.dart';
import 'delivery_model.dart';

class DeliveryPicker extends StatefulWidget {
  @override
  _DeliveryPickerState createState() => _DeliveryPickerState();
}

class _DeliveryPickerState extends State<DeliveryPicker> {
  String selectedId = '1';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('اختر وسيلة التوصيل المفضلة:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        ...yemenDeliveryOptions.map((service) => RadioListTile(
          value: service.id,
          groupValue: selectedId,
          onChanged: (val) => setState(() => selectedId = val.toString()),
          title: Text(service.name, style: TextStyle(color: Colors.white)),
          subtitle: Text('السعر: ${service.price} - الوقت: ${service.estimatedTime}', style: TextStyle(color: Colors.white54)),
          secondary: Text(service.icon, style: TextStyle(fontSize: 25)),
          activeColor: Colors.amber,
        )).toList(),
      ],
    );
  }
}
