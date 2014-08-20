User.destroy_all
Wiki.destroy_all

User.create!(email: 'joe1@b.com', password: 'password123', confirmed_at: Time.now)
User.create!(email: 'joe2@b.com', password: 'password123', confirmed_at: Time.now)
User.create!(email: 'joe3@b.com', password: 'password123', confirmed_at: Time.now)
 
#TODO Add dynamic wiki owners(user_id) so dropping db before each seed isn't necc.
Wiki.create!(title: 'wiki 1', body: 'lorem ipsume, latty dotty.', user_id: 1, private: true)
Wiki.create!(title: 'wiki 2', body: 'lorem ipsume, latty dotty.', user_id: 2)
Wiki.create!(title: 'wiki 3', body: 'lorem ipsume, latty dotty.', user_id: 3)
Wiki.create!(title: 'wiki 4', body: 'lorem ipsume, latty dotty.', user_id: 1)
Wiki.create!(title: 'wiki 5', body: 'lorem ipsume, latty dotty.', user_id: 2)

p "Created #{User.count} users and #{Wiki.count} wikis."
