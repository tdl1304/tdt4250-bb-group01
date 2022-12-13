# Introduction to xtext

DSL language for making grammar

# Contents

- [How to generate grammar](#how-to-generate-grammar)
- [How to test grammar](#how-to-test-grammar)

## How to generate grammar

- Follow path htmlDSL.xtext/src/htmlDSL/Xtml.xtext
  File that ends with .xtext is the grammar file
  <img src="./assets/gmfile.png" alt="Grammar file" style="max-width:200px; padding:10px 0;"/>

- Run generator for xext  
  <img src="./assets/rungen.png" style="max-width:200px; padding:10px 0;"/>

## How to test grammar

### Option 1.

- Run file htmlDSL.xtext.tests/src/htmlDSL.tests/XtmlParsingTest.xtend as **JUnit test**
  <img src="./assets/testing.png" style="max-width:200px; padding:10px 0;"/>

### Option 2.

- Run the project as an "Launch Runtime Eclipse"  
  <img src="./assets/testing2.png" style="max-width:200px; padding:10px 0;"/>

- Make a file with endings according to grammar. In this case .xtml then write some code! (Might have to make a folder ...ui/xtend-gen/ for eclipse to stop complaining)
  <img src="./assets/xtmltext.png" style="max-width:200px; padding:10px 0;"/>
