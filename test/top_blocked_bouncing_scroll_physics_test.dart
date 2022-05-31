import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_top_blocked_bouncing_scroll_physics/flutter_top_blocked_bouncing_scroll_physics.dart';

void main() {
  const ScrollPhysics physics = AlwaysScrollableScrollPhysics(
    parent: TopBlockedBouncingScrollPhysics(),
  );
  const double singleElementHeight = 40;

  Future<void> pumpList(
    WidgetTester tester,
    ScrollController controller,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            controller: controller,
            physics: physics,
            children: const [
              SizedBox(
                height: singleElementHeight,
                child: Text('Going Inside'),
              ),
              SizedBox(
                height: singleElementHeight,
                child: Text('Ramparts'),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets(
    "Doesn't over-scroll on top side",
    (tester) async {
      final controller = ScrollController();
      await pumpList(tester, controller);

      await tester.dragFrom(
        const Offset(singleElementHeight, singleElementHeight),
        const Offset(singleElementHeight, singleElementHeight * 2),
      );

      expect(controller.position.pixels, 0);

      controller.dispose();
    },
  );

  testWidgets(
    "Over-scrolls on bottom side",
    (tester) async {
      final controller = ScrollController();

      await pumpList(tester, controller);

      await tester.dragFrom(
        const Offset(singleElementHeight, 0),
        const Offset(singleElementHeight, singleElementHeight * -4),
      );

      expect(controller.position.pixels, greaterThan(singleElementHeight * 2));

      controller.dispose();
    },
  );
}
