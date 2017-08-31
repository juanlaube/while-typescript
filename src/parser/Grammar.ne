@preprocessor typescript

@{%

import {
  Addition,
  Assignment,
  CompareEqual,
  CompareLessOrEqual,
  CompareMoreOrEqual,
  CompareLess,
  CompareMore,
  CompareNotEqual,
  Conjunction,
  IfThenElse,
  IfThen,
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
    stmtElse                             {% id %}
  | "if" exp "then" stmtElse             {% ([, cond, , thenBody]) => (new IfThen(cond, thenBody)) %}

stmtElse -> 
    identifier "=" exp ";"               {% ([id, , exp, ]) => (new Assignment(id, exp)) %}
  | "{" stmt:* "}"                       {% ([, statements, ]) => (new Sequence(statements)) %}
  | "while" exp "do" stmt                {% ([, cond, , body]) => (new WhileDo(cond, body)) %}
  | "if" exp "then" stmtElse "else" stmt {% ([, cond, , thenBody, , elseBody]) => (new IfThenElse(cond, thenBody, elseBody)) %}


# Expressions

exp ->
    addsub                  {% id %}
  | conj                    {% id %}

addsub ->
    addsub "+" muldiv       {% ([lhs, , rhs]) => (new Addition(lhs, rhs)) %}
  | addsub "-" muldiv       {% ([lhs, , rhs]) => (new Substraction(lhs, rhs)) %}
  | muldiv                  {% id %}

muldiv ->
    muldiv "*" exp         {% ([lhs, , rhs]) => (new Multiplication(lhs, rhs)) %}
  | muldiv "/" exp         {% ([lhs, , rhs]) => (new Division(lhs, rhs)) %}
  | value                  {% id %}

conj ->
    conj "&&" comp          {% ([lhs, , rhs]) => (new Conjunction(lhs, rhs)) %}
  | comp                    {% id %}

comp ->
    exp "==" exp          {% ([lhs, , rhs]) => (new CompareEqual(lhs, rhs)) %}
  | exp "!=" exp          {% ([lhs, , rhs]) => (new CompareNotEqual(lhs, rhs)) %}
  | exp "<=" exp          {% ([lhs, , rhs]) => (new CompareLessOrEqual(lhs, rhs)) %}
  | exp ">=" exp          {% ([lhs, , rhs]) => (new CompareMoreOrEqual(lhs, rhs)) %}
  | exp ">" exp          {% ([lhs, , rhs]) => (new CompareMore(lhs, rhs)) %}
  | exp "<" exp          {% ([lhs, , rhs]) => (new CompareLess(lhs, rhs)) %}
  | neg

neg ->
    "!" value              {% ([, exp]) => (new Negation(exp)) %}
  | value                  {% id %}

value ->
    "(" exp ")"            {% ([, exp, ]) => (exp) %}
  | number                  {% ([num]) => (new Numeral(num)) %}
  | hexa                    {% ([hex]) => (new Numeral(hex)) %}
  | floatingPoint           {% ([flt]) => (new Numeral(flt)) %}
  | "true"                  {% () => (new TruthValue(true)) %}
  | "false"                 {% () => (new TruthValue(false)) %}
  | identifier              {% ([id]) => (new Variable(id)) %}


# Atoms

identifier -> %identifier   {% ([id]) => (id.value) %}
number -> %number           {% ([num]) => (num.value) %}
hexa -> %hexa               {% ([hexa]) => (hexa.value) %}
floatingPoint -> %floatingPoint           {% ([floatingPoint]) => (floatingPoint.value) %}
