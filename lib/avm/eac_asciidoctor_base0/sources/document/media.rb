# frozen_string_literal: true

require 'asciidoctor'

module Avm
  module EacAsciidoctorBase0
    module Sources
      class Document
        module Media
          MEDIA_DIRECTORY_BASENAME = '_media'

          def copy_media_directory_to(target_directory_path)
            return unless media_directory.directory?

            target_directory_path.parent.mkpath
            ::FileUtils.copy_entry(media_directory, target_directory_path)
          end

          # @return [Pathname]
          def media_directory
            root_path.join(MEDIA_DIRECTORY_BASENAME)
          end
        end
      end
    end
  end
end
