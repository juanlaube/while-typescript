@preprocessor typescript

@{%

import {
  Addition,
  Division,
  Assignment,
  CompareEqual,
  CompareLess,
  CompareGreat,
  CompareGreatOrEqual,
  CompareDifferent,
  CompareLessOrEqual,
  Conjunction,
  IfThenElse,
  IfThen,
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


# Statements


stmt -> stmtelse
  | "if" exp "then" stmt {% ([, cond, , thenBody, ]) => (new IfThen(cond, thenBody)) %}


stmtelse ->
    identifier "=" exp ";"               {% ([id, , exp, ]) => (new Assignment(id, exp)) %}
  | "{" stmt:* "}"                        {% ([, statements, ]) => (new Sequence(statements)) %}
  | "while" exp "do" stmt                {% ([, cond, , body]) => (new WhileDo(cond, body)) %}
  | "if" exp "then" stmtelse "else" stmt     {% ([, cond, , thenBody, , elseBody]) => (new IfThenElse(cond, thenBody, elseBody)) %}

# Expressions

exp ->
  conj                     {% id %}

# Arithmetic expressions

addsub ->
    addsub "+" muldiv       {% ([lhs, , rhs]) => (new Addition(lhs, rhs)) %}
  | addsub "-" muldiv       {% ([lhs, , rhs]) => (new Substraction(lhs, rhs)) %}
  | muldiv                  {% id %}

muldiv ->
    muldiv "*" exp         {% ([lhs, , rhs]) => (new Multiplication(lhs, rhs)) %}
  | muldiv "/" exp         {% ([lhs, , rhs]) => (new Division(lhs, rhs)) %}
  | neg                    {% id %}

value ->
    "(" exp ")"            {% ([, exp, ]) => (exp) %}
  | number                  {% ([num]) => (new Numeral(num)) %}
  | hexadecimal             {% ([hex]) =>  (new Numeral(hex)) %}
  | identifier              {% ([id]) => (new Variable(id)) %}
  | "true"                  {% () => (new TruthValue(true)) %}
  | "false"                 {% () => (new TruthValue(false)) %}


# Boolean expressions

conj ->
    conj "&&" comp          {% ([lhs, , rhs]) => (new Conjunction(lhs, rhs)) %}
  | comp                    {% id %}

comp ->
    comp "==" addsub          {% ([lhs, , rhs]) => (new CompareEqual(lhs, rhs)) %}
  | comp "<=" addsub          {% ([lhs, , rhs]) => (new CompareLessOrEqual(lhs, rhs)) %}
  | comp "<" addsub           {% ([lhs, , rhs]) => (new CompareLess(lhs, rhs)) %}
  | comp ">" addsub           {% ([lhs, , rhs]) => (new CompareGreat(lhs, rhs)) %}
  | comp ">=" addsub          {% ([lhs, , rhs]) => (new CompareGreatOrEqual(lhs, rhs)) %}
  | comp "!=" addsub          {% ([lhs, , rhs]) => (new CompareDifferent(lhs, rhs)) %}
  |addsub                      {% id %}

neg ->
    "!" value              {% ([, exp]) => (new Negation(exp)) %}
  | value                  {% id %}

bvalue ->
    "(" exp ")"            {% ([, exp, ]) => (exp) %}
  
  | identifier              {% ([id]) => (new Variable(id)) %}


# Atoms

identifier -> %identifier   {% ([id]) => (id.value) %}
number -> %number           {% ([num]) => (num.value) %}
hexadecimal -> %hexadecimal {% ([hex]) => (hex.value) %}
