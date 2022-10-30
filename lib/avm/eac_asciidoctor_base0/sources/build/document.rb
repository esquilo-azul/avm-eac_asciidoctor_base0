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
            build.source.path.join(subpath)
          end

          def perform
            infov 'Building', subpath
            ::Asciidoctor.convert_file body_source_path.to_path,
                                       to_file: target_path.to_path, safe: :unsafe, mkdirs: true
          end

          def target_path
            build.target_directory.join(subpath).basename_sub('.*') { |b| "#{b}.html" }
          end
        end
      end
    end
  end
end
