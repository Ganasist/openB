class AddCompanyNameToContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :company_name, :string
  end
end
