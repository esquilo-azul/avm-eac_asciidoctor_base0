# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/instances/macros/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Instances
      module Macros
        class ChildDocs < ::Avm::EacAsciidoctorBase0::Instances::Macros::Base
          # @return [Array<String>]
          def result
            document.children.map { |child_doc| ChildDocLine.new(document, child_doc) }.sort
                    .map(&:result)
          end

          class ChildDocLine
            common_constructor :document, :child
            compare_by :title, :address

            # @return [Pathname]
            def address
              document.href_to_other_body(child)
            end

            # @return [String]
            def link
              "link:#{address}[#{title}]"
            end

            # @return [String]
            def result
              "* #{link}"
            end

            # @return [String]
            def title
              child.source_document.title
            end
          end
        end
      end
    end
  end
end
