class AddStatusToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :status, :string
  end
end
