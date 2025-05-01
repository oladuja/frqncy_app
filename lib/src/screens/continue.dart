import 'package:flutter/material.dart';
import 'package:frqncy_app/src/screens/home.dart';
import 'package:group_button/group_button.dart';
import 'package:gap/gap.dart';

class SupportJourneyScreen extends StatelessWidget {
  final List<String> options = [
    "Stress & Anxiety Relief",
    "Improved Focus & Productivity",
    "Better Sleep",
    "Emotional Well-being",
    "Personal Growth & Mindfulness",
    "Pain Management",
  ];

  final GroupButtonController _controller = GroupButtonController(
    selectedIndexes: [0, 1, 2], // Pre-selected buttons
  );

  SupportJourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C0430),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Gap(20),
                Text(
                  "How can we support your journey today ?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(30),
                GroupButton(
                  controller: _controller,
                  isRadio: false,
                  buttons: options,
                  options: GroupButtonOptions(
                    selectedColor: Color(
                      0xFF2E1055,
                    ), // Always keep background consistent
                    unselectedColor: Color(0xFF2E1055),
                    borderRadius: BorderRadius.circular(20),
                    spacing: 15,
                    runSpacing: 15,
                    selectedTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                    unselectedTextStyle: TextStyle(color: Colors.white70),
                    buttonHeight: 60,
                    buttonWidth: double.infinity,
                    alignment: Alignment.centerLeft,
                    textAlign: TextAlign.start,
                    elevation: 0,
                  ),
                  buttonBuilder: (selected, value, context) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),

                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            value,
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.white70,
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color:
                                  selected
                                      ? Color(0XFF53932D)
                                      : Colors.white.withOpacity(0.05),

                              borderRadius: BorderRadius.circular(6),
                              // border: Border.all(
                              // color: selected ? Color(0xFF8A4FFF) : Colors.white30,
                              // width: 2,
                              // ),
                            ),
                            child:
                                selected
                                    ? Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.white,
                                    )
                                    : null,
                          ),
                        ],
                      ),
                    );
                  },
                  onSelected: (value, index, isSelected) {
                    print('Selected: $value | Is Selected: $isSelected');
                  },
                ),
                Gap(30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0XFF6D349E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed:
                        () => Navigator.of(
                          context,
                        ).push(MaterialPageRoute(builder: (_) => HomeScreen())),
                    child: Text(
                      "Start your Journey",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
