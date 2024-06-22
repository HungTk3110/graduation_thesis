import 'package:untitled1/models/enum/task_type.dart';
import 'package:untitled1/models/model/task.dart';

class TaskArgument {
  final TaskEntity? task;
  final TaskType? taskType;

  TaskArgument({
    this.task,
    this.taskType,
  });
}
