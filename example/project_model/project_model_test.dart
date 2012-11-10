
import 'package:dartlero/dartlero.dart';
import 'package:unittest/unittest.dart';

part 'project_entities.dart';
part 'project_model.dart';

testProjects(Projects projects) {
  group("Testing Projects", () {
    setUp(() {
      var projectCount = 0;
      expect(projects.count, equals(projectCount));

      var design = new Project();
      expect(design, isNotNull);
      design.name = 'Dartling Design';
      design.description =
          'Creating a model of Dartling concepts based on MagicBoxes.';
      projects.add(design);
      expect(projects.count, equals(++projectCount));

      var prototype = new Project();
      expect(prototype, isNotNull);
      prototype.name = 'Dartling Prototype';
      prototype.description =
          'Programming the meta model and the generic model.';
      projects.add(prototype);
      expect(projects.count, equals(++projectCount));

      var production = new Project();
      expect(production, isNotNull);
      production.name = 'Dartling';
      production.description =
          'Programming Dartling.';
      projects.add(production);
      expect(projects.count, equals(++projectCount));

      //projects.display('Projects');
    });
    tearDown(() {
      projects.clear();
      expect(projects.empty, isTrue);
    });
    test('Add Project', () {
      var project = new Project();
      project.name = 'modelibra';
      project.description = 'domain model framework for educational purposes';
      projects.add(project);
      projects.display('Add Project');
    });
    test('Add Project Without Data', () {
      var projectCount = projects.count;
      var project = new Project();
      expect(project, isNotNull);
      var added = projects.add(project);
      expect(added, isTrue);
      projects.display('Add Project Without Data');
    });
    test('Add Project Not Unique', () {
      var projectCount = projects.count;
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
      expect(programmingProjects.empty, isFalse);
      expect(programmingProjects.length, equals(2));
      programmingProjects.display('Select Projects by Function');
    });
    test('Select Projects by Function then Add', () {
      var programmingProjects = projects.select((p) => p.onProgramming);
      expect(programmingProjects.empty, isFalse);

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
      var projectCount = projects.count;
      projects.display('Projects Before Remove');
      var programmingProjects = projects.select((p) => p.onProgramming);
      expect(programmingProjects.empty, isFalse);

      var searchName = 'Dartling';
      var project = programmingProjects.find(searchName);
      expect(project, isNotNull);
      expect(project.name, equals(searchName));
      var programmingProjectCount = programmingProjects.count;
      programmingProjects.remove(project);
      expect(programmingProjects.count, equals(--programmingProjectCount));
      expect(projects.count, equals(projectCount));
    });
    test('Order Projects by Name', () {
      Projects orderedProjects =
          projects.orderByFunction((m,n) => m.nameCompareTo(n));
      expect(orderedProjects.empty, isFalse);
      expect(orderedProjects.count, equals(projects.count));

      orderedProjects.display('Order Projects by Name');
    });
    test('New Project', () {
      var projectCount = projects.count;
      var marketing = new Project();
      expect(marketing, isNotNull);
      marketing.name = 'Dartlng Marketing';
      marketing.description = 'Making Dartling known to the Dart community.';
      var added = projects.add(marketing);
      expect(added, isTrue);
      expect(projects.count, equals(++projectCount));
      projects.display('New Project');
    });
    test('Copy Projects', () {
      Projects copiedProjects = projects.copy();
      expect(copiedProjects.empty, isFalse);
      expect(copiedProjects.count, equals(projects.count));
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
  });
}

main() {
  ProjectModel projectModel = new ProjectModel();
  Projects projects = projectModel.projects;
  testProjects(projects);
}
