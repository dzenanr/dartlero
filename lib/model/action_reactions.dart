part of dartlero;

enum Action {ADD, CLEAR, REMOVE, UPDATE}

abstract class ActionReaction {
  startReaction(Reaction reaction);
  cancelReaction(Reaction reaction);
  notifyReactions(Action action, [ConceptEntityApi entity, String propertyName, Object oldValue]);
}

typedef bool Reaction(Action action, [ConceptEntityApi entity, String propertyName, Object oldValue]);







