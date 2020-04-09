require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rake/testtask"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

Rake::TestTask.new(:samples_minitest) do |t|
  t.libs << "tests/minitest"
  t.test_files = FileList.new('samples/minitest/**/*_test.rb')
end

require 'rspec/core/rake_task'
rspec_task = RSpec::Core::RakeTask.new(:samples_rspec)
rspec_task.pattern = "samples/rspec/**/*_spec.rb"