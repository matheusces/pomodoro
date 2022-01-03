import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/components/timer_button.dart';
import 'package:pomodoro/store/pomodoro.store.dart';
import 'package:provider/provider.dart';

class Timer extends StatelessWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PomodoroStore>(context);

    return Observer(
      builder: (_) => Container(
        color: store.isWorking() ? Colors.red : Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              store.isWorking() ? 'Hora de trabalhar' : 'Hora de descansar',
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              '${store.minutes.toString().padLeft(2, '0')}:${store.seconds.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 120, color: Colors.white),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!store.started)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TimerButton(
                      text: 'Iniciar',
                      icon: Icons.play_arrow,
                      click: store.start,
                    ),
                  ),
                if (store.started)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: TimerButton(
                      text: 'Parar',
                      icon: Icons.stop,
                      click: store.stop,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TimerButton(
                    text: 'Reiniciar',
                    icon: Icons.refresh,
                    click: store.restart,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
