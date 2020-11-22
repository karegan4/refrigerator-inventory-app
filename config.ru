require './config/environment'
use Rack::MethodOverride

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use InventoryController
use ListItemController
use UserController
run ApplicationController
