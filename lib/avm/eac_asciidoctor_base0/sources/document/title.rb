# frozen_string_literal: true

require 'asciidoctor'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Sources
      class Document
        module Title
          TITLE_BASENAME = 'title'

          # @return [String]
          def default_title
            root_path.basename.to_s.humanize.split(/\s+/).map(&:upcase_first).join(' ')
          end

          # @return [String]
          def title
            title_path.exist? ? title_path.read.strip : default_title
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
