part of dartlero;

enum Action {ADD, REMOVE}

abstract class ActionReaction {
  startReaction(Reaction reaction);
  cancelReaction(Reaction reaction);
  notifyReactions(Action action, ConceptEntityApi entity);
}

typedef bool Reaction(Action action, ConceptEntityApi entity);







