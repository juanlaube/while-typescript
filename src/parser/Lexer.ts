import { compile, Lexer, LexerState, Rules, Token } from "moo";

/*
  Lexer is tokenizer that implements the interface accepted by nearley
  and wraps a moo tokenizer to ignore tokens whose type starts
  with an underscore.
*/

export class MyLexer implements Lexer {

  wrapped: Lexer;

  constructor(tokens: Rules) {
    this.wrapped = compile(tokens);
  }

  formatError(token: Token, message?: string): string {
    return this.wrapped.formatError(token, message);
  }

  has(tokenType: string): boolean {
    return this.wrapped.has(tokenType);
  }

  next(): Token {
    var token = this.wrapped.next();
    while (token != undefined && token.type.length > 0 && token.type[0] == "_") {
      token = this.wrapped.next();
    }
    return token;
  }

  reset(chunk: string, info?: LexerState): void {
    this.wrapped.reset(chunk, info);
  }

  save() {
    return this.wrapped.save();
  }
}
