# A simple parser experiment using ANTLR4 - to parse simple sql statements.

## Requirements:
- python - 2.7
- brew cask install java
- brew install antlr
- pip install antlr4-python2-runtime

## Generate compiler (This will regen the existing Listener!!)
antlr -Dlanguage=Python2 SimpleQL.g4

## Test a sample text
python tester.py


### NOTE:
- The grammar is a stripped down version of SQLite select statement's grammar.
- For a given SQL select statement, gives out the following
	- table name
	- fields selected
	- group by clause
	- order by clause
	- limit & offset values


### TODO:
parse & return the various parameters of a select query viz.
- [ ] where conditions
- [ ] having conditions in groupby