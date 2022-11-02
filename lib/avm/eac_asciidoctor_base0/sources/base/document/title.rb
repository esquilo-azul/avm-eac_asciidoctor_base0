# frozen_string_literal: true

require 'asciidoctor'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Sources
      class Base
        class Document
          module Title
            TITLE_BASENAME = 'title'

            # @return [String]
            def title
              title_path.read.strip
            end

            # @return [Pathname]
            def title_path
              root_path.join(TITLE_BASENAME)
            end
          end
        end
      end
    end
  end
end
