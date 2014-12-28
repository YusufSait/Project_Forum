class AddTopicRefToTopics < ActiveRecord::Migration
  def change
    add_reference :topics, :topic, index: true
  end
end
