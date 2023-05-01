# frozen_string_literal: true

require 'avm/eac_asciidoctor_base0/instances/macros/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Instances
      module Macros
        class ChildDocs < ::Avm::EacAsciidoctorBase0::Instances::Macros::Base
          class DocumentBuilder
            common_constructor :child_docs, :document, :depth, default: [0]
            compare_by :title, :address

            # @return [Pathname]
            def address
              root_document.href_to_other_body(document)
            end

            # @return [Array] Document's children mapped to document builders.
            def children
              document.children.map { |c| self.class.new(child_docs, c, depth + 1) }.sort
            end

            # @return [String]
            def link
              "link:#{address}[#{title}]"
            end

            # @return [Array<String>]
            def result
              children.map(&:self_line)
            end

            # @return [Avm::EacAsciidoctorBase0::Instances::Build::Document]
            def root_document
              child_docs.document
            end

            # @return [String]
            def self_line
              "#{'*' * depth} #{link}"
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
