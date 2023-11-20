# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/recursive_builder'

module Avm
  module EacAsciidoctorBase0
    module DocumentsOwner
      common_concern

      # @param subpath [Pathname]
      # @return [Avm::EacAsciidoctorBase0::Sources::Document]
      # @raise [KeyError]
      def document(subpath)
        documents.find { |d| d.subpath.to_pathname == subpath.to_pathname } ||
          raise(::KeyError, "Document not found with subáth = \"#{subpath}\"")
      end

      # @return [Enumerable<Avm::EacAsciidoctorBase0::Sources::Document>]
      def documents
        ::EacRubyUtils::RecursiveBuilder.new(root_document, &:children).result
      end

      # @return [Object]
      def root_document
        raise "Abstract method hit: #{__method__}"
      end
    end
  end
end
