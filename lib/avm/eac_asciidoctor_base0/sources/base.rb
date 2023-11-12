# frozen_string_literal: true

require 'avm/eac_webapp_base0/sources/base'
require 'avm/eac_asciidoctor_base0/documents_owner'
require 'avm/eac_asciidoctor_base0/instances/build'
require 'avm/eac_asciidoctor_base0/sources/document'
require 'avm/eac_asciidoctor_base0/sources/runners'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacAsciidoctorBase0
    module Sources
      class Base < ::Avm::EacWebappBase0::Sources::Base
        require_sub __FILE__, include_modules: true
        include ::Avm::EacAsciidoctorBase0::DocumentsOwner

        CONTENT_DIRECTORY_SUBPATH = ::Pathname.new('content')
        CONTENT_DOCUMENT_BASENAME = ::Pathname.new('body.adoc')
        MAIN_FILE_SUBPATH = CONTENT_DIRECTORY_SUBPATH.join(
          ::Avm::EacAsciidoctorBase0::Sources::Document::TITLE_BASENAME
        )

        # @param options [Hash]
        # @return [Avm::EacAsciidoctorBase0::Instances::Build]
        def build(options = {})
          ::Avm::EacAsciidoctorBase0::Instances::Build.new(instance_to_build, options)
        end

        def content_directory
          path.join(CONTENT_DIRECTORY_SUBPATH)
        end

        # @return [Avm::EacAsciidoctorBase0::Sources::Base::InstanceToBuild]
        def instance_to_build
          ::Avm::EacAsciidoctorBase0::Sources::Base::InstanceToBuild.new(self)
        end

        # @return [Avm::EacAsciidoctorBase0::Sources::Document
        def root_document
          ::Avm::EacAsciidoctorBase0::Sources::Document.new(self, nil, nil)
        end

        def valid?
          path.join(MAIN_FILE_SUBPATH).file?
        end
      end
    end
  end
end
