import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/in_time.dart';
import 'package:pomodoro/components/timer.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(child: Timer()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Observer(
              builder: (_) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InTime(
                    title: 'Trabalho',
                    value: store.workTime,
                    dec: store.started && store.isWorking()
                        ? null
                        : () => store.decrementTime('work'),
                    inc: store.started && store.isWorking()
                        ? null
                        : () => store.incrementTime('work'),
                  ),
                  InTime(
                    title: 'Descanso',
                    value: store.restTime,
                    dec: store.started && !store.isWorking()
                        ? null
                        : () => store.decrementTime('rest'),
                    inc: store.started && !store.isWorking()
                        ? null
                        : () => store.incrementTime('rest'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
