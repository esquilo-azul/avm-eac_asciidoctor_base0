# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'avm/eac_asciidoctor_base0/version'

Gem::Specification.new do |s|
  s.name        = 'avm-eac_asciidoctor_base0'
  s.version     = Avm::EacAsciidoctorBase0::VERSION
  s.authors     = ['Put here the authors']
  s.summary     = 'Put here de description.'

  s.files = Dir['{lib,template}/**/*', 'template/avm/eac_asciidoctor_base0/instances/deploy/.keep']
  s.required_ruby_version = '>= 2.7'

  s.add_dependency 'asciidoctor', '~> 2.0', '>= 2.0.22'
  s.add_dependency 'avm-eac_webapp_base0', '~> 0.19'
  s.add_dependency 'eac_ruby_utils', '~> 0.121'
  s.add_dependency 'os', '~> 1.1', '>= 1.1.4'
  s.add_dependency 'rouge', '~> 3.30'

  s.add_development_dependency 'eac_fs', '~> 0.16'
  s.add_development_dependency 'eac_ruby_gem_support', '~> 0.9'
end
