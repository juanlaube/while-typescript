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

stmt ->
    identifier "=" exp ";"               {% ([id, , exp, ]) => (new Assignment(id, exp)) %}
  | "{" stmt:* "}"                        {% ([, statements, ]) => (new Sequence(statements)) %}
  | "while" exp "do" stmt                {% ([, cond, , body]) => (new WhileDo(cond, body)) %}
  | "if" exp "then" stmt "else" stmt     {% ([, cond, , thenBody, , elseBody]) => (new IfThenElse(cond, thenBody, elseBody)) %}



# Expressions

exp ->  
  addsub                    {% id %}
  |conj                     {% id %}
  
# Arithmetic expressions

addsub ->
    addsub "+" muldiv       {% ([lhs, , rhs]) => (new Addition(lhs, rhs)) %}
  | addsub "-" muldiv       {% ([lhs, , rhs]) => (new Substraction(lhs, rhs)) %}
  | muldiv                  {% id %}

muldiv ->
    muldiv "*" exp         {% ([lhs, , rhs]) => (new Multiplication(lhs, rhs)) %}
  | muldiv "/" exp         {% ([lhs, , rhs]) => (new Division(lhs, rhs)) %}

  | avalue                  {% id %}
  
avalue ->
    "(" exp ")"            {% ([, exp, ]) => (exp) %}
  | number                  {% ([num]) => (new Numeral(num)) %}
  | hexadecimal             {% ([hex]) =>  (new Numeral(hex)) %}
  | identifier              {% ([id]) => (new Variable(id)) %}


# Boolean expressions

conj ->
    conj "&&" comp          {% ([lhs, , rhs]) => (new Conjunction(lhs, rhs)) %}
  | comp                    {% id %}

comp ->
    exp "==" exp          {% ([lhs, , rhs]) => (new CompareEqual(lhs, rhs)) %}
  | exp "<=" exp          {% ([lhs, , rhs]) => (new CompareLessOrEqual(lhs, rhs)) %}
  | exp "<" exp           {% ([lhs, , rhs]) => (new CompareLess(lhs, rhs)) %}
  | exp ">" exp           {% ([lhs, , rhs]) => (new CompareGreat(lhs, rhs)) %}
  | exp ">=" exp          {% ([lhs, , rhs]) => (new CompareGreatOrEqual(lhs, rhs)) %}
  | exp "!=" exp          {% ([lhs, , rhs]) => (new CompareDifferent(lhs, rhs)) %}
  | neg

neg ->
    "!" bvalue              {% ([, exp]) => (new Negation(exp)) %}
  | bvalue                  {% id %}

bvalue ->
    "(" exp ")"            {% ([, exp, ]) => (exp) %}
  | "true"                  {% () => (new TruthValue(true)) %}
  | "false"                 {% () => (new TruthValue(false)) %}
  | identifier              {% ([id]) => (new Variable(id)) %}


# Atoms

identifier -> %identifier   {% ([id]) => (id.value) %}
number -> %number           {% ([num]) => (num.value) %}
hexadecimal -> %hexadecimal {% ([hex]) => (hex.value) %}
