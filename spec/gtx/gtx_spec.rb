require 'spec_helper'

describe GTX do
  let(:context) do
    Class.new do
      def user
        "admin"
      end
    end.new
  end

  Dir["examples/*.rb"].each do |example|
    approval_name = example.gsub(/.rb$/, '')

    describe example do
      subject { described_class.load_file example }

      it "generates the correct ERB source" do
        expect(subject.erb_source).to match_approval("#{approval_name}.erb")
      end

      it "generates the correct output" do
        expect(subject.parse context).to match_approval("#{approval_name}.txt")
      end
    end
  end

end
