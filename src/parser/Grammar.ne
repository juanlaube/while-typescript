@preprocessor typescript

@{%

import {
  Addition,
  Assignment,
  CompareDifferent,
  CompareEqual,
  CompareLess,
  CompareGreat,
  CompareLessOrEqual,
  CompareGreatOrEqual,
  Conjunction,
  Disjunction,
  IfThen,
  IfThenElse,
  Multiplication,
  Division,
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


# Statements
# if true then if true then a=1; else a=2;

stmt ->
  stmt_else
  | "if" exp "then" stmt_else  {% ([, cond, , thenBody]) => (new IfThen(cond, thenBody)) %}

stmt_else ->
  identifier "=" exp ";"                {% ([id, , exp, ]) => (new Assignment(id, exp)) %}
  | "{" stmt:* "}"                        {% ([, statements, ]) => (new Sequence(statements)) %}
  | "while" exp "do" stmt                 {% ([, cond, , body]) => (new WhileDo(cond, body)) %}
  | "if" exp "then" stmt_else "else" stmt {% ([, cond, , thenBody, , elseBody]) => (new IfThenElse(cond, thenBody, elseBody)) %}

#exp
exp ->
    exp "&&" exp1           {% ([lhs, , rhs]) => (new Conjunction(lhs, rhs)) %}
  | exp "||" exp1           {% ([lhs, , rhs]) => (new Disjunction(lhs, rhs)) %}
  | exp1                    {% id %}

exp1 ->
    exp1 "!=" exp2          {% ([lhs, , rhs]) => (new CompareDifferent(lhs, rhs)) %}
  | exp1 "==" exp2          {% ([lhs, , rhs]) => (new CompareEqual(lhs, rhs)) %}
  | exp1 "<" exp2           {% ([lhs, , rhs]) => (new CompareLess(lhs, rhs)) %}
  | exp1 ">" exp2           {% ([lhs, , rhs]) => (new CompareGreat(lhs, rhs)) %}
  | exp1 "<=" exp2          {% ([lhs, , rhs]) => (new CompareLessOrEqual(lhs, rhs)) %}
  | exp1 ">=" exp2          {% ([lhs, , rhs]) => (new CompareGreatOrEqual(lhs, rhs)) %}
  | exp2                    {% id %}

exp2 ->
    exp2 "+" exp3           {% ([lhs, , rhs]) => (new Addition(lhs, rhs)) %}
  | exp2 "-" exp3           {% ([lhs, , rhs]) => (new Substraction(lhs, rhs)) %}
  | exp3                    {% id %}

exp3 ->
    exp3 "*" exp4           {% ([lhs, , rhs]) => (new Multiplication(lhs, rhs)) %}
  | exp3 "/" exp4           {% ([lhs, , rhs]) => (new Division(lhs, rhs)) %}
  | exp4                    {% id %}

exp4 ->
    "!" exp4                {% ([, exp]) => (new Negation(exp)) %}
  | exp5                    {% id %}

exp5 ->
    "(" exp ")"             {% ([, exp, ]) => (exp) %}
  | "true"                  {% () => (new TruthValue(true)) %}
  | "false"                 {% () => (new TruthValue(false)) %}
  | identifier              {% ([id]) => (new Variable(id)) %}
  | number                  {% ([num]) => (new Numeral(num)) %}
  | hexNumber               {% ([num]) => (new Numeral(num)) %}
  | float                   {% ([num]) => (new Numeral(num)) %}

# Atoms

identifier -> %identifier   {% ([id]) => (id.value) %}
number -> %number           {% ([num]) => (num.value) %}
hexNumber -> %hexNumber     {% ([num]) => (num.value) %}
float -> %float             {% ([num]) => (num.value) %}
