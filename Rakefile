source = 'rubocop'
dest = 'rubocop-ast'
paths = %w[
  lib/rubocop/ast
  lib/rubocop/error.rb
  lib/rubocop/node_pattern.rb
  lib/rubocop/processed_source.rb
  lib/rubocop/token.rb
  spec/rubocop/ast
  spec/rubocop/node_pattern_spec.rb
  spec/rubocop/processed_source_spec.rb
  spec/rubocop/token_spec.rb
  manual/node_pattern.md
]

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
  path_option = paths.map { |p| "--path #{p}" }.join(' ')
  cmd = "cd #{dest} && ../git-filter-repo --force #{path_option}"
  puts cmd
  `#{cmd}`
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

def copy_files(from, to)
  Dir["#{from}/**/*"].each do |path|
    next if Dir.exist?(path)
    dest_path = "#{to}#{path[from.length...]}"
    FileUtils.mkdir_p(File.dirname(dest_path))
    FileUtils.cp(path, dest_path)
  end
end

task :copy_extra do
  copy_files("copy/#{dest}", dest)
  `cd #{dest} && git add . && git commit -m "Create gem files"`
end

