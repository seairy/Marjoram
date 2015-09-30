namespace :data do
  desc 'Allocate user to expert for review'
  task allocate: :environment do
    group_a_expert_ids, group_b_expert_ids = [], []
    User.registered.where.not(id: [11, 12, 43, 44, 47, 48, 50, 51, 52, 53, 54, 55]).each do |user|
      group_a_expert_ids = Expert.group_a.map(&:id).shuffle if group_a_expert_ids.empty?
      group_b_expert_ids = Expert.group_b.map(&:id).shuffle if group_b_expert_ids.empty?
      Review.create!([
        { user: user, expert_id: group_a_expert_ids.pop, result: :progressing },
        { user: user, expert_id: group_b_expert_ids.pop, result: :progressing }
      ])
    end
    User.registered.where(id: [11, 12, 43, 44, 47, 48, 50, 51, 52, 53, 54, 55]).each do |user|
      Review.create!([
        { user: user, expert_id: Expert.where(name: '姜明宝').first.id, result: :progressing }
      ])
    end
  end
end