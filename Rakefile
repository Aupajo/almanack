require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :checksum do
  require 'digest/sha2'
  built_gem_path = Dir["pkg/almanack-*.gem"].sort_by {|f| File.mtime(f) }.last

  checksum_paths = [256, 512].map do |digest_bits|
    algorithm = Digest.const_get("SHA#{digest_bits}").new
    checksum = algorithm.hexdigest(File.read(built_gem_path))
    gem_name = File.basename(built_gem_path)
    checksum_path = "checksums/#{gem_name}.sha#{digest_bits}"
    File.open(checksum_path, 'w') { |file| file.write checksum }
    `git add #{checksum_path}`
    checksum_path
  end

  system("git status checksums --short")

  "==> Please commit:\n#{checksum_paths.join("\n")}"
end

Rake::Task['release'].enhance do
  Rake::Task['checksum'].invoke
end
