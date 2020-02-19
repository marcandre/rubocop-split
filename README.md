Temporary repository to isolate `RuboCop::AST` and `RuboCop::NodePattern`
into a separate gem

# Roadmap

* Copy the needed files to `rubocop-ast` along with the commit history
* Remove those files from `rubocop`
* Copy / overwrite some files (`gemspec`, docs, ...)
* Modify `RuboCop` to require the gem

All these steps should ideally be scripted.
