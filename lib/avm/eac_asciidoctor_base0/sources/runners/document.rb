# frozen_string_literal: true

module Avm
  module EacAsciidoctorBase0
    module Sources
      module Runners
        class Document
          runner_with :help, :subcommands do
            pos_arg :subpath
            subcommands
          end
          delegate :subpath, to: :parsed
          for_context :document, :subpath

          private

          # @return [Avm::EacAsciidoctorBase0::Sources::Document]
          # @raise [KeyError]
          def document_uncached
            source.document(subpath)
          end

          require_sub __FILE__
        end
      end
    end
  end
end
