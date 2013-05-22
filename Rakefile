task :test do
  ['spec', 'support'].each{ |dir| $: << dir }
  Dir['spec/*_spec.rb'].each {|file| require File.basename(file , '.rb') }
end	 			 

