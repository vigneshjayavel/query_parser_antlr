from antlr4 import *
from SimpleQLLexer import SimpleQLLexer
from SimpleQLListener import SimpleQLListener
from SimpleQLParser import SimpleQLParser

def main():
    lexer = SimpleQLLexer(InputStream("select emp_name from employees "
                                      "join issues on employees.id = issues.emp_id "
                                      "where issues.subject like 'hello' "
                                      "group by priority "
                                      "order by issues.id desc, issues.subject"))
    stream = CommonTokenStream(lexer)
    parser = SimpleQLParser(stream)
    tree = parser.parse()
    printer = SimpleQLListener()
    walker = ParseTreeWalker()
    walker.walk(printer, tree)
    print printer.__dict__

main()