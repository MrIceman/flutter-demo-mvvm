import 'package:mvvmtodoapp/mvvm/viewmodel.dart';
import 'package:mvvmtodoapp/task/repository.dart';

import '../mvvm/observer.dart';
import 'model.dart';

class TaskViewModel extends EventViewModel {
  final TaskRepository _repository;

  TaskViewModel(this._repository);

  void loadTasks() {
    notify(LoadingEvent(isLoading: true));
    _repository.loadTasks().then((value) {
      notify(TasksLoadedEvent(tasks: value));
      notify(LoadingEvent(isLoading: false));
    });
  }
}

class LoadingEvent extends ViewEvent {
  bool isLoading;

  LoadingEvent({required this.isLoading}) : super("LoadingEvent");
}

class TasksLoadedEvent extends ViewEvent {
  final List<Task> tasks;

  TasksLoadedEvent({required this.tasks}) : super("TasksLoadedEvent");
}

class TaskCreatedEvent extends ViewEvent {
  final Task task;

  TaskCreatedEvent(this.task) : super("TaskCreatedEvent");
}
