require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  include TestHelpers

  def test_can_create_a_task
    data = {
      title:       "some title",
      description: "some description"
    }

    task_manager.create(data)

    task = task_manager.all.last

    assert task.id
    assert_equal "some title", task.title
    assert_equal "some description", task.description
  end

  def test_all_finds_all_tests
    data1 = {
      title:       "some title",
      description: "some description"
    }

    data2 = {
      title:       "another title",
      description: "another description"
    }
    task_manager.create(data1)
    task_manager.create(data2)
    tasks = task_manager.all
    task1 = tasks[-2]
    task2 = tasks[-1]

    assert tasks.include?(task1)
    assert tasks.include?(task2)
    assert_equal 2, tasks.size
  end

  def test_find_finds_by_id
    data1 = {
      title:       "some title",
      description: "some description"
    }

    data2 = {
      title:       "another title",
      description: "another description"
    }

    task_manager.create(data1)
    task_manager.create(data2)
    tasks = task_manager.all
    task1 = tasks[-2]
    task2 = tasks[-1]

    assert_equal "some title", task_manager.find(1).title
    assert_equal "another title", task_manager.find(2).title
    refute_equal "some random thing", task_manager.find(2).title
  end

  def test_update_updates_data
    data1 = {
      title:       "some title",
      description: "some description"
    }

    task_manager.create(data1)

    new_data = {
      title: "updated title",
      description: "updated description"
    }

    task = task_manager.all.last
    task_manager.update(task.id, new_data)
    task = task_manager.all.last

    assert_equal "updated title", task.title
    assert_equal "updated description", task.description
  end

  def test_delete_deletes_a_thing
    data1 = {
      title:       "some title",
      description: "some description"
    }

    task_manager.create(data1)
    task = task_manager.all.last

    assert task
    assert_equal 1, task_manager.all.size

    task_manager.delete(task.id)
    tasks = task_manager.all

    assert_equal 0, tasks.size
  end
end
