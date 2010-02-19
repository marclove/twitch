require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name      = "twitch"
    gem.summary   = %Q{A Twilio Client for Ruby}
    gem.email     = "marcslove@gmail.com"
    gem.homepage  = "http://github.com/marclove/twitch"
    gem.authors   = ["Marc Love"]
  
    gem.add_dependency('activesupport', '2.3.5')
    gem.add_dependency('httparty', '0.4.5')
  
    gem.add_development_dependency('fakeweb','1.2.8')
    gem.add_development_dependency('shoulda','2.10.2')
    gem.add_development_dependency('mocha','0.9.8')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new do |test|
  test.libs << 'test'
  test.ruby_opts << '-rubygems'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :default => :test
task :test => :check_dependencies

require 'yard'
require 'yard/rake/yardoc_task'
YARD::Rake::YardocTask.new(:doc) do |t|
  t.files = ["README.md", "lib/**/*.rb"]
end