# frozen_string_literal: true

module Avm
  module EacAsciidoctorBase0
    module Instances
      class Build
        class Document
          class HeaderLines
            class DocinfoLines
              acts_as_instance_method
              enable_memoized
              common_constructor :header_lines

              delegate :attribute_line, :build, :relative_path_to_stylesheet, :source_document,
                       to: :header_lines

              DOCINFO = 'shared-head'
              BASENAME = 'docinfo.html'
              DIRECTORY_EXTNAME = '.docinfo'

              # @return [String]
              def content
                "<link rel=\"stylesheet\" href=\"#{relative_path_to_stylesheet}\">\n"
              end

              # @return [Pathname]
              memoize def directory
                build.pre_processed_directory.join("#{source_document.subpath}#{DIRECTORY_EXTNAME}")
                  .then do |r|
                    r.mkpath
                    r.join(BASENAME).write(content)
                    r
                  end
              end

              # @return [Array<String>]
              def result
                [attribute_line('docinfo', DOCINFO),
                 attribute_line('docinfodir', directory.to_path)]
              end
            end
          end
        end
      end
    end
  end
end
