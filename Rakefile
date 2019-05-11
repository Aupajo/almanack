require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :checksum do
  require 'digest/sha2'
  built_gem_path = Dir["pkg/almanack-*.gem"].sort_by {|f| File.mtime(f) }.last
  checksum = Digest::SHA512.new.hexdigest(File.read(built_gem_path))
  gem_name = File.basename(built_gem_path)
  checksum_path = "checksum/#{gem_name}.sha512"
  File.write(checksum_path, checksum)
  puts "Checksum #{checksum} written to #{checksum_path}"
  system("git add #{checksum_path}")
  puts "Please commit this file"
end

Rake::Task['release'].enhance do
  Rake::Task['checksum'].invoke
end
