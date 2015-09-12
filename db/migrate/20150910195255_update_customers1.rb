class UpdateCustomers1 < ActiveRecord::Migration
  def up
    execute(%q{
      UPDATE customers SET birth_year = strftime('%Y', birthday),
      birth_month = strftime('%m', birthday),
      birth_mday = strftime('%d', birthday)
      WHERE birthday IS NOT NULL
    })
  end

  def down
    execute(%q{
      UPDATE customers SET birth_year = NULL,
      birth_month = NULL,
      birth_mday = NULL
    })
  end
end
