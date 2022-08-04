# frozen_string_literal: true

require 'avm/eac_webapp_base0/runner'

module Avm
  module EacAsciidoctorBase0
    module Runners
      class Base < ::Avm::EacWebappBase0::Runner
        require_sub __FILE__
      end
    end
  end
end
