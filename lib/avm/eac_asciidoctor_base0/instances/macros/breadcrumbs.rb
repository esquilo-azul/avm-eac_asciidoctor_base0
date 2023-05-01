# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/instances/macros/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Instances
      module Macros
        class Breadcrumbs < ::Avm::EacAsciidoctorBase0::Instances::Macros::Base
          NODE_SEPARATOR = ' » '
          ROOT_DOCUMENT_TITLE = 'Home'

          # @return [Array<String>]
          def result
            trail_nodes.join(NODE_SEPARATOR)
          end

          def trail_nodes
            r = []
            current = document
            while current.present?
              r.unshift(Node.new(document, current))
              current = current.parent_document
            end
            r
          end

          class Node
            common_constructor :current, :document

            # @return [String]
            def address
              current.href_to_other_body(document)
            end

            # @return [String]
            def title
              if document.parent_document.present?
                document.source_document.title
              else
                ROOT_DOCUMENT_TITLE
              end
            end

            # @return [String]
            def to_s
              "link:#{address}[#{title}]"
            end
          end
        end
      end
    end
  end
end
