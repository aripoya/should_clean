require 'spec_helper'

describe ShouldClean do
  let(:spec_file) { File.join(File.dirname(__FILE__), 'fixtures', 'project', 'spec', 'models', 'example_spec.rb') }
  let(:example_file) { File.join(File.dirname(__FILE__), 'fixtures', 'example_spec.txt') }
  let(:correct_spec_file) { File.join(File.dirname(__FILE__), 'fixtures', 'example_correct_spec.txt') }

  before :each do
    FileUtils.cp(example_file, spec_file)
    @original_content = File.read(spec_file)
  end

  after :each do
    File.open(spec_file, 'w') do |file|
      file.puts @original_content
    end
  end

  it "can clean multiple files" do
    app_directory = File.join(File.dirname(__FILE__), 'fixtures', 'project')
    ShouldClean.clean(app_directory, false)
    FileUtils.compare_file(spec_file, correct_spec_file).should be_true
  end
end
