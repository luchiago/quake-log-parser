# Quake Log Parser

A parser to extract some info from a Quake game log

Dependencies:

- Ruby 2.7.1
- Bundler 2.1.4

## Setup

Verify if you have ruby 2.7.1 installed. If don't, please install

In order to check:

```shell
ruby --version
```

Same for bundler, you must have the version 2.1.4 installed

In order to check:

```shell
bundler --version
```

After the installed check, run this command:

```shell
bundle install
```

Will install all dependencies

## Run

Run the command:

```shell
ruby lib/extract.rb
```

And see the output in your terminal

## Tests

This project uses RSpec for testing

To run the tests:

```shell
bundle exec rspec
```
