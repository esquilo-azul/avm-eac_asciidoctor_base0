# frozen_string_literal: true

require 'asciidoctor'

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Build
        class Document
          module Children
            common_concern

            # @param basename [String]
            # @return [Avm::EacAsciidoctorBase0::Instances::Build::Document, nil]
            def child(basename)
              basename = basename.to_s
              children.find { |c| c.source_document.root_path.basename.to_path == basename }
            end

            # @param basename [String]
            # @return [Avm::EacAsciidoctorBase0::Instances::Build::Document]
            def child!(basename)
              child(basename) || raise("Child not found with basename \"#{basename}\"")
            end

            # @return [void]
            def perform_children
              children.each(&:perform)
            end

            # @return [Integer]
            def tree_documents_count
              children.inject(1) { |a, e| a + e.tree_documents_count }
            end

            private

            def children_uncached
              source_document.children
                .map { |source_child| self.class.new(build, self, source_child) }
            end
          end
        end
      end
    end
  end
end
