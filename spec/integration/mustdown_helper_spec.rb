RSpec.describe '`mustdown` helper', type: :integration do
  it 'works' do
    visit '/mustdown'
    expect(page).to have_css(:p, text: "Hello Mustdown")
  end
end
