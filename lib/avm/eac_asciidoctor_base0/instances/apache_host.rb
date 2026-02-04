# frozen_string_literal: true

module Avm
  module EacAsciidoctorBase0
    module Instances
      class ApacheHost < ::Avm::EacWebappBase0::Instances::ApacheHost
        def document_root
          instance.read_entry(::Avm::Instances::EntryKeys::INSTALL_PATH)
        end

        def extra_content
          ''
        end
      end
    end
  end
end
