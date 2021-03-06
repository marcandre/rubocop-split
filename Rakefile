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
rename = {
}

task :init do
  raise "Target '#{dest}' already exist, delete it manually if you want to proceed" if Dir.exists?(dest)
  `cp -a #{source} #{dest}`
end

task :reset do
  `cd #{dest} && git switch after_split && git reset --hard before_split`
end

task :setup_git do
  `cd #{dest} && git remote set-url fork git@github.com:marcandre/rubocop-ast.git`
end

task :delete_all_tags do
  `cd #{dest} && git tag | xargs -L 1 | xargs git tag --delete`
end

task :filter do
  path_option = [*paths, *rename.keys].map { |p| "--path #{p}" }.join(' ')
  rename_option = rename.map { |from, to| "--path-rename #{from}:#{to}"}.join(' ')
  cmd = "cd #{dest} && ../bin/git-filter-repo --force #{path_option} #{rename_option}"
  puts cmd
  `#{cmd}`
  # See https://stackoverflow.com/questions/42834812/remove-all-except-certain-folders-from-git-history
end

task :remove_dupped do
  `cd #{source} && rm -rf #{paths.join(' ')}`
end

# Add commits

def copy_files(from, to)
  Dir.glob("#{from}/**/*", File::FNM_DOTMATCH).each do |path|
    next if Dir.exist?(path)
    dest_path = "#{to}#{path[from.length...]}"
    FileUtils.mkdir_p(File.dirname(dest_path))
    FileUtils.cp(path, dest_path)
  end
end

task :copy_extra do
  copy_files('copy', dest)
  `cd #{dest} && git add . && git commit -m "Create gem files"`
end

# Process
task process: %i[init reset filter setup_git delete_all_tags copy_extra]
