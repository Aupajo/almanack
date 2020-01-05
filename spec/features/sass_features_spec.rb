
RSpec.describe "Sass rendering", :feature do
  before { Almanack.reset! }

  it "can import sass" do
    allow(Almanack.config).to receive(:theme_root) { fixture_theme('sassy') }
    get "/stylesheets/imports.css"
    raise last_response.errors unless last_response.errors.empty?
    normalized_css = last_response.body.gsub(/\s+/, ' ')
    expect(normalized_css).to include('imports { passes: ok; }')
  end

  def fixture_theme(name)
    Pathname(__dir__).parent.join('fixtures', 'themes', name)
  end
end
