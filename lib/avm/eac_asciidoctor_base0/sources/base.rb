# frozen_string_literal: true

require 'avm/eac_webapp_base0/sources/base'
require 'avm/eac_asciidoctor_base0/sources/runners'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Sources
      class Base < ::Avm::EacWebappBase0::Sources::Base
        CONTENT_DIRECTORY_SUBPATH = ::Pathname.new('content')
        CONTENT_DOCUMENT_BASENAME = ::Pathname.new('body.adoc')
        MAIN_FILE_SUBPATH = CONTENT_DIRECTORY_SUBPATH.join(CONTENT_DOCUMENT_BASENAME)

        require_sub __FILE__

        def content_directory
          path.join(CONTENT_DIRECTORY_SUBPATH)
        end

        # @return [Avm::EacAsciidoctorBase0::Sources::Base::Document
        def root_document
          ::Avm::EacAsciidoctorBase0::Sources::Base::Document.new(self, nil, nil)
        end

        def valid?
          path.join(MAIN_FILE_SUBPATH).file?
        end
      end
    end
  end
end
