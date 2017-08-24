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

stmt ->
    identifier "=" exp ";"                {% ([id, , exp, ]) => (new Assignment(id, exp)) %}
  | "{" stmt:* "}"                        {% ([, statements, ]) => (new Sequence(statements)) %}
  | "while" exp "do" stmt                 {% ([, cond, , body]) => (new WhileDo(cond, body)) %}
  | "if" exp "then" stmt                  {% ([, cond, , thenBody]) => (new IfThen(cond, thenBody)) %}
  | "if" exp "then" stmt "else" stmt      {% ([, cond, , thenBody, , elseBody]) => (new IfThenElse(cond, thenBody, elseBody)) %}

#exp
exp ->
    addsub                 {% id %}
  | conj                   {% id %}

addsub ->
    addsub "+" muldiv       {% ([lhs, , rhs]) => (new Addition(lhs, rhs)) %}
  | addsub "-" muldiv       {% ([lhs, , rhs]) => (new Substraction(lhs, rhs)) %}
  | muldiv                  {% id %}

muldiv ->
    muldiv "*" value       {% ([lhs, , rhs]) => (new Multiplication(lhs, rhs)) %}
  | muldiv "/" value       {% ([lhs, , rhs]) => (new Division(lhs, rhs)) %}
  | value                  {% id %}

conj ->
    conj "&&" comp          {% ([lhs, , rhs]) => (new Conjunction(lhs, rhs)) %}
  | comp                    {% id %}

comp ->
    exp "!=" disj          {% ([lhs, , rhs]) => (new CompareDifferent(lhs, rhs)) %}
  | exp "==" disj          {% ([lhs, , rhs]) => (new CompareEqual(lhs, rhs)) %}
  | exp "<" disj           {% ([lhs, , rhs]) => (new CompareLess(lhs, rhs)) %}
  | exp ">" disj           {% ([lhs, , rhs]) => (new CompareGreat(lhs, rhs)) %}
  | exp "<=" disj          {% ([lhs, , rhs]) => (new CompareLessOrEqual(lhs, rhs)) %}
  | exp ">=" disj          {% ([lhs, , rhs]) => (new CompareGreatOrEqual(lhs, rhs)) %}
  | disj                    {% id %}

disj ->
    disj "||" neg           {% ([lhs, , rhs]) => (new Disjunction(lhs, rhs)) %}
  | neg                     {% id %}

neg ->
    "!" value              {% ([, exp]) => (new Negation(exp)) %}
  | value                  {% id %}

value ->
    "(" exp ")"            {% ([, exp, ]) => (exp) %}
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
