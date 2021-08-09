class Goal < ApplicationRecord
  has_many :children, class_name: 'Goal', foreign_key: :parent_id
  belongs_to :parent, class_name: 'Goal', optional: true

  scope :roots, -> { where(parent_id: nil) }

  def list_goals
    output = []
    Goal.roots.each do |goal|
      output << goal_unique(goal)
    end
    output.to_json
  end

  def goal_unique(goal)
    subordinates = []
    unless goal.children.blank?
      goal.children.each do |g|
        subordinates << goal_unique(g)
      end
    end
    {id: goal.id, title: goal.title, progress: goal.progress, children: subordinates}
  end
end

