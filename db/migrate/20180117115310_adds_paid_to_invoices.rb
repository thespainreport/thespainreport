class AddsPaidToInvoices < ActiveRecord::Migration
  def change
  	add_column :invoices, :paid, :boolean
  end
end
