require 'csv'

desc "Imports a customer CSV file into an ActiveRecord table"
task :customers_import => :environment do
    CSV.foreach('./db/customers.csv', :headers => true) do |row|
      Customer.create!(row.to_h)
    end
end
desc "Imports a merchants CSV file into an ActiveRecord table"
task :merchants_import => :environment do
    CSV.foreach('./db/merchants.csv', :headers => true) do |row|
      Merchant.create!(row.to_h)
    end
end
desc "Imports an items CSV file into an ActiveRecord table"
task :items_import => :environment do
    CSV.foreach('./db/items.csv', :headers => true) do |row|
      Item.create!(row.to_h)
    end
end
desc "Imports an invoices CSV file into an ActiveRecord table"
task :invoices_import => :environment do
    CSV.foreach('./db/invoices.csv', :headers => true) do |row|
      Invoice.create!(row.to_h)
    end
end
desc "Imports an invoice items CSV file into an ActiveRecord table"
task :invoice_items_import => :environment do
    CSV.foreach('./db/invoice_items.csv', :headers => true) do |row|
      InvoiceItem.create!(row.to_h)
    end
end
desc "Imports an invoice items CSV file into an ActiveRecord table"
task :transactions_import => :environment do
    CSV.foreach('./db/transactions.csv', :headers => true) do |row|
      Transaction.create!(row.to_h)
    end
end
