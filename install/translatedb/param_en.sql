insert into sturwild.target_species (target_species_name,target_species_exchange,target_species_order)
 values 
('Shads','Alosa sp',1),
('Eel','Anguilla anguilla',1),
('Meager','Argyrosomus regius',1),
('Brown crab','Cancer pagurus',1),
('Mullets','Chelon spp, Liza spp',1),
('Conger','Conger conger',1),
('Brown Shrimp','Crangon crangon',1),
('Wedge sole','Dicologlossa cuneata',1),
('Lobster','Homarus gammarus',1),
('Squid','Loligo spp',1),
('Angler','Lophius piscatorius',1),
('Spider crab','Maja squinado',1),
('Whiting','Merlangus merlangius',1),
('Hake','Merluccius merluccius',1),
('Sea bass','Morone labrax + Dicentrarchus punctatus',1),
('Red mullet','Mullus spp',1),
('Sharks','Mustelus sp + Scyliorhinus sp',1),
('Langoustine','Nephrops norvegicaus',1),
('Spiny lobster','Palinurus elephas',1),
('Marine lamprey','Petromyzon marinus',1),
('Flounder','Platichthys flesus',1),
('Plaice','Pleuronectes platessa',1),
('Pollock','Pollachius spp',1),
('Skates','Raja sp.',1),
('Mackerel','Scomber scombrus',1),
('Turbot','Scophthalmus maximus',1),
('Cuttlefish','Sepia officinalis',1),
('Sole','Solea solea',1),
('Sea bream','Sparus sp + Spondyliosoma sp',1),
('Bib','Trisopterus luscus',1);
insert into sturwild.gear_type (gear_type_name,gear_type_exchange,gear_type_order)
 values 
('Bottom otter trawl','Bottom otter trawl',1),
('Beam trawl','Beam trawl',1),
('Electric trawl','Electric trawl',1),
('Pelagic trawl','Pelagic trawl',1),
('Set gillnet','Set gillnet',1),
('Drift gillnet','Drift gillnet',1),
('Set trammel net','Set trammel net',1),
('Drift trammel net','Drift trammel net',1),
('Hooks and lines','Hooks and lines',1),
('Fyke net','Fyke net',1),
('Lift net','Lift net',1),
('Purse seine','Purse seine',1);
insert into sturwild.tag_presence (tag_presence_name,tag_presence_exchange,tag_presence_order)
 values 
('no','no',1),
('yes','yes',2),
('not provided','not provided',3);
insert into sturwild.handling (handling_name,handling_exchange,handling_order)
 values 
('length','length',1),
('weight','weight',2),
('picture','picture',3),
('video','video',4),
('released','released',5),
('samples','samples',6),
('oxygenated in tank','oxygenated in tank',7),
('observed, not caught','observed, not caught',8),
('assessed size','assessed size',9),
('landed','landed',10),
('tag number noted','tag number noted',11),
('transmitter picked up','transmitter picked up',12),
('fish tank','fish tank',13),
('auction','auction',14),
('sold','sold',15),
('frozen','frozen',16);
insert into sturwild.fate (fate_name,fate_exchange,fate_order)
 values 
('Dead','Dead',9),
('dead and naturalized','dead and naturalized',10),
('Ex situ stock','Ex situ stock',12),
('Frozen','Frozen',11),
('Landed','Landed',6),
('Landed and released alive','Landed and released alive',7),
('Landed dead','Landed dead',8),
('released alive','released alive',1),
('Released dead','Released dead',3),
('Released weak','Released weak',2),
('stranded and left behind','stranded and left behind',4),
('Strandled dead','Strandled dead',5),
('Unknown','Unknown',20);
insert into sturwild.status (status_name,status_exchange,status_order)
 values 
('In data entry','In data entry',1),
('Awaiting further information','Awaiting further information',2),
('Declaration validated','Declaration validated',3),
('Declaration confirmed','Declaration confirmed',4);
insert into sturwild.origin (origin_name,origin_exchange,origin_order)
 values 
