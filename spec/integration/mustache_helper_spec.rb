RSpec.describe '`mustache` helper', type: :integration do
  it 'works' do
    visit '/mustache'
    expect(page).to have_content('Hello Mustache')
  end
end
