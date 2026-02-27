import 'package:flutter/material.dart';
import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'qr_scanner_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Color gold = const Color(0xFFD4AF37);
  late Timer _timer;
  Duration _duration = const Duration(hours: 2, minutes: 45, seconds: 0);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds > 0) {
        setState(() {
          _duration -= const Duration(seconds: 1);
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inHours)}:${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true, pinned: true,
            title: _buildSearchBar(),
            backgroundColor: Colors.black, elevation: 0,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 10),
              _buildCarousel(),
              const SizedBox(height: 20),
              _buildFlashDealsHeader(), // هنا المؤقت الجديد
              _buildCategoryGrid(),
              const SizedBox(height: 100),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildFlashDealsHeader() {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.redAccent.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.bolt, color: Colors.redAccent),
          const SizedBox(width: 8),
          const Text("عروض تنتهي خلال:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(5)),
            child: Text(_formatDuration(_duration), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 45,
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        decoration: InputDecoration(
          hintText: "بحث في فلكس يمن...",
          prefixIcon: Icon(Icons.search, color: gold),
          suffixIcon: Icon(Icons.qr_code_scanner, color: gold),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(height: 160, autoPlay: true, enlargeCenterPage: true),
      items: [1,2].map((i) => Container(color: Colors.white10, child: Center(child: Text("بنر إعلاني $i")))).toList(),
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.count(
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2, padding: const EdgeInsets.all(15), mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1.5,
      children: [
        _catBox("سوبر ماركت", Colors.blue),
        _catBox("إلكترونيات", Colors.green),
      ],
    );
  }

  Widget _catBox(String title, Color col) {
    return Container(
      decoration: BoxDecoration(color: col.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
      child: Center(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
    );
  }
}
