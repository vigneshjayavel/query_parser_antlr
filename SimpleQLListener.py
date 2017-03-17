# Generated from SimpleQL.g4 by ANTLR 4.6
from antlr4 import *
import pdb

# This class defines a complete listener for a parse tree produced by SimpleQLParser.
class SimpleQLListener(ParseTreeListener):

    def __init__(self):
        self.table_name = None
        self.column_names = list()
        self.conditions = list()
        self.groupbys = list()
        self.orderbys = list()
        self.limit_value = None
        self.offset_value = None


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


    # Enter a parse tree produced by SimpleQLParser#boolean_expr.
    def enterBoolean_expr(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#boolean_expr.
    def exitBoolean_expr(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#ordering_terms.
    def enterOrdering_terms(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#ordering_terms.
    def exitOrdering_terms(self, ctx):
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
        self.orderbys.append([term, order])


    # Enter a parse tree produced by SimpleQLParser#order.
    def enterOrder(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#order.
    def exitOrder(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#selected_column.
    def enterSelected_column(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#selected_column.
    def exitSelected_column(self, ctx):
        self.column_names.append(ctx.getText())


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


    # Enter a parse tree produced by SimpleQLParser#limit_value.
    def enterLimit_value(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#limit_value.
    def exitLimit_value(self, ctx):
        self.limit_value = ctx.getText()


    # Enter a parse tree produced by SimpleQLParser#offset_value.
    def enterOffset_value(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#offset_value.
    def exitOffset_value(self, ctx):
        self.offset_value = ctx.getText()


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
        pass


    # Enter a parse tree produced by SimpleQLParser#order_by_column.
    def enterOrder_by_column(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#order_by_column.
    def exitOrder_by_column(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#grouping_terms.
    def enterGrouping_terms(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#grouping_terms.
    def exitGrouping_terms(self, ctx):
        pass


    # Enter a parse tree produced by SimpleQLParser#group_by_column.
    def enterGroup_by_column(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#group_by_column.
    def exitGroup_by_column(self, ctx):
        self.groupbys.append(ctx.column_name().getText())


    # Enter a parse tree produced by SimpleQLParser#any_name.
    def enterAny_name(self, ctx):
        pass

    # Exit a parse tree produced by SimpleQLParser#any_name.
    def exitAny_name(self, ctx):
        pass
