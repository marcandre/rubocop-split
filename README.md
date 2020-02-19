Temporary repository to isolate `RuboCop::AST` and `RuboCop::NodePattern`
into a separate gem

# How to

Assumes `./rubocop` is a repo with two branches: `before_split` and `after_split`.

## Updating

*) Rebase `./rubocop` as needed (both branches).

*) If some files were renamed / added / removed, best to drop last commit deleting files from `after_split`, run `rake remove_dupped` which removes the moved files from `./rubocop` and commit again.

## Splitting

*) `rake process` creates `./rubocop-ast` from `./rubocop`

## Final step

*) Merge last commit of `./rubocop`
