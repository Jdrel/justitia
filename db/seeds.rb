puts 'Cleaning database...'
Client.destroy_all
Lawyer.destroy_all
User.destroy_all
Category.destroy_all
Specialty.destroy_all

Category::CATEGORIES.each do |category|
  Category.create(
    name: category
  )
end

seed_categories = Category.all
lawyer_rates = [120, 180, 240, 300, 360, 420, 480]
lawyer_cities = ['Madrid', 'Barcelona', 'Valencia', 'Seville', 'Zaragoza', 'Málaga', 'Murcia', 'Palma', 'Las Palmas de Gran Canaria', 'Bilbao', 'Alicante', 'Córdoba', 'Valladolid']

puts 'Creating 10 lawyers...'

lawyers = [
  {
    first_name: 'Mitchell',
    last_name: 'Allen',
    address: lawyer_cities.sample,
    email: 'mitchell@justitia.today',
    password: 'secret',
    description: 'I have been in practice for 25 years and have helped thousands of people overcome debt problems. I have offices in Jonesboro and Batesville Arkansas.  I live on a 6 acre hobby farm. In my free time I raise horses, hike, camp, fish, and enjoy anything outdoors. I am an amateur blacksmith and welder and love to repurpose found objects.',
    years_of_experience: rand(5..45),
    hourly_rate: lawyer_rates.sample,
    is_first_consultation_free: Faker::Boolean.boolean,
    is_online: Faker::Boolean.boolean,
    photo: 'https://images.avvo.com/avvo/ugc/images/head_shot/standard/lawyer_mitchell_allen_4317556_1522957581.jpg',
    stripe_id: 'acct_1CxAnNATifAI3fgp'
  },
  {
    first_name: 'Christopher',
    last_name: 'Lockwood',
    address: lawyer_cities.sample,
    email: 'christopher@justitia.today',
    password: 'secret',
    description: 'Chris Lockwood practices in the areas of business litigation and government contracts. Chris is a shareholder with the Wilmer & Lee Government Contracts Practice Group and has successfully represented government contractors in a variety of matters including bid protests, size issues, claims disputes, and regulatory matters.',
    years_of_experience: rand(5..45),
    hourly_rate: lawyer_rates.sample,
    is_first_consultation_free: Faker::Boolean.boolean,
    is_online: Faker::Boolean.boolean,
    photo: 'https://images.avvo.com/avvo/ugc/images/head_shot/standard/lawyer_christopher_lockwood_4306656_1522964071.jpg',
    stripe_id: 'acct_1CxAnNATifAI3fgp'
  },
  {
    first_name: 'Kira',
    last_name: 'Fonteneau',
    address: lawyer_cities.sample,
    email: 'kira@justitia.today',
    password: 'secret',
    description: 'Kira Fonteneau was born in Detroit, Michigan and raised in Chesapeake, Virginia. She holds a Bachelor of Arts from The University of Virginia and a Juris Doctor from the University of Georgia School of Law. In 2005, Kira began her legal career in Birmingham. Ms. Fonteneau is Licensed to practice law in Alabama, Georgia, and Virginia, but focuses her practice in Alabama. From 2013 until 2016 Kira served as Jefferson County’s first Public Defender. Prior to joining the Public Defender’s Office, Ms. Fonteneau maintained an active practice focusing in criminal defense, employment law, and other civil litigation.',
    years_of_experience: rand(5..45),
    hourly_rate: lawyer_rates.sample,
    is_first_consultation_free: Faker::Boolean.boolean,
    is_online: Faker::Boolean.boolean,
    photo: 'https://images.avvo.com/avvo/ugc/images/head_shot/standard/lawyer_kira_fonteneau_1810159_1541689882.jpg',
    stripe_id: 'acct_1CxAnNATifAI3fgp'

  },
  {
    first_name: 'Meegan',
    last_name: 'Nelson',
    address: lawyer_cities.sample,
    email: 'meegan@justitia.today',
    password: 'secret',
    description: 'Meegan Colclough practices in the area of business law with an emphasis in taxation matters. Ms. Colclough advises clients in the areas of corporate law and taxation, Employee Stock Ownership Plans (“ESOPs”) and other qualified retirement plans, estate and business succession planning, and tax controversy matters with the IRS, state and municipal agencies. Ms. Colclough was with Lyons, Pipes & Cook, (LPC) in Mobile before the firm joined Phelps Dunbar.',
    years_of_experience: rand(5..45),
    hourly_rate: lawyer_rates.sample,
    is_first_consultation_free: Faker::Boolean.boolean,
    is_online: Faker::Boolean.boolean,
    photo: 'https://images.avvo.com/avvo/ugc/images/head_shot/standard/lawyer_meegan_nelson_4313716_1522960149.jpg',
    stripe_id: 'acct_1CxAnNATifAI3fgp'
  },
  {
    first_name: 'Pamela',
    last_name: 'Johnston',
    address: lawyer_cities.sample,
    email: 'pamela@justitia.today',
    password: 'secret',
    description: '',
    years_of_experience: rand(5..45),
    hourly_rate: lawyer_rates.sample,
    is_first_consultation_free: Faker::Boolean.boolean,
    is_online: Faker::Boolean.boolean,
    photo: 'https://images.avvo.com/avvo/ugc/images/head_shot/standard/lawyer_pamela_johnston_1231493_1522960790.jpg',
    stripe_id: 'acct_1CxAnNATifAI3fgp'
  },
  {
    first_name: 'Meagan',
    last_name: 'Ivey',
    address: lawyer_cities.sample,
    email: 'meagan@justitia.today',
    password: 'secret',
    description: 'After graduating from the University of Alabama School of Law, Meagan was admitted to the Alabama State Bar in September of 2010 and moved to Mobile, Alabama where she accepted an associate attorney position at Cunningham Bounds, LLC to work on the BP oil spill litigation. In 2013, Meagan began working at Legal Services Alabama, where she helped low income clients in all areas of civil practice. Meagan joined Gardberg & Kemmerly, PC as an Associate Attorney in the Social Security Disability department in January of 2016.',
    years_of_experience: rand(5..45),
    hourly_rate: lawyer_rates.sample,
    is_first_consultation_free: Faker::Boolean.boolean,
    is_online: Faker::Boolean.boolean,
    photo: 'https://images.avvo.com/avvo/ugc/images/head_shot/standard/lawyer_meagan_ivey_4308588_1522958638.jpg',
    stripe_id: 'acct_1CxAnNATifAI3fgp'
  },
  {
    first_name: 'Austin',
    last_name: 'Prestwood',
    address: lawyer_cities.sample,
    email: 'austin@justitia.today',
    password: 'secret',
    description: 'I began practicing law in 1987 with a large law firm located in Mobile, Alabama and in 1989 I started a small general practice law firm with the Hon. Elizabeth H. Shaw. As a general practitioner I gained valuable litigation experience in a wide variety of cases. My law practice continued to expand in the area of personal injury litigation and in 1994 I became a member of the civil litigation firm of Sigler, Moore, Clements & Wolfe. That firm eventually beame Boteler, Finley & Wolfe and we moved to our current location, 3290 Dauphin Street, #505, Mobile, AL 36606, in 2016.',
    years_of_experience: rand(5..45),
    hourly_rate: lawyer_rates.sample,
    is_first_consultation_free: Faker::Boolean.boolean,
    is_online: Faker::Boolean.boolean,
    photo: 'https://images.avvo.com/avvo/ugc/images/head_shot/standard/lawyer_austin_prestwood_3331866_1522957527.jpg',
    stripe_id: 'acct_1CxAnNATifAI3fgp'
  },
  {
    first_name: 'Laura',
    last_name: 'Holland',
    address: lawyer_cities.sample,
    email: 'laura@justitia.today',
    password: 'secret',
    description: 'Laura grew up in Florence, Alabama, and graduated from Bradshaw High School. Laura then attended Auburn University and earned a Bachelor of Arts degree. Upon graduation from Auburn University in 2007, Laura attended law school at the University of Alabama School of Law, where she was awarded the Howard R. Andres, Jr. Memorial Scholarship and the William H. Mitchell, Sr. Scholarship. She also worked in the Domestic Violence Clinic, a student run legal service for impoverished victims of Domestic Violence.',
    years_of_experience: rand(5..45),
    hourly_rate: lawyer_rates.sample,
    is_first_consultation_free: Faker::Boolean.boolean,
    is_online: Faker::Boolean.boolean,
    photo: 'https://images.avvo.com/avvo/ugc/images/head_shot/standard/lawyer_laura_holland_4699104_1522964090.jpg',
    stripe_id: 'acct_1CxAnNATifAI3fgp'

  },
  {
    first_name: 'Karlos',
    last_name: 'Finley',
    address: lawyer_cities.sample,
    email: 'karlos@justitia.today',
    password: 'secret',
    description: 'I graduated from public high school in Montgomery, Alabama. G.W. Carver High School class of ’77. My father was a non-commissioned officer in the Air Force and our family lived in numerous locations before landing in Montgomery in the 70′s. I worked a number of jobs while attending undergraduate school at the University of Alabama including, electrical construction work, loading and unloading trailers, retail sales and I was a Resident Manager for Rose Towers, a student apartment complex on the campus of Alabama.',
    years_of_experience: rand(5..45),
    hourly_rate: lawyer_rates.sample,
    is_first_consultation_free: Faker::Boolean.boolean,
    is_online: Faker::Boolean.boolean,
    photo: 'https://images.avvo.com/avvo/ugc/images/head_shot/standard/lawyer_karlos_finley_2793194_1522964090.jpg',
    stripe_id: 'acct_1CxAnNATifAI3fgp'
  },
  {
    first_name: 'Mark',
    last_name: 'Wolfe',
    address: lawyer_cities.sample,
    email: 'mark@justitia.today',
    password: 'secret',
    description: 'I believe helping people and being a benefit to those around me and those people I represent is the best way for me to give substance to that quote. I am married to the former Kelly Langan of Mobile and we have three great children, Lesley, Mitchell and Alli. We are members of Daphne United Methodist Church. I am on the Board of Directors (past President) for Prodisee Pantry which is our areas largest food pantry for families in need. In 2015 we provided over 6 tons of food to 15,000 families in need!',
    years_of_experience: rand(5..45),
    hourly_rate: lawyer_rates.sample,
    is_first_consultation_free: Faker::Boolean.boolean,
    is_online: Faker::Boolean.boolean,
    photo: 'https://images.avvo.com/avvo/ugc/images/head_shot/standard/lawyer_mark_wolfe_1955416_1522963558.jpg',
    stripe_id: 'acct_1CxAnNATifAI3fgp'
  }
]

