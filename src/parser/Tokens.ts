export const tokens = {

  // Punctuation
  '!':          '!',
  '&&':         '&&',
  '(':          '(',
  ')':          ')',
  '{':          '{',
  '}':          '}',
  '/':          '/',
  '*':          '*',
  '+':          '+',
  '-':          '-',
  ';':          ';',
  '<=':         '<=',
  '==':         '==',
  '=':          '=',
  '>=':         '>=',
  '!=':         '!=',
  '<':          '<',
  '>':          '>',

  // Keywords
  'do':         'do',
  'while':      'while',
  'if':         'if',
  'then':       'then',
  'else':       'else',
  'true':       'true',
  'false':      'false',

  // Atoms
  number:       { match: /[0-9]+/, value: (x: string) => (parseFloat(x)) },
  hexa:         { match: /0[xX][0-9a-fA-F]+/, value: (x: string) => (Number(x)) },
  floatingPoint:{ match: /[-+]?[0-9]*\.?[0-9]+(?:[eE][-+]?[0-9]+)?/, value: (x: string) => (parseFloat(x)) },
  comments:     { match: /\/\*(?:\*(?:!\/)|[^*])*\*\//, lineBreaks: true },

  // Identifiers
  identifier:   /[a-zA-Z_][a-zA-Z0-9_]*/,

  // Ignored tokens
  _ws:          { match: /[ \t\r\n\f\v]+/, lineBreaks: true },
};
