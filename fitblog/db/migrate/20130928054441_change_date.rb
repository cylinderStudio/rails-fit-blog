class ChangeDate < ActiveRecord::Migration
  def change
  	change_column :posts, :post_date, :date
  end
end
