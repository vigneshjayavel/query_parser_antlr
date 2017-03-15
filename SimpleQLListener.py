# Generated from SimpleQL.g4 by ANTLR 4.6
from antlr4 import *

# This class defines a complete listener for a parse tree produced by SimpleQLParser.
class SimpleQLListener(ParseTreeListener):

    def __init__(self):
        self.table_name = None
        self.column_names = list()
        self.condition_clause = list()
        self.groupby_clause = list()
        self.orderby_clause = list()

    # Enter a parse tree produced by SimpleQLParser#parse.
    def enterParse(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#parse.
    def exitParse(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#error.
    def enterError(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#error.
    def exitError(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#simple_select_stmt.
    def enterSimple_select_stmt(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#simple_select_stmt.
    def exitSimple_select_stmt(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#select_core.
    def enterSelect_core(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#select_core.
    def exitSelect_core(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#expr.
    def enterExpr(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#expr.
    def exitExpr(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#ordering_term.
    def enterOrdering_term(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#ordering_term.
    def exitOrdering_term(self, ctx):
        term = ctx.children[0].getText()
        if len(ctx.children) == 2:
            order = ctx.children[1].getText()
        else:
            order = 'ASC'
        self.orderby_clause.append([term, order])

    def enterOrder(self, ctx):
        pass

    def exitOrder(self, ctx):
        pass

    # Enter a parse tree produced by SimpleQLParser#result_column.
    def enterResult_column(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#result_column.
    def exitResult_column(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#table_or_subquery.
    def enterTable_or_subquery(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#table_or_subquery.
    def exitTable_or_subquery(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#join_clause.
    def enterJoin_clause(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#join_clause.
    def exitJoin_clause(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#join_operator.
    def enterJoin_operator(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#join_operator.
    def exitJoin_operator(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#join_constraint.
    def enterJoin_constraint(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#join_constraint.
    def exitJoin_constraint(self, ctx):
        pass

    # Enter a parse tree produced by SimpleQLParser#literal_value.
    def enterLiteral_value(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#literal_value.
    def exitLiteral_value(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#unary_operator.
    def enterUnary_operator(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#unary_operator.
    def exitUnary_operator(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#column_alias.
    def enterColumn_alias(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#column_alias.
    def exitColumn_alias(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#keyword.
    def enterKeyword(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#keyword.
    def exitKeyword(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#function_name.
    def enterFunction_name(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#function_name.
    def exitFunction_name(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#table_name.
    def enterTable_name(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#table_name.
    def exitTable_name(self, ctx):
        self.table_name = ctx.getText()


    # Enter a parse tree produced by SimpleQLParser#column_name.
    def enterColumn_name(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#column_name.
    def exitColumn_name(self, ctx):
        self.column_names.append(ctx.getText())


    # Enter a parse tree produced by SimpleQLParser#table_alias.
    def enterTable_alias(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#table_alias.
    def exitTable_alias(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#any_name.
    def enterAny_name(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#any_name.
    def exitAny_name(self, ctx):
        pass


