# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :events do
  primary_key :id
  String :title
  String :description, text: true
  String :date
  String :time
  String :location
end
DB.create_table! :rsvps do
  primary_key :id
  foreign_key :event_id
  foreign_key :user_id
  Boolean :going
  String :comments, text: true
end
DB.create_table! :users do
    primary_key :id
    String :name
    String :email
    String :password
end

# Insert initial (seed) data
events_table = DB.from(:events)

events_table.insert(title: "Deloitte Consulting Networking Event", 
                    description: "Deloitte Consulting is looking to hire practitioners in the Human Capital, Technology, and Strategy & Operations practice.
                    To better understand Deloitte Consulting and the different service lines offered, we will be hosting a networking event in Chicago.
                    We will kick-off with a presentation of the different service lines, and then we will conclude with a networking event where several of our practitioners from the different service lines will be present to network. 
                    Join us for drinks and hors d'oeuvres!",
                    date: "April 04, 2020",
                    time: "7:00PM - 10:00PM",
                    location: "Aloft Chicago Mag Mile in Chicago IL")

events_table.insert(title: "AT Kearney Case Preparation & Networking", 
                    description: "We are a global management consulting firm that focuses on solving strategic and operational problems.
                    We will be offering a case prep where our consultants will sit with you to work out a case that we previously consulted on.
                    This is a great opportunity to learn how to structure a case, strategies for quick math, and how to efficiently deliver your recommendations. 
                    After the case, you will have an opportunity to network with our practitioners over drinks!",
                    date: "April 11, 2020",
                    time: "6:00PM - 9:00PM",
                    location: "Kellogg Global Hub in Evanston, IL")

events_table.insert(title: "Nike Bike Ride & Post-brunch", 
                    description: "At Nike, we love sports, it is within our DNA. Join us for a fun bike ride across Chicago with tour guides to explain the quirky, fun areas. The bike ride will begin at 9:30AM, we will meet in front of the Shedd Aquarium, and it will last for one hour.
                    After the bike ride, join us for a much deserved brunch at 'Wildberry Pancakes & Cafe' with bottomless mimosas! We will explain what is new at Nike, as well as the internship and job opportunities that are coming up.",
                    date: "May 18, 2020",
                    time: "9:30AM - 12:00PM",
                    location: "Shedd Aquarium in Chicago, IL")

