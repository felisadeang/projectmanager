# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Department.create(name: 'Human Resources')
Department.create(name: 'Finance')
Department.create(name: 'Technology')
Department.create(name: 'Operations')
Department.create(name: 'Marketing')
Department.create(name: 'Legal')

User.create(first_name: 'Kelsey', last_name: 'Ganes', department_id: '5', email: 'kelsey@gmail.com', password: 'password', password_confirmation: 'password', manager: true)
User.create(first_name: 'Felisa', last_name: 'Deang', department_id: '6', email: 'felisa@gmail.com', password: 'password', password_confirmation: 'password')
User.create(first_name: 'Bill', last_name: 'Gates', department_id: '3', email: 'bill@gmail.com', password: 'password', password_confirmation: 'password')