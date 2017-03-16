RSpec.describe '`markdown` helper', type: :integration do
  it 'works' do
    visit '/markdown'
    expect(page).to have_css(:p, text: "Hello Markdown")
  end
end
