class AddQuestionsCountToSubjects < ActiveRecord::Migration[6.1]
  def change
    add_column :subjects, :questions_count, :intereger
  end
end
