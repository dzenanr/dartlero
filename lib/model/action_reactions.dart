part of dartlero;

enum Action {ADD, CLEAR, REMOVE, UPDATE}

abstract class ActionReaction {
  startReaction(Reaction reaction);
  cancelReaction(Reaction reaction);
  notifyReactions(Action action, [ConceptEntityApi entity, String property, Object value]);
}

typedef bool Reaction(Action action, [ConceptEntityApi entity, String property, Object value]);







