# frozen_string_literal: true

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