('Professional fishing','Professional fishing',1),
('Recreational fishing','Recreational fishing',2),
('Scientific professional fishing','Scientific professional fishing',3),
('Other','Other',4),
('Unknown','Unknown',5);
insert into sturwild.environment (environment_name,environment_exchange,environment_order)
 values 
('Atlantic','Atlantic',1),
('Estuary','Estuary',2),
('Fjord','Fjord',3),
('River','River',4),
('English Channel','English Channel',5),
('North Sea','North Sea',6),
('Estuary plume','Estuary plume',7),
('Body of water','Body of water',9),
('Lagoon','Lagoon',10);
insert into sturwild.environment_detail (environment_detail_name,environment_detail_exchange,environment_detail_order)
 values 
('Adour','Adour',1),
('Brittany','Brittany',1),
('Belgium','Belgium',1),
('Charente','Charente',1),
('Charente Maritime','Charente Maritime',1),
('Denmark','Denmark',1),
('Dordogne','Dordogne',1),
('Spain','Spain',1),
('Garonne','Garonne',1),
('Gironde','Gironde',1),
('Upper Normandy','Upper Normandy',1),
('Lande','Lande',1),
('Loire','Loire',1),
('Meuse','Meuse',1),
('Norway','Norway',1),
('Netherlands','Netherlands',1),
('Netherlands Rhine','Netherlands Rhine',1),
('La Balme lake','La Balme lake',1),
('Pointe Bretagne','Pointe Bretagne',1),
('Seine','Seine',1),
('Sèvre Niortaise','Sèvre Niortaise',1),
('Thames','Thames',1),
('Taw','Taw',1),
('Trent','Trent',1),
('Vendée','Vendée',1),
('Vilaine','Vilaine',1),
('Isle','Isle',1);
insert into sturwild.accuracy (accuracy_name,accuracy_exchange,accuracy_order)
 values 
('GPS point provided by the declarant','GPS point provided by the declarant',1),
('Estimated GPS point < 1km','Estimated GPS point < 1km',2),
('Estimated GPS point 1 - 10 km','Estimated GPS point 1 - 10 km',3),
('Estimated GPS point > 10 km','Estimated GPS point > 10 km',4);
insert into sturwild.event_type (event_type_name,event_type_exchange,event_type_order)
 values 
('Entering the declaration','Entering the declaration',1),
('Request for information','Request for information',2),
('Declaration validation','Declaration validation',3),
('Confirmation of declaration','Confirmation of declaration',4),
('Sending thanks','Sending thanks',5);
insert into sturwild.species (species_name,species_exchange,species_order)
 values 
('Acipenser sturio','Acipenser sturio',1),
('Acipenser baerii','Acipenser baerii',2),
('Acipenser gueldenstaedtii','Acipenser gueldenstaedtii',2),
('Huso huso','Huso huso',2),
('Huso bester','Huso bester',2),
('Acipenser oxyrinchus','Acipenser oxyrinchus',2),
('unidentified','unidentified',9),
('Acipenser sp','Acipenser sp',2),
('Huso huso or bester','Huso huso or bester',2);
insert into sturwild.capture_state (capture_state_name,capture_state_exchange,capture_state_order)
 values 
('Très bon état','Very good condition',1),
('Bon état','Good condition',2),
('Etat moyen','Average condition',3),
('Vivant','Living',4),
('Maigre','Thin',6),
('Faible','Poor',7),
('Blessé','Injured',8),
('Etat critique','Critical condition',9),
('Mort','Dead',10),
('Mort Echoué','Dead Stranded',11),
('Inconnu','Unknown',12);
insert into sturwild.country (country_name,country_exchange,country_order)
 values 
('France','France',1),
('United Kingdom','United Kingdom',2),
('Belgium','Belgium',3),
('Denmark','Denmark',4),
('Spain','Spain',5),
('Norway','Norway',6),
('Netherlands','Netherlands',7),
('Germany','Germany',8),
('Unknown','Unknown',99);
