source = 'rubocop'
dest = 'rubocop-ast'
paths = %w[lib/rubocop/ast lib/rubocop/node_pattern.rb spec/rubocop/ast spec/rubocop/node_pattern_spec.rb]

task :dup do
  `rm -rf #{dest} && cp -a #{source} #{dest}`
end

task :set_origin do
  `cd #{dest} && git remote set-url origin git@github.com:marcandre/rubocop-ast.git`
end

task :filter do
  `cd #{dest} && git filter-branch --prune-empty --index-filter 'git ls-files | grep -vE "#{paths.join('|')}" | xargs git rm -rf --cached --ignore-unmatch'`
  # See https://stackoverflow.com/questions/42834812/remove-all-except-certain-folders-from-git-history
end

task process: %i[dup set_origin filter]
