require 'spec_helper'

class MustdownIncluder
  include Mustdown
end

shared_examples_for "Mustdown" do
  let(:binding_object) do
     { name: "test" }
  end

  describe "configure" do
    it "yields with subject as argument" do
      subject.configure { |c| c.markdown_extensions = "configure" }
      subject.markdown_extensions.should eq("configure")
    end
  end

  describe "markdown_extensions=" do
    it "sets the markdown extensions of subject" do
      subject.markdown_extensions = "extensions"
      subject.markdown_extensions.should eq("extensions")
    end
  end

  describe "renderer_options=" do
    it "sets the markdown renderer options of subject" do
      subject.renderer_options = "options"
      subject.renderer_options.should eq("options")
    end
  end

  describe "markdown_renderer=" do
    it "sets the markdown renderer of subject" do
      subject.markdown_renderer = "md renderer"
      subject.markdown_renderer.should eq("md renderer")
    end
  end

  describe "markdown" do
    it "process a template into HTML" do
      output = subject.markdown('# Test')
      output.should eq("<h1>Test</h1>\n")
    end

    it "uses configured renderer class" do
      rndr_class = Class.new(Redcarpet::Render::HTML) do
        def header(*args); super; end
      end

      rndr = rndr_class.new
      rndr_class.stub(:new).and_return(rndr)

      subject.markdown_renderer = rndr_class

      rndr.should_receive(:header)
      subject.markdown('# Test')
    end

    context "when overriding autolink to true" do
      it "generates autolinks" do
        output = subject.markdown("http://test.com", { autolink: true })
        output.should match(/<a /)
      end
    end

    context "when overriding autolink to false" do
      it "doesn't generate any autolink" do
        output = subject.markdown("http://test.com", { autolink: false })
        output.should_not match(/<a /)
      end
    end

    context "when overriding no_links to true" do
      it "doesn't generate any link" do
        output = subject.markdown("[a](http://test.com)", {}, { no_links: true })
        output.should_not match(/<a /)
      end
    end

    context "when overriding no_links to false" do
      it "doesn't generate any link" do
        output = subject.markdown("[a](http://test.com)", {}, { no_links: false })
        output.match(/<a /)
      end
    end
  end

  describe "mustache" do
    it "passes the binding object to the template" do
      output = subject.mustache("{{name}}", binding_object)
      output.should eq("test")
    end
  end

  describe "mustdown" do
    it "renders mustache and then markdown" do
      output = subject.mustdown("# {{name}}", binding_object)
      output.should eq("<h1>test</h1>\n")
    end
  end
end

describe Mustdown do
  subject { Mustdown.dup }
  it_behaves_like "Mustdown"
end

describe MustdownIncluder do
  subject { MustdownIncluder.new }
  it_behaves_like "Mustdown"
end
