require 'spec_helper'

RSpec.describe Mustdown::MustdownHelper do
  describe '#mustache' do
    it 'renders a mustache template with a binding object' do
      output = helper.mustache('{{test}}', test: 'hello')
      expect(output).to eq 'hello'
    end
  end

  describe '#markdown' do
    it 'renders a markdown template as HTML' do
      expect(helper.markdown('# Test')).to eq "<h1>Test</h1>\n"
    end
  end

  describe '#mustdown' do
    it 'renders a mustache/markdown template as HTML with a binding object' do
      output = helper.mustdown('# {{test}}', test: 'hello')
      expect(output).to eq "<h1>hello</h1>\n"
    end
  end
end
