# frozen_string_literal: true

require 'avm/eac_webapp_base0/sources/base'
require 'avm/eac_asciidoctor_base0/sources/runners'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Sources
      class Base < ::Avm::EacWebappBase0::Sources::Base
        MAIN_FILE_SUBPATH = ::Pathname.new('index.adoc')

        def valid?
          path.join(MAIN_FILE_SUBPATH).file?
        end
      end
    end
  end
end
