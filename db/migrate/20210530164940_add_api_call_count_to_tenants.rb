class AddApiCallCountToTenants < ActiveRecord::Migration[6.0]
  def change
    add_column :tenants, :api_call_count, :integer, default: 0
  end
end
