import 'package:unittest/unittest.dart';
import '../dartlero_example.dart';

testProjects(Projects projects) {
  group("Testing Projects", () {
    setUp(() {
      var projectCount = 0;
      expect(projects.length, equals(projectCount));

      var design = new Project();
      expect(design, isNotNull);
      design.name = 'Dartling Design';
      design.description =
          'Creating a model of Dartling concepts based on MagicBoxes.';
      projects.add(design);
      expect(projects.length, equals(++projectCount));

      var prototype = new Project();
      expect(prototype, isNotNull);
      prototype.name = 'Dartling Prototype';
      prototype.description =
          'Programming the meta model and the generic model.';
      projects.add(prototype);
      expect(projects.length, equals(++projectCount));

      var production = new Project();
      expect(production, isNotNull);
      production.name = 'Dartling';
      production.description =
          'Programming Dartling.';
      projects.add(production);
      expect(projects.length, equals(++projectCount));

      //projects.display('Projects');
    });
    tearDown(() {
      projects.clear();
      expect(projects.isEmpty, isTrue);
    });
    test('Add Project', () {
      var project = new Project();
      project.name = 'modelibra';
      project.description = 'domain model framework for educational purposes';
      projects.add(project);
      projects.display('Add Project');
    });
    test('Add Project Without Data', () {
      var projectCount = projects.length;
      var project = new Project();
      expect(project, isNotNull);
      var added = projects.add(project);
      expect(added, isTrue);
      projects.display('Add Project Without Data');
    });
    test('Add Project Not Unique', () {
      var projectCount = projects.length;
      var project = new Project();
      expect(project, isNotNull);
      project.name = 'Dartling';
      var added = projects.add(project);
      expect(added, isFalse);
      projects.display('Add Project Not Unique');
    });
    test('Find Project by Name', () {
      var searchName = 'Dartling';
      var project = projects.find(searchName);
      expect(project, isNotNull);
      expect(project.name, equals(searchName));
      project.display('Find Project by Name');
    });
    test('Select Projects by Function', () {
      var programmingProjects = projects.select((p) => p.onProgramming);
      expect(programmingProjects.isEmpty, isFalse);
      expect(programmingProjects.length, equals(2));
      programmingProjects.display('Select Projects by Function');
    });
    test('Select Projects by Function then Add', () {
      var programmingProjects = projects.select((p) => p.onProgramming);
      expect(programmingProjects.isEmpty, isFalse);

      var dartlingTesting = 'Dartling Testing';
      var programmingProject = new Project();
      programmingProject.name = dartlingTesting;
      programmingProject.description = 'Programming unit tests.';
      var added = programmingProjects.add(programmingProject);
      expect(added, isTrue);
      programmingProjects.display('Select Projects by Function then Add');

      var project = projects.find(dartlingTesting);
      expect(project, isNull);
      projects.display('Projects');
    });
    test('Select Projects by Function then Remove', () {
      var projectCount = projects.length;
      projects.display('Projects Before Remove');
      var programmingProjects = projects.select((p) => p.onProgramming);
      expect(programmingProjects.isEmpty, isFalse);

      var searchName = 'Dartling';
      var project = programmingProjects.find(searchName);
      expect(project, isNotNull);
      expect(project.name, equals(searchName));
      var programmingProjectCount = programmingProjects.length;
      programmingProjects.remove(project);
      expect(programmingProjects.length, equals(--programmingProjectCount));
      expect(projects.length, equals(projectCount));
    });
    test('Order Projects by Name', () {
      projects.orderByFunction((m,n) => m.compareTo(n));
      projects.display('Order Projects by Name');
    });
    test('New Project', () {
      var projectCount = projects.length;
      var marketing = new Project();
      expect(marketing, isNotNull);
      marketing.name = 'Dartlng Marketing';
      marketing.description = 'Making Dartling known to the Dart community.';
      var added = projects.add(marketing);
      expect(added, isTrue);
      expect(projects.length, equals(++projectCount));
      projects.display('New Project');
    });
    test('Copy Projects', () {
      Projects copiedProjects = projects.copy();
      expect(copiedProjects.isEmpty, isFalse);
      expect(copiedProjects.length, equals(projects.length));
      expect(copiedProjects, isNot(same(projects)));
      expect(copiedProjects, isNot(equals(projects)));
      copiedProjects.forEach((cp) =>
          expect(cp, isNot(same(projects.find(cp.name)))));
      copiedProjects.display('Copied Projects');
    });
    test('True for Every Project', () {
      expect(projects.every((p) => p.code != null), isTrue);
      expect(projects.every((p) => p.name != null), isTrue);
    });
    test('From Projects to JSON', () {
      var json = projects.toJson();
      expect(json, isNotNull);
      print(json);
    });
    test('From JSON to Project Model', () {
      List<Map<String, Object>> json = projects.toJson();
      projects.clear();
      expect(projects.isEmpty, isTrue);
      projects.fromJson(json);
      expect(projects.isEmpty, isFalse);
      projects.display('From JSON to Projects');
    });
  });
}

main() {
  ProjectModel projectModel = new ProjectModel();
  Projects projects = projectModel.projects;
  testProjects(projects);
}
