
require_relative 'tooling/SwiftBuild.rb'

task :default do
    system 'rake --tasks'
end

desc 'Build the project'
task :build do
    puts 'Building project'
    build_module
    build_main
end

desc 'Clean the intermediate build files'
task :clean do
    SwiftBuild.clean
end
