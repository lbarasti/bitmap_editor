# Running
## Interpreting a file
```
ruby runner.rb <path-to-commands-file>
```
e.g. `ruby runner.rb examples/bitmap5x6`

## Run in interactive mode
When running the runner with no arguments, the interpreter will wait for user input.
```
ruby runner.rb
```
Press ^C to exit.

# Development
## Tests
The following will run all the test suites under the `test` folder.
```
rake test
```
