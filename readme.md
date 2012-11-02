rails new kiwitime

rails g scaffold User name:string email:string

rails g migration add_password_to_users encrypted_password:string
rails g migration add_salt_to_users salt:string

rails g scaffold Project name:string
rails g scaffold Task name:string description:string time_forecast:integer project_id:integer finished:boolean
rails g scaffold Sitting user_id:integer task_id:integer start:datetime end:datetime

rails g migration remove_start_and_end_from_sittings start:datetime end:datetime
rails g migration add_day_to_sittings day:date start:time end:time

//rails g scaffold Micropost content:string user_id:integer

rake db:migrate

//rake db:rollback
//rake db:reset
//rake db:test:prepare

//rails destroy scaffold Micropost

//rails g migration add_email_uniqueness_index

//gem install annotate
//annotate


