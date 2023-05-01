# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/instances/macros/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Instances
      module Macros
        class ChildDocs < ::Avm::EacAsciidoctorBase0::Instances::Macros::Base
          class DocumentBuilder
            common_constructor :root_document, :document
            compare_by :title, :address

            # @return [Pathname]
            def address
              root_document.href_to_other_body(document)
            end

            # @return [String]
            def link
              "link:#{address}[#{title}]"
            end

            # @return [Array<String>]
            def result
              [self_line]
            end

            # @return [String]
            def self_line
              "* #{link}"
            end

            # @return [String]
            def title
              document.source_document.title
            end
          end
        end
      end
    end
  end
end
