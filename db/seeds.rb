# base data import
# Yifan Zhu
events = {
  '2022-02-22' => ["Donetsk People's Republic","Luhansk People's Republic"],
  '2022-02-24' => [
    "Attack on Snake Island",
    "Siege of Mariupol",
    "Battle of Antonov Airport",
    "Siege of Chernihiv",
    "Battle of Okhtyrka",
    "Chuhuiv air base attack",
    "Battle of Kharkiv",
    "Battle of Konotop",
    "Battle of Sumy",
    "Battle of Chernobyl",
    "Battle of Kherson",
    "Kyiv offensive",
    "Southern Ukraine offensive",
    "Northeastern Ukraine offensive",
    "Eastern Ukraine offensive",
    "On conducting a special military operation"
  ],
  '2022-02-25' => [
    "Millerovo air base attack",
    "Battle of Ivankiv",
    "Battle of Kyiv",
    "Battle of Melitopol", 
    "Battle of Starobilsk",
    "Battle of Volnovakha"
  ],
  '2022-02-26' => [
    "Battle of Mykolaiv",
    "Battle of Vasylkiv"
  ],
  '2022-02-27' => ["2022 Zhytomyr attacks", "Battle of Berdiansk", "Battle of Zaporizhzhia", "Battle of Irpin", "Battle of Bucha", "Battle of Tokmak"],
  '2022-02-28' => ["Battle of Enerhodar", "February 2022 Kharkiv cluster bombing"],
  '2022-03-01' => ["Freedom Square", "Armed Forces of Belarus"],
  '2022-03-02' => ["Horlivka offensive", "Russian occupation of Kherson", "Battle of Sievierodonetsk", "Battle of Voznesensk"],
  '2022-03-03' => ["Estonian cargo ship", "Balakliia"],
  '2022-03-04' => ["Zaporizhzhia Nuclear Power Plant"],
  '2022-03-05' => ["Bucha and Hostomel"],
  '2022-03-06' => ["Irpin refugee column shelling"],
  '2022-03-07' => ["Yuri Prilipko", "Kherson International Airport"],
  '2022-03-08' => ["Sumy"],
  '2022-03-09' => ["Battle of Brovary"],
  '2022-03-10' => ["Tri-lateral meeting"],
  '2022-03-11' => ["Ivan Fedorov"],
  '2022-03-12' => ["Phosphorus bombs"],
  '2022-03-13' => ["avoriv military base attack", "Mykolaiv cluster bombing"],
  '2022-03-14' => ["Tochka-U"],
  '2022-03-15' => ["Oleg Mityaev"],
  '2022-03-16' => ["Chernihiv breadline massacre", "Mariupol theatre airstrike"],
  '2022-03-17' => ["Rubizhne", "Izium"],
  '2022-03-18' => ["2022 Deliatyn attack", "Battle of Mykolaiv" , "Ukrainian military base missile attack"],
  '2022-03-19' => ["Bombed an art school"],
  '2022-03-20' => ["Kyiv shopping centre bombing"],
  '2022-03-21' => ["Sumykhimprom chemical plant ammonia leak"],
  '2022-03-22' => ["Chernobyl exclusion zone"],
  '2022-03-23' => ["Applying a lot more energy"],
  '2022-03-24' => ["Berdiansk port attack"],
  '2022-03-25' => ["Ukrainian Air Force command center airstrike"],
  '2022-03-26' => ["Zaporizhzhia Oblast", "State Nuclear Regulatory Inspectorate", "Warsaw"],
  '2022-03-27' => ["Vilkhivka"],
  '2022-03-28' => ["Vadym Boychenko"],
  '2022-03-29' => ["Attack on Belgorod", "Mykolaiv government building airstrike"],
  '2022-03-30' => ["Donbas region"],
  '2022-03-31' => ["Hostomel Airport"],
  '2022-04-01' => ["Belgorod Oblast", "Vyacheslav Gladkov"],
  '2022-04-02' => ["Kremenchuk", "Poltava"],
  '2022-04-03' => ["Bucha massacre"],
  '2022-04-04' => ["United Nations Human Rights Council"],
  '2022-04-05' => ["Dmitry Peskov"],
  '2022-04-06' => ["Pope Francis"],
  '2022-04-07' => ["Dmytro Kuleba"],
  '2022-04-08' => ["Kramatorsk railway station attack"],
  '2022-04-09' => ["Russian military intervention in Syria"],
  '2022-04-10' => ["Valentyn Reznichenko"],
  '2022-04-11' => ["Russian Defence Minister", "Karl Nehammer"],
  '2022-04-12' => ["Azov battalion"],
  '2022-04-13' => ["Sinking of the Moskva"],
  '2022-04-14' => ["Russian cruiser Moskva"],
  '2022-04-15' => ["Ilyich Steel and Iron Plant"],
  '2022-04-16' => ["Vladimir Petrovich Frolov"],
  '2022-04-17' => ["Air-launched missiles"],
  '2022-04-18' => ["Battle of Donbas"],
  '2022-04-19' => ["Another phase"],
  '2022-04-20' => ["Mariupol"],
  '2022-04-21' => ["Azovstal Iron and Steel Works", "Russian Minister of Defence Sergei Shoigu"],
  '2022-04-22' => ["MANPADS"],
  '2022-04-23' => ["Defense Ministry’s Intelligence Directorate of Ukraine"],
  '2022-04-24' => ["Dnipropetrovsk"],
  '2022-04-25' => ["Transnistria attacks"],
  '2022-04-26' => ["Sergey Lavrov"],
  '2022-04-27' => ["Ukrainian drone"],
  '2022-04-28' => ["Russian occupation of Kherson Oblast"],
  '2022-04-29' => ["Roman Starovoyt"],
  '2022-04-30' => ["Odesa Airport"],
  '2022-05-01' => ["Su-24M"],
  '2022-05-02' => ["Dniester estuary"],
  '2022-05-03' => ["Dmytro Zhyvytskyi"],
  '2022-05-04' => ["Azovstal Iron and Steel Works"],
  '2022-05-05' => ["Kanatovo airfield"],
}
events.each do |key, v|
  date = Time.parse(key)
  v.each do |t|
    Category.create(date: date, event: t)
  end
end


User.create(name: :Tony, email: "123@123.com", password: '123456')
User.create(name: :Anne, email: "321@123.com", password: '123456')