# Simplified GO-FOOD Web Apps

## Using Rails version  5.1.4
  arishermawan@gmail.com
  https://github.com/rizhima/kolla-go-food

### 1. Installing rails
   * Install rails
   ```
   gem install rails
   ```



    **if there are any error with `exejs`, find Gemfile and uncomment `gem therubyracer, platforms: :ruby` type `build` and start server `rails server`**



### 2. Rails Features

  * Create new rails project
    ```
    rails new project_name
    ```

  * Rails File Generates

    * Scaffold `rails generates scaffold Buyers name:string email:string addres:text`

    * Model `rails generates model Buyer name:string email:string addres:text`

    * Controller `rails generates controller Buyers`

    * Database Migration `rails generates migration AddCategoryToFood category_id:integer`


  * Rails Console
    type `rails c` in terminal


  * Starting Rails Server
    start puma server and open `localhost:3000` at browser to access created rails app, type in terminal:
    ```
    rails server
    ```

### 3. Rails Database

  After create a model or migration file, type in terminal :

  * Create database `rails db:create`

  * Build changes db from migration file `rails db:migrate`

  * Reverse database state `rails db:roolback`

  * Delete databse `rails db:drop`

### 4. Modify View

  * passing variable or put logical syntax in view with `<% variable_name %>`

  * passing variable and print variable `<%= variable_name %>`

  * add .css file in `app/assets/stylesheets/`

  * .css class name is refers to object Class name, example
    if model name `Buyer` and then **.css class name is `buyers`**



## 5. Active Record
- `Model.all` --> get all data from database

- `Model.find(1)` --> get data from database when id=1

- `Model.where(username=='aris')` --> get data from database where username=='aris'

- `Model.create(username=='aris')` --> insert data to database

- Return of Active Record is **Special Object Active Record Relation** but can call like Array


## Deployment with puma & nginx

  1. Setting Configuration

    * set `/config/environments/production.rb`:
    ```ruby
    Rails.application.configure do
      config.cache_classes = true
      config.eager_load = true
      config.consider_all_requests_local       = false
      config.action_controller.perform_caching = true
      config.read_encrypted_secrets = true
      config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
      config.assets.js_compressor = :uglifier
      config.assets.compile = false
      config.log_level = :debug
      config.log_tags = [ :request_id ]
      config.action_mailer.perform_caching = false
      config.i18n.fallbacks = true
      config.active_support.deprecation = :notify
      config.log_formatter = ::Logger::Formatter.new
      if ENV["RAILS_LOG_TO_STDOUT"].present?
        logger           = ActiveSupport::Logger.new(STDOUT)
        logger.formatter = config.log_formatter
        config.logger    = ActiveSupport::TaggedLogging.new(logger)
      end
      config.active_record.dump_schema_after_migration = false
    end
    ```
    * set `/config/puma.rb` to:
      ```
      threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
      threads threads_count, threads_count

      bind "unix:///home/aris/go-food/tmp/sockets/puma.sock"
      port        ENV.fetch("PORT") { 3000 }
      environment ENV.fetch("RAILS_ENV") { "development" }

      workers ENV.fetch("WEB_CONCURRENCY") { 2 }

      preload_app!

      on_worker_boot do
        ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
      end

      plugin :tmp_restart

      pidfile '/home/aris/go-food/tmp/pids/puma.pid'
      ```

    * Compress rails assets data:
      to compress: `Rails assets:precompile`
      to remove all compressed assets data: `Rails assets:clobber`


    * How to Run, type in terminal:
      ```
      RAILS_ENV=production rails db:create

      RAILS_ENV=production rails db:migrate

      export RAILS_SERVE_STATIC_FILES = true

      aris@aris:~/go-food$ env | grep RAILS

      RAILS_ENV=production SECRET_KEY_BASE=aris puma -C config/puma.rb -d

      ```



  2. Setting NGINX and Integration with PUMA

    * Ensure Puma Server is off
      ```
      ps aux | grep puma

      kill -9 [pid]
      ```

    * Install NGINX
      ```
      sudo apt-get install nginx
      ```
    * Start nginx service
      ```
      sudo service nginx start
      ```
    * Check nginx service is started
      ```
      ps aux | grep nginx
      ```
    * Create Config file `kolla_go_food`
      ```
      upstream kolla_go_food {
        server unix:///home/aris/go-food/tmp/sockets/puma.sock  fail_timeout=0;
      }

      server {
        listen 80;

        sendfile off;

        server_name localhost;

        root /home/aris/go-food/public;

        try_files $uri/index.html $uri @kolla_go_food;

        location @kolla_go_food {
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header Host $http_host;
          proxy_redirect off;
          proxy_pass http://kolla_go_food;
        }

       # error_page 500 502 503 504 /500.html;
        client_max_body_size 4G;
        keepalive_timeout 10;
      }
      ```
      * config `in kolla_go_food` file
        * save in `etc/nginx/sites-available/`
        * open in terminal `etc/nginx/sites-enabled/`
        * delete default file `sudo rm default`
        * set config file `ln -s /etc/nginx/sites-available/kolla_go_food /etc/nginx/sites-enabled/`


    * ensure `RAILS_SERVE_STATIC_FILES = false`
      ```
      export RAILS_SERVE_STATIC_FILES = false

      aris@aris:~/go-food$ env | grep RAILS
      ```

    * restart nginx service
      ```
        sudo service nginx restart
      ```

    * open in browser `localhost:80` or `localhost`
