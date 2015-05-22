players = [{"id" => 1, "first_name"=>"Jane","last_name"=>"Sullivan","email"=>"jsullivan0@macromedia.com","country"=>"Colombia","ip_address"=>"65.3.175.51","first_win"=>"22/03/2008","first_defeat"=>"31/05/2010","is_virgin"=>true},
{"id"=>2,"first_name"=>"Jessica","last_name"=>"Young","email"=>"jyoung1@rambler.ru","country"=>"Russia","ip_address"=>"207.235.206.31","first_defeat"=>"03/07/2009"},
{"id"=>3,"last_name"=>"Day","email"=>"sday2@unesco.org","country"=>"Tanzania","ip_address"=>"68.232.175.35","first_win"=>"23/03/2005","first_defeat"=>"26/03/2014","is_virgin"=>true},
{"id"=>4,"first_name"=>"Anne","last_name"=>"Foster","email"=>"afoster3@virginia.edu","country"=>"China","ip_address"=>"2.52.95.238","first_win"=>"03/07/2006","is_virgin"=>true},
{"id"=>5,"last_name"=>"Campbell","email"=>"ecampbell4@ebay.co.uk","country"=>"Switzerland","ip_address"=>"65.69.156.218","first_win"=>"25/01/2008","first_defeat"=>"21/10/2010","is_virgin"=>false},
{"id"=>6,"first_name"=>"Bobby","last_name"=>"Bowman","email"=>"bbowman5@blog.com","country"=>"China","ip_address"=>"229.55.170.164","first_win"=>"19/11/2003","first_defeat"=>"22/09/2007","is_virgin"=>false},
{"id"=>7,"first_name"=>"Benjamin","last_name"=>"Armstrong","email"=>"barmstrong6@sfgate.com","country"=>"China","first_win"=>"31/05/2002","first_defeat"=>"08/10/2006","is_virgin"=>true},
{"id"=>8,"first_name"=>"Rose","last_name"=>"Ryan","email"=>"rryan7@ftc.gov","country"=>"Peru","ip_address"=>"86.13.46.13","first_win"=>"27/01/2014","first_defeat"=>"24/06/2005","is_virgin"=>true},
{"id"=>9,"first_name"=>"Michelle","last_name"=>"Tucker","email"=>"mtucker8@google.cn","ip_address"=>"126.157.85.231","first_defeat"=>"20/11/2007","is_virgin"=>false},
{"id"=>10,"first_name"=>"Rachel","last_name"=>"Lopez","email"=>"rlopez9@apple.com","country"=>"Pakistan","ip_address"=>"151.11.208.144","first_win"=>"23/05/2009","first_defeat"=>"29/01/2015","is_virgin"=>false}]

for p in players
	player = Player.new(first_name: p["first_name"], last_name: p["last_name"], email: p["email"], country: p["country"], ip_address: p["ip_address"], first_win: p["first_win"], first_defeat: p["first_defeat"], is_virgin: p["is_virgin"])
	player.save!
end