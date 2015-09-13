class UpdateAddresses1 < ActiveRecord::Migration
  def up
    execute(%q{
      UPDATE phones SET last_four_digits = substr(number, -4, 4)
      WHERE number IS NOT NULL
    })
  end

  def down
    execute(%q{
      UPDATE phones SET last_four_digits = NULL
    })
  end
end
