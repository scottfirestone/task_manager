require_relative '../test_helper'

class UserCreatesTaskTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers

  def test_with_valid_attributes
    visit '/'
    click_link('New Task')
    fill_in("task[title]", with: 'Brush My Teeth')
    fill_in('task[description]', with: 'Get them all clean')
    click_button('submit')

    assert_equal "/tasks", current_path
    
    within("#tasks") do
      assert page.has_content?("Brush My Teeth")
    end
  end
end
