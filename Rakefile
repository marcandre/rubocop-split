source = 'rubocop'
dest = 'rubocop-ast'
paths = %w[lib/rubocop/ast lib/rubocop/node_pattern.rb spec/rubocop/ast spec/rubocop/node_pattern_spec.rb]

task :init do
  raise "Target '#{dest}' already exist, delete it manually if you want to proceed" if Dir.exists?(dest)
  `cp -a #{source} #{dest}`
end

task :setup_git do
  `cd #{dest} && git remote add fork git@github.com:marcandre/rubocop-ast.git`
end

task :delete_all_tags do
  `cd #{dest} && git tag | xargs -L 1 | xargs git tag --delete`
end

task :reset do
  `cd #{dest} && git fetch --no-tags && git tag -f previous_filtered filtered && git branch -f previous_processed && git reset --hard origin/master`
end

task :filter do
  `cd #{dest} && git filter-branch -f --prune-empty --index-filter 'git ls-files | grep -vE "#{paths.join('|')}" | xargs git rm -rf --cached --ignore-unmatch'`
  # See https://stackoverflow.com/questions/42834812/remove-all-except-certain-folders-from-git-history
  `cd #{dest} && git tag -f filtered`
end

task :reapply do
  `cd #{dest} && git cherry-pick previous_filtered..previous_processed`
end

task :remove_dupped do
  `cd #{source} && rm -rf #{paths.join(' ')}`
end

# First time setup:
task setup: %i[init setup_git delete_all_tags]

# Process
task process: %i[filter]

# Add commits

# If needed:
task reprocess: %i[reset filter reapply]
