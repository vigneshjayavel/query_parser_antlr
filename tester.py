from antlr4 import *
from SimpleQLLexer import SimpleQLLexer
from SimpleQLListener import SimpleQLListener
from SimpleQLParser import SimpleQLParser

def main():
    lexer = SimpleQLLexer(InputStream("select emp_name from employees;"))
    stream = CommonTokenStream(lexer)
    parser = SimpleQLParser(stream)
    tree = parser.parse()
    printer = SimpleQLListener()
    walker = ParseTreeWalker()
    walker.walk(printer, tree)

main()