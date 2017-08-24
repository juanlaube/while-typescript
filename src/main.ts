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
    const node: ASTNode = parser.results[0];
    console.log(parser.results);
//    console.log(node.toString());

  } catch(parseError) {
    console.log(parseError);
  }
}
