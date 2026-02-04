# frozen_string_literal: true

module Avm
  module EacAsciidoctorBase0
    module Sources
      module Runners
        class Documents
          runner_with :help

          def run
            infov 'Documents', documents.count
            documents.each do |document|
              infov '  * ', document
            end
          end

          private

          def documents_uncached
            source.documents
          end
        end
      end
    end
  end
end
