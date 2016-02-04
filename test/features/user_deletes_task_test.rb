require_relative '../test_helper'

class UserDeletesTaskTest < Minitest::Test
  include Capybara::DSL
  include TestHelpers

  def test_with_valid_attributes

    task_manager.create({
      title:       "kimi!", description: "cool stuff!"})
    task_manager.create({
      title:       "new new task!", description: "not cool stuff!"
      })

    visit '/tasks'

    assert page.has_content?("kimi!")
    assert page.has_content?("new new task!")

    click_button('Delete', match: :first)

    save_and_open_page

    within("#tasks") do
      assert page.has_content?("new new task!")
    end

    within("#tasks") do
      refute page.has_content?("kimi!")
    end
  end
end
