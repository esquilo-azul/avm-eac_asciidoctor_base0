# frozen_string_literal: true

RSpec.describe Avm::EacAsciidoctorBase0::FileFormats::Base do
  include_examples 'avm_file_format_file_resource_name', {
    'content/title' => 'Content[/]',
    'content/body.adoc' => 'Content[/]',
    'content/abc/title' => 'Content[/abc]',
    'content/abc/body.adoc' => 'Content[/abc]',
    'content/abc/sub/body.adoc' => 'Content[/abc/sub]'
  }
end
