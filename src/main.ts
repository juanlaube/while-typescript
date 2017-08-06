import * as readlineSync from "readline-sync";

import { Parser } from "nearley";

import { tokens } from "./parser/Tokens";
import { MyLexer } from "./parser/Lexer"
import { ParserRules, ParserStart } from "./parser/Grammar";

import { ASTNode } from './ast/AST';

console.log("While :: REPL");

while (true) {
  const lexer = new MyLexer(tokens);
  const parser = new Parser(ParserRules, ParserStart, { lexer });
  const input = readlineSync.question('> ');

  try {
    // Parse user input
    parser.feed(input);
    // Print result
    const output = parser.results
      .filter((node) => (node !== undefined))
      .map((node) => (node.toString()))
    console.log(output);

  } catch(parseError) {
    console.log(parseError);
  }
}
