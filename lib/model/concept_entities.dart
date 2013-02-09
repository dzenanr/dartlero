part of dartlero;

abstract class ConceptEntityApi<T extends ConceptEntityApi<T>>
    implements Comparable {

  ConceptEntityApi<T> newEntity();
  String get code;
  void set code(String code);
  T copy();

}

abstract class ConceptEntitiesApi<T extends ConceptEntityApi<T>> {

  ConceptEntitiesApi<T> newEntities();
  int get length;
  bool get isEmpty;
  Iterator<T> get iterator;
  forEach(Function f);
  bool every(Function f);
  bool any(Function f);
  bool add(T entity);
  bool remove(T entity);
  clear();
  bool contains(T entity);
  T find(String code);
  ConceptEntitiesApi<T> select(Function f);
  ConceptEntitiesApi<T> order();
  ConceptEntitiesApi<T> orderByFunction(Function f);
  ConceptEntitiesApi<T> copy();
  List<T> toList();

}

abstract class ConceptEntity<T extends ConceptEntity<T>>
    implements ConceptEntityApi {

  String _code;

  ConceptEntity<T> newEntity();

  T copy();

  String get code => _code;
  void set code(String code) {
    if (_code == null) {
      _code = code;
    } else {
      throw new Exception('Entity code cannot be updated.');
    }
  }

  /**
   * Compares two entities based on codes.
   * If the result is less than 0 then the first entity is less than the second,
   * if it is equal to 0 they are equal and
   * if the result is greater than 0 then the first is greater than the second.
   */
  int compareTo(T entity) {
    if (code != null) {
      return _code.compareTo(entity.code);
    }
  }

  /**
   * Returns a string that represents this entity by using its code.
   */
  String toString() {
    return 'code: ${_code}';
  }

  display([String title]) {
    if (title != null) {
      print(title);
    }
    print(toString());
  }

}

abstract class ConceptEntities<T extends ConceptEntity<T>>
    implements ConceptEntitiesApi {
  List<T> _entityList = new List<T>();
  Map<String, T> _entityMap = new Map<String, T>();

  ConceptEntities<T> newEntities();

  int get length => _entityList.length;
  bool get isEmpty => _entityList.isEmpty;
  Iterator<T> get iterator => _entityList.iterator;

  forEach(Function f) {
    _entityList.forEach(f);
  }

  bool every(Function f) {
    return _entityList.every(f);
  }

  bool any(Function f) {
    return _entityList.any(f);
  }

  bool add(T entity) {
    bool added = true;
    if (entity.code != null) {
      if (_entityMap.containsKey(entity.code)) {
        added = false;
      } else {
        _entityList.add(entity);
        _entityMap[entity.code] = entity;
      }
    } else {
      _entityList.add(entity);
    }
    return added;
  }

  bool remove(T entity) {
    bool removed = true;
    for (T e in _entityList) {
      if (e == entity) {
        int index = _entityList.indexOf(e, 0);
        _entityList.removeAt(index);
        if (entity.code != null) {
          _entityMap.remove(entity.code);
        }
        break;
      }
    }
    return removed;
  }

  clear() {
    _entityList.clear();
    _entityMap.clear();
  }

  bool contains(T entity) {
    var element;
    if (entity.code != null) {
      element = _entityMap[entity.code];
    } else {
      for (T e in _entityList) {
        if (e == entity) {
          element = e;
        }
      }
    }
    if (entity == element) {
      return true;
    }
    return false;
  }

  T find(String code) {
    return _entityMap[code];
  }

  _addFromList(List<T> other) {
    other.forEach((entity) => add(entity));
  }

  ConceptEntities<T> select(Function f) {
    ConceptEntities<T> selectedEntities = newEntities();
    List<T> selectedList = _entityList.where(f).toList();
    selectedEntities._addFromList(selectedList);
    return selectedEntities;
  }

  /**
   * If there is no compareTo method on a specific entity,
   * the ConceptEntity.compareTo method will be used (code if not null).
   */
  order() {
    // in place sort
    _entityList.sort((m,n) => m.compareTo(n));
  }

  ConceptEntities<T> orderByFunction(Function f) {
    // in place sort
    _entityList.sort(f);
  }

  /*
  ConceptEntities<T> order() {
    ConceptEntities<T> orderedEntities = newEntities();
    List<T> sortedList = toList();
    // in place sort
    sortedList.sort((m,n) => m.compareTo(n));
    orderedEntities._addFromList(sortedList);
    return orderedEntities;
  }

  ConceptEntities<T> orderByFunction(Function f) {
    ConceptEntities<T> orderedEntities = newEntities();
    List<T> sortedList = toList();
    // in place sort
    sortedList.sort(f);
    orderedEntities._addFromList(sortedList);
    return orderedEntities;
  }
  */

  /**
   * Copies the entities.
   * It is not a deep copy.
   */
  ConceptEntities<T> copy() {
    ConceptEntities<T> copiedEntities = newEntities();
    for (T entity in this) {
      copiedEntities.add(entity.copy());
    }
    return copiedEntities;
  }

  List<T> toList() => _entityList.toList();

  display([String title='Entities']) {
    print('');
    print(title);
    print('[');
    forEach((e) => e.display());
    print(']');
    print('');
  }

}