lawyers.each do |l|
  user = User.create(
    first_name: l[:first_name],
    last_name: l[:last_name],
    address: l[:address],
    email: l[:email],
    password: l[:password]
  )
  lawyer = Lawyer.create(
    user: user,
    description: l[:description],
    years_of_experience: l[:years_of_experience],
    hourly_rate: l[:hourly_rate],
    is_first_consultation_free: l[:is_first_consultation_free],
    is_online: l[:is_online],
    remote_photo_url: l[:photo],
    stripe_id: l[:stripe_id]
  )
  rand(1..5).times do
    lawyer.specialties.create!(
      lawyer: lawyer,
      category: seed_categories.sample
    )
  end
end

puts 'Creating 4 users for our use...'

jascha = User.create(
  first_name: 'Jascha',
  last_name: 'Drel',
  address: 'Amsterdam',
  email: 'jaschadrel@gmail.com',
  password: 'secret',
  admin: true
)
Client.create(
  user: jascha
)

daniel = User.create(
  first_name: 'Daniel',
  last_name: 'Mera de Agustin',
  address: 'Allicante',
  email: 'daniel.meradeagustin@gmail.com',
  password: 'secret',
  admin: true
)
Client.create(
  user: daniel
)

lamina = User.create(
  first_name: 'Lamina',
  last_name: 'Vedder',
  address: 'Mainz',
  email: 'lamina-vedder@msn.com',
  password: 'secret',
  admin: true
)
Client.create(
  user: lamina
)

vianney = User.create(
  first_name: 'Vianney',
  last_name: 'de Boisredon',
  address: 'Nantes',
  email: 'v2boisredon@hotmail.fr',
  password: 'secret',
  admin: true
)
Client.create(
  user: vianney
)

puts 'Finished!'
