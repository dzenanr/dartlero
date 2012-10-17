
class Project extends ConceptEntity<Project> {

  String _name;
  String description;
  
  String get name => _name;
  set name(String name) {
    _name = name;
    code = name;
  }

  Project newEntity() => new Project();

  Project copy() {
    var project = new Project();
    project.name = name;
    project.description = description;
    return project;
  }

  String toString() {
    return '  {\n '
           '    ${super.toString()}, \n '
           '    name: ${name}, \n '
           '    description: ${description}\n'
           '  }';
  }
  
  bool get onProgramming =>
      description.contains('Programming') ? true : false;
  
  int nameCompareTo(Project other) {
    return name.compareTo(other.name);
  }

}

class Projects extends ConceptEntities<Project> {

  Projects newEntities() => new Projects();

}
