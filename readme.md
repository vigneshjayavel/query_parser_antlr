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
parse & return the various parameters of a select query viz.
- [ ] list of fields
- [ ] where conditions
- [ ] join tables
- [ ] join conditions
- [ ] group by clause