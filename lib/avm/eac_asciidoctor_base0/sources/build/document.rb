# frozen_string_literal: true

require 'asciidoctor'

module Avm
  module EacAsciidoctorBase0
    module Sources
      class Build
        class Document
          enable_speaker
          common_constructor :build, :subpath

          # Absolute path to the Asciidoctor file.
          #
          # @return [Pathname]
          def body_source_path
            root_source_path
          end

          # Absolute path to the output of Asciidoctor's source file.
          #
          # @return [Pathname]
          def body_target_path
            build.target_directory.join(subpath).basename_sub('.*') { |b| "#{b}.html" }
          end

          def perform
            infov 'Building', root_source_path
            ::Asciidoctor.convert_file(
              body_source_path.to_path,
              to_file: body_target_path.to_path, safe: :unsafe, mkdirs: true
            )
          end

          # Absolute path to the document's source root.
          #
          # @return [Pathname]
          def root_source_path
            build.source.content_directory.join(subpath)
          end
        end
      end
    end
  end
end
