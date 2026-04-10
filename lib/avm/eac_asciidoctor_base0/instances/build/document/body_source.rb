# frozen_string_literal: true

require 'asciidoctor'

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Build
        class Document
          module BodySource
            common_concern

            # @return [Enumerable<String>]
            def body_source_lines
              if source_document.body_path.file?
                source_document.body_path.read.each_line
              else
                default_body_source_lines
              end
            end

            # @return [Enumerable<String>]
            def default_body_source_lines
              macro_lines(:default_body)
            end

            # @return [String]
            def pre_processed_body_source_content
              (
                header_lines + [''] + body_source_lines
                .flat_map { |line| pre_process_line(line.rstrip) }
              ).map { |line| "#{line.rstrip}\n" }.join
            end
          end
        end
      end
    end
  end
end
