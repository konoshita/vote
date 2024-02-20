class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.references :vote, null: false, foreign_key: true
      t.text :body
      t.string :evaluation, null: false, default: 0

      t.timestamps
    end
  end
end
