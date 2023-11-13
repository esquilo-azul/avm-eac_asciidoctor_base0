# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/source_generators/base'
require 'avm/source_generators/runner'

RSpec.describe Avm::EacAsciidoctorBase0::SourceGenerators::Base do
  include_examples 'avm_source_generated', __FILE__, 'EacAsciidoctorBase0'
end
