require 'spec_helper'

class MustdownIncluder
  include Mustdown
end

shared_examples_for 'Mustdown' do
  let(:binding_object) {{ name: "test" }}

  describe 'configure' do
    it 'yields with subject as argument' do
      subject.configure { |c| c.markdown_extensions = 'configure' }
      expect(subject.markdown_extensions).to eq 'configure'
    end
  end

  describe 'markdown_extensions=' do
    it 'sets the markdown extensions of subject' do
      subject.markdown_extensions = 'extensions'
      expect(subject.markdown_extensions).to eq 'extensions'
    end
  end

  describe 'renderer_options=' do
    it 'sets the markdown renderer options of subject' do
      subject.renderer_options = 'options'
      expect(subject.renderer_options).to eq 'options'
    end
  end

  describe 'markdown_renderer=' do
    it 'sets the markdown renderer of subject' do
      subject.markdown_renderer = "md renderer"
      expect(subject.markdown_renderer).to eq 'md renderer'
    end
  end

  describe 'markdown' do
    it 'process a template into HTML' do
      output = subject.markdown('# Test')
      expect(output).to eq "<h1>Test</h1>\n"
    end

    it 'uses configured renderer class' do
      rndr_class = Class.new(Redcarpet::Render::HTML) do
        def header(*args); super; end
      end

      rndr = rndr_class.new
      allow(rndr_class).to receive(:new).and_return(rndr)

      subject.markdown_renderer = rndr_class

      expect(rndr).to receive(:header)
      subject.markdown('# Test')
    end

    context 'when overriding autolink to true' do
      it 'generates autolinks' do
        output = subject.markdown('http://test.com', { autolink: true })
        expect(output).to match /<a /
      end
    end

    context "when overriding autolink to false" do
      it "doesn't generate any autolink" do
        output = subject.markdown("http://test.com", { autolink: false })
        expect(output).not_to match /<a /
      end
    end

    context 'when overriding no_links to true' do
      it 'doesn’t generate any link' do
        output = subject.markdown('[a](http://test.com)', {}, { no_links: true })
        expect(output).not_to match /<a /
      end
    end

    context 'when overriding no_links to false' do
      it 'doesn’t generate any link' do
        output = subject.markdown('[a](http://test.com)', {}, { no_links: false })
        expect(output).to match /<a /
      end
    end
  end

  describe 'mustache' do
    it 'passes the binding object to the template' do
      output = subject.mustache('{{name}}', binding_object)
      expect(output).to eq 'test'
    end
  end

  describe 'mustdown' do
    it 'renders mustache and then markdown' do
      output = subject.mustdown('# {{name}}', binding_object)
      expect(output).to eq "<h1>test</h1>\n"
    end
  end
end

describe Mustdown do
  subject { Mustdown.dup }
  it_behaves_like 'Mustdown'
end

describe MustdownIncluder do
  subject { MustdownIncluder.new }
  it_behaves_like 'Mustdown'
end
