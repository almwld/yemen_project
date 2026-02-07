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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text('اختر خدمة التوصيل المفضلة لديك:', 
            style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Container(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemCount: yemenDeliveryOptions.length,
            itemBuilder: (context, index) {
              final service = yemenDeliveryOptions[index];
              bool isSelected = selectedId == service.id;
              return GestureDetector(
                onTap: () => setState(() => selectedId = service.id),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 150,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.amber.withOpacity(0.2) : Colors.white10,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: isSelected ? Colors.amber : Colors.transparent, width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(service.icon, style: TextStyle(fontSize: 30)),
                      SizedBox(height: 10),
                      Text(service.name, textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                      Text(service.price, style: TextStyle(color: Colors.amber, fontSize: 12)),
                      Text(service.estimatedTime, style: TextStyle(color: Colors.white54, fontSize: 10)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
