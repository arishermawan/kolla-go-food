# GO-FOOD Appwith Rails 

# Rails version  5.1.4

## 1. Installing software
   - Install rails
           gem install rails
     
   - Install therubyracer
           gem install therubyracer
     
   - Install execjs
           gem install execjs
     
     
#### if there are any error with ```exejs```, find Gemfile and uncomment ```gem therubyracer, platforms: :ruby``` type ```build``` and start server ```rails server```



## 2. Using Rails

- make new rails project

      rails new project_name

- make new rails document such as Controller, Model

      rails generates type Controller_name action_name

- Powerfull tools for testing rails methods

      rails c

- start puma server and open localhost:3000 to access created rails app

      rails server



## 3. Add new action in Controller

- add new action method in controller

- passing variable in view with **<%= variable_name%>** or **<% variable_name%>** (not display in page)

- add new route **<classname>/<actionname> example : Home\Hello**
  
- if necessary add a view file **(.html.erb)**






## 4. Setting Database
- create model first
        rails generates model (model_name)
        
- open migrate folder and add variable to migrate

- open console and type `rails db:create`

- type `db:migrates`

- if there any changes in migrates use `db:roolback` and change migrates file then `rails db:migrates`





## 5. Active Record
- `Model.all` --> get all data from database

- `Model.find(1)` --> get data from database when id=1

- `Model.where(username=='aris')` --> get data from database where username=='aris'

- `Model.create(username=='aris')` --> insert data to database

- Return of Active Record is **Special Object Active Record Relation** but can call like Array