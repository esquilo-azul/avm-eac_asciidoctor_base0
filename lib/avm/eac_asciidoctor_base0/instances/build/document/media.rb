# frozen_string_literal: true

require 'asciidoctor'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Build
        class Document
          module Media
            def copy_media_directory
              source_document.copy_media_directory_to(media_target_path)
            end

            # @return [Pathname]
            def media_target_path
              build.target_directory.join(
                parent_document.present? ? source_document.subpath : '',
                ::Avm::EacAsciidoctorBase0::Sources::Base::Document::Media::MEDIA_DIRECTORY_BASENAME
              )
            end
          end
        end
      end
    end
  end
end
