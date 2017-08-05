@preprocessor typescript

@{%

import {
  Addition,
  Assignment,
  CompareEqual,
  CompareLessOrEqual,
  Conjunction,
  IfThenElse,
  Multiplication,
  Negation,
  Numeral,
  Sequence,
  Substraction,
  TruthValue,
  Variable,
  WhileDo
} from '../ast/AST';

import { tokens } from './Tokens';
import { MyLexer } from './Lexer';

const lexer = new MyLexer(tokens);

%}

@lexer lexer

stmt ->
      identifier "=" aexp ";"
      {% ([id, , exp, ]) => (new Assignment(id, exp)) %}
    | "skip" ";"
      {% () => {} %}
    | "{" stmt:* "}"
      {% ([, statements, ]) => (new Sequence(statements)) %}
    | "while" bexp "do" stmt
      {% ([, cond, , body]) => (new WhileDo(cond, body)) %}
    | "if" bexp "then" stmt "else" stmt
      {% ([, cond, , thenBody, , elseBody]) => (new IfThenElse(cond, thenBody, elseBody)) %}

aexp ->
      number
      {% ([num]) => (new Numeral(num)) %}
    | identifier
      {% ([id]) => (new Variable(id)) %}
    | aexp "*" aexp
      {% ([lhs, , rhs]) => (new Multiplication(lhs, rhs)) %}
    | aexp "+" aexp
      {% ([lhs, , rhs]) => (new Addition(lhs, rhs)) %}
    | aexp "-" aexp
      {% ([lhs, , rhs]) => (new Substraction(lhs, rhs)) %}
    | "(" aexp ")"
      {% ([, exp, ]) => (exp) %}

bexp ->
      "true"
      {% () => (new TruthValue(true)) %}
    | "false"
      {% () => (new TruthValue(false)) %}
    | aexp "==" aexp
      {% ([lhs, , rhs]) => (new CompareEqual(lhs, rhs)) %}
    | aexp "<=" aexp
      {% ([lhs, , rhs]) => (new CompareLessOrEqual(lhs, rhs)) %}
    | "!" bexp
      {% ([, exp]) => (new Negation(exp)) %}
    | bexp "&&" bexp
      {% ([lhs, , rhs]) => (new Conjunction(lhs, rhs)) %}
    | "(" bexp ")"
      {% ([, exp, ]) => (exp) %}

identifier -> %identifier {% ([id]) => (id.value) %}
number -> %number {% ([num]) => (num.value) %}
