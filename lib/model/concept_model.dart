
abstract class ConceptModel {

  Map<String, ConceptEntities> _entryMap;

  ConceptModel() {
    _entryMap = newEntries();
  }

  abstract Map<String, ConceptEntities> newEntries();

  ConceptEntities getEntry(String entryConcept) => _entryMap[entryConcept];

}
