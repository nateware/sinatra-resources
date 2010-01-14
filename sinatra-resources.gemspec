spec = Gem::Specification.new do |s|
  s.name = 'sinatra-resources'
  s.version = '0.1.1'
  s.summary = "Simple nested resources for Sinatra"
  s.description = %{Adds resource and member blocks to DSL. Based on widely-followed Sinatra ticket.}
  s.files = Dir['lib/**/*.rb'] + Dir['test/**/*.rb']
  s.require_path = 'lib'
  #s.autorequire = 'redis/objects'
  s.has_rdoc = true
  s.rubyforge_project = 'sinatra-resources'
  s.extra_rdoc_files = Dir['[A-Z]*']
  s.rdoc_options << '--title' <<  'Sinatra::Resources -- Simple nested resources for Sinatra'
  s.author = "Nate Wiger"
  s.email = "nate@wiger.org"
  s.homepage = "http://github.com/nateware/sinatra-resources"
  s.requirements << 'sinatra, v0.9.0 or greater'
  s.add_dependency('sinatra', '>= 0.9.0')
end

