class Goal < ApplicationRecord
  has_many :children, class_name: 'Goal', foreign_key: :parent_id
  belongs_to :parent, class_name: 'Goal', optional: true
  
  def list_goals
    get_children(self).to_json
  end

  def get_children(goal)
    goal_children = []
    unless goal.children.blank?
      goal.children.each do |g|
        goal_children << get_children(g)
      end
    end
    {id: goal.id, title: goal.title, progress: goal.progress, children: goal_children}
  end
end

