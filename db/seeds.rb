# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ip_address = UsersHelper.ip_address
user_type = UserType.create(name: 'admin', published: true)
user_type_1 = UserType.create(name: 'agent', published: true)
user_type_2 = UserType.create(name: 'customer', published: true)

Permission.create(user_type_id: user_type.id, dashboard: true, ticket: true, usertype: true, user: true,
                  add: true, edit: true,remove_ability: true)

Permission.create(user_type_id: user_type_1.id, dashboard: false, ticket: true, usertype: false, user: false,
                  add: true, edit: true,remove_ability: false)

Permission.create(user_type_id: user_type_2.id, dashboard: false, ticket: true, usertype: false, user: true,
                  add: true, edit: true,remove_ability: false)


User.create(name: 'Tanbir Hasan',
            username: 'hmtanbir',
            password: 'secret',
            email: 'tanbir2025@gmail.com',            
            ip_address: ip_address,
            published: true,
            user_type_id: user_type.id,
            profession: 'Web Developer',
            phone: 123456789)
