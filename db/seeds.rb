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
# seed data of permission for customer
Permission.create(user_type_id: user_type_2.id, dashboard: false, ticket: true, usertype: false, user: true,
                  add: true, edit: true,remove_ability: false)

# seed data for admin user
User.create(name: 'John Doe',
            username: 'admin',
            password: 'secret',
            email: 'admin@example.com',
            ip_address: ip_address,
            published: true,
            user_type_id: user_type.id,
            profession: 'Web Developer',
            phone: '123456789')

# seed data for agent
3.times do |n|
  User.create(name: "Agent#{n+1}",
              username: "agent#{n+1}",
              password: 'secret',
              email: "agent#{n+1}@example.com",
              ip_address: ip_address,
              published: true,
              user_type_id: 2,
              profession: 'customer care',
              phone: '123456789')

end
# seed data for customer
5.times do |n|
  user = User.create(name: "Customer#{n+1}",
                     username: "customer#{n+1}",
                     password: 'secret',
                     email: "customer#{n+1}@example.com",
                     ip_address: ip_address,
                     published: true,
                     user_type_id: 3,
                     profession: 'service holder',
                     phone: '123456789')

# seed data for open ticket
  5.times do |m|
    Ticket.create(name: user.name,
                  email: user.email,
                  subject: "This is test subject #{m+1}",
                  message: "This is test message #{m+1}",
                  user_id: "#{user.id}",
                  status_type: 'open')

# seed data for ticket which were closed one month ago.
    15.times do |p|
      Ticket.create(name: user.name,
                    email: user.email,
                    subject: "This is test subject #{p+1}",
                    message: "This is test message #{p+1}",
                    user_id: "#{user.id}",
                    status_type: 'closed',
                    created_at: 1.month.ago.beginning_of_month,
                    updated_at: 1.month.ago.beginning_of_month)
    end
  end
end
puts 'Seed data are filled into database successfully.'
