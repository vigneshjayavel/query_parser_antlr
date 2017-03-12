# A simple parser experiment using ANTLR4 - to parse simple sql statements.

## Requirements:
python - 2.7
brew cask install java
brew install antlr
pip install antlr4-python2-runtime

## Generate compiler
antlr -Dlanguage=Python2 SimpleQL.g4

## Test a sample text
python tester.py


### NOTE:
- The grammar is a stripped down version of SQLite's grammar.
- has listener implementation only for table_name.. So expect only the table name.

### TODO:
- [ ] got to do listeners for column names, condition clause & group by clause.
- [ ] strip down everything except for the simple select!