import 'dart:async';

import 'package:mobx/mobx.dart';

part 'pomodoro.store.g.dart';

class PomodoroStore = _PomodoroStore with _$PomodoroStore;

enum TypeInterval { work, rest }

abstract class _PomodoroStore with Store{
  @observable
  bool started = false;

  @observable
  int minutes = 2;
  
  @observable
  int seconds = 0;

  @observable
  int workTime = 2;

  @observable
  int restTime = 1;

  @observable
  TypeInterval typeInterval = TypeInterval.work;

  Timer? timer;

  @action
  void incrementTime(String type) {
    if(type == 'work') {
      workTime++;
      if (isWorking()) restart();
    }
    else {
      restTime++;
      if (!isWorking()) restart();
    }
  }

  @action
  void decrementTime(String type) {
    if (type == 'work') {
      if (workTime -1 > 0) workTime--;
      if (isWorking()) restart();
    }
    else {
      if (restTime -1 > 0) restTime--;
      if (!isWorking()) restart();
    }
  }

  @action
  void start() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (minutes == 0 && seconds == 0) {
        _changeTypeInterval();
      }
      else if(seconds == 0) {
        seconds = 59;
        minutes--;
      }
      else {
        seconds--;
      }
    });
  }

  @action
  void stop() {
    started = false;
    timer?.cancel();
  }

  @action
  void restart() {
    stop();
    minutes = isWorking() ? workTime : restTime;
    seconds = 0;
  }

  bool isWorking(){
    return typeInterval == TypeInterval.work;
  }

  void _changeTypeInterval(){
    if (isWorking()){
      typeInterval = TypeInterval.rest;
      minutes = restTime;
    }
    else {
      typeInterval = TypeInterval.work;
      minutes = workTime;
    }

    seconds = 0;
  }
}