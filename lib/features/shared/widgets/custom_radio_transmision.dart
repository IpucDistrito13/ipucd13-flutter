import 'package:flutter/material.dart';
import '../../public/screen/screens.dart';

class CustomRadioTransmision extends StatelessWidget {
  const CustomRadioTransmision({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'En Vivo',
                  style: TextStyle(
                    fontFamily: 'MyriamPro',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    _buildRadioSection(context),
                    const SizedBox(width: 15),
                    _buildTransmisionSection(context),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RadioScreen(),
              ),
            );
          },
          child: ClipOval(
            child: Image.asset(
              'assets/images/radio_ipuc.png',
              fit: BoxFit.cover,
              height: 120,
              width: 120,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTransmisionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TransmisionScreen(),
              ),
            );
          },
          child: ClipOval(
            child: Image.asset(
              'assets/gif/transmision_en_vivo.gif',
              fit: BoxFit.cover,
              height: 120,
              width: 120,
            ),
          ),
        ),
      ],
    );
  }
}
