from antlr4 import *
from SimpleQLLexer import SimpleQLLexer
from SimpleQLListener import SimpleQLListener
from SimpleQLParser import SimpleQLParser

def main():
    lexer = SimpleQLLexer(InputStream("select name, age from employees "
                                      "where employees.bio like 'hello' "
                                      "group by employees.country, employees.city "
                                      "order by employees.id desc, employees.joining_date "
                                      "limit 5, 100"))
    stream = CommonTokenStream(lexer)
    parser = SimpleQLParser(stream)
    tree = parser.parse()
    printer = SimpleQLListener()
    walker = ParseTreeWalker()
    walker.walk(printer, tree)
    print printer.__dict__

main()