require 'spec_helper'

describe GTX do
  subject { described_class.new template }
  let(:context) { double user: 'admin' }
  let(:template) { "> some output\nruby_code = 'yes'\n= ruby_code" }
  let(:example_path) { "examples/full.gtx" }

  describe 'full example' do
    subject { described_class.load_file example_path }

    it "generates the correct ERB source" do
      expect(subject.erb_source).to match_approval("examples/full.erb")
    end

    it "generates the correct output" do
      expect(subject.parse context).to match_approval("examples/full.txt")
    end
  end

  describe '#erb_source' do
    it "returns ERB code" do
      expect(subject.erb_source).to match_approval("gtx/erb_source")
    end
  end

  describe '#erb' do
    it "returns ERB object" do
    end
  end

  describe '#parse' do
    it "returns the parsed ERB output" do
      expect(subject.parse context).to match_approval('gtx/parse')
    end

    context "on error" do
      subject { described_class.load_file "spec/fixtures/error.gtx" }

      it "registers the correct file and line number in the backtrace" do
        expect { subject.parse }.to raise_error(ZeroDivisionError) do |e|
          expect(e.backtrace.first).to include "spec/fixtures/error.gtx:18"
        end
      end
    end

    context "when a Binding object is passed instead of a regular object" do
      let(:context) do 
        module Context
          class One
            def get_binding; binding; end
          end

          class Two
            def report; "success"; end
          end
        end

        Context::One.new.get_binding
      end

      let(:template) { "= Two.new.report" }

      it "uses the Binding object as is instead of re-binding it" do        
        expect(subject.parse context).to match_approval('gtx/parse-binding')
      end
    end
  end

  context "class methods" do
    subject { described_class }

    describe "::render" do
      it "returns a parsed result" do
        expect(subject.render template, context: context).to match_approval('gtx/parse')
      end
    end

    describe "::load_file" do
      subject { described_class.load_file example_path }

      it "returns a GTX object" do
        expect(subject).to be_a GTX
      end

      it "loads the file's content to the GTX object" do
        expect(subject.template).to eq File.read(example_path)
      end

      it "sets the filename to the template's path" do
        expect(subject.filename).to eq example_path
      end
    end

    describe "::render_file" do
      let(:gtx_double) { double :parse }

      it "is a shortcut to ::load_file(path).parse context" do
        expect(subject).to receive(:load_file).with(example_path, filename: nil).and_return(gtx_double)
        expect(gtx_double).to receive(:parse).with(context)
        subject.render_file example_path, context: context
      end
    end
  end

end
