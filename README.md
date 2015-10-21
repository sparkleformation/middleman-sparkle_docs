# SparkleFormation documentation installer

This extension will install the documentation of the currently installed
sparkle_formation and sfn gems into the website. The extension provides
the dependencies on sparkle_formation and sfn, so run a `bundle update`
prior to doing work on the website to ensure latest releases.

## Extras

It will auto convert `.md` to `.html` so links work as expected.

## Usage

Enabled via the `config.rb`:

```ruby
# config.rb

activate :sparkle_docs