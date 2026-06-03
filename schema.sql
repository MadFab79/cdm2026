-- ============================================
-- CDM 2026 PRONO - Schéma Supabase
-- À coller dans SQL Editor > New Query
-- ============================================

-- Joueurs
create table players (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  created_at timestamptz default now()
);

-- Matchs
create table matches (
  id integer primary key,
  phase text not null, -- 'group','r32','r16','sf','3rd','final'
  group_name text,     -- 'A'..'L' pour phase de groupes
  label text,          -- 'Huitième 1', etc.
  home text not null,
  away text not null,
  match_date text,
  score_home integer,
  score_away integer
);

-- Pronos
create table pronos (
  id uuid primary key default gen_random_uuid(),
  player_id uuid references players(id) on delete cascade,
  match_id integer references matches(id) on delete cascade,
  score_home integer not null,
  score_away integer not null,
  created_at timestamptz default now(),
  unique(player_id, match_id)
);

-- ============================================
-- Activer la lecture publique (Row Level Security)
-- ============================================
alter table players enable row level security;
alter table matches enable row level security;
alter table pronos enable row level security;

-- Tout le monde peut lire
create policy "public read players" on players for select using (true);
create policy "public read matches" on matches for select using (true);
create policy "public read pronos" on pronos for select using (true);

-- Tout le monde peut écrire (app entre collègues = pas besoin d'auth)
create policy "public insert players" on players for insert with check (true);
create policy "public update players" on players for update using (true);
create policy "public delete players" on players for delete using (true);

create policy "public insert matches" on matches for insert with check (true);
create policy "public update matches" on matches for update using (true);

create policy "public insert pronos" on pronos for insert with check (true);
create policy "public update pronos" on pronos for update using (true);
create policy "public delete pronos" on pronos for delete using (true);

-- ============================================
-- Données initiales : les 104 matchs
-- ============================================

insert into matches (id, phase, group_name, home, away, match_date) values
-- GROUPE A
(1,'group','A','Maroc','Portugal','11 jun'),
(2,'group','A','Mexique','Pologne','11 jun'),
(3,'group','A','Maroc','Mexique','15 jun'),
(4,'group','A','Portugal','Pologne','15 jun'),
(5,'group','A','Portugal','Mexique','19 jun'),
(6,'group','A','Pologne','Maroc','19 jun'),
-- GROUPE B
(7,'group','B','USA','Panama','12 jun'),
(8,'group','B','Yémen','Nouvelle-Zélande','12 jun'),
(9,'group','B','USA','Yémen','16 jun'),
(10,'group','B','Panama','Nouvelle-Zélande','16 jun'),
(11,'group','B','Panama','Yémen','20 jun'),
(12,'group','B','Nouvelle-Zélande','USA','20 jun'),
-- GROUPE C
(13,'group','C','Argentine','Pérou','12 jun'),
(14,'group','C','Canada','Slovaquie','12 jun'),
(15,'group','C','Argentine','Canada','16 jun'),
(16,'group','C','Pérou','Slovaquie','16 jun'),
(17,'group','C','Pérou','Canada','20 jun'),
(18,'group','C','Slovaquie','Argentine','20 jun'),
-- GROUPE D
(19,'group','D','Brésil','Paraguay','13 jun'),
(20,'group','D','Côte d''Ivoire','Autriche','13 jun'),
(21,'group','D','Brésil','Côte d''Ivoire','17 jun'),
(22,'group','D','Paraguay','Autriche','17 jun'),
(23,'group','D','Paraguay','Côte d''Ivoire','21 jun'),
(24,'group','D','Autriche','Brésil','21 jun'),
-- GROUPE E
(25,'group','E','Espagne','Nigéria','13 jun'),
(26,'group','E','Thaïlande','Oman','13 jun'),
(27,'group','E','Espagne','Thaïlande','17 jun'),
(28,'group','E','Nigéria','Oman','17 jun'),
(29,'group','E','Nigéria','Thaïlande','21 jun'),
(30,'group','E','Oman','Espagne','21 jun'),
-- GROUPE F
(31,'group','F','Angleterre','Sénégal','14 jun'),
(32,'group','F','Équateur','Kenya','14 jun'),
(33,'group','F','Angleterre','Équateur','18 jun'),
(34,'group','F','Sénégal','Kenya','18 jun'),
(35,'group','F','Sénégal','Équateur','22 jun'),
(36,'group','F','Kenya','Angleterre','22 jun'),
-- GROUPE G
(37,'group','G','France','Algérie','14 jun'),
(38,'group','G','Ghana','Ukraine','14 jun'),
(39,'group','G','France','Ghana','18 jun'),
(40,'group','G','Algérie','Ukraine','18 jun'),
(41,'group','G','Algérie','Ghana','22 jun'),
(42,'group','G','Ukraine','France','22 jun'),
-- GROUPE H
(43,'group','H','Allemagne','Corée du Sud','15 jun'),
(44,'group','H','Honduras','Mexique B','15 jun'),
(45,'group','H','Allemagne','Honduras','19 jun'),
(46,'group','H','Corée du Sud','Mexique B','19 jun'),
(47,'group','H','Corée du Sud','Honduras','23 jun'),
(48,'group','H','Mexique B','Allemagne','23 jun'),
-- GROUPE I
(49,'group','I','Pays-Bas','Turquie','15 jun'),
(50,'group','I','Serbie','Guinée','15 jun'),
(51,'group','I','Pays-Bas','Serbie','19 jun'),
(52,'group','I','Turquie','Guinée','19 jun'),
(53,'group','I','Turquie','Serbie','23 jun'),
(54,'group','I','Guinée','Pays-Bas','23 jun'),
-- GROUPE J
(55,'group','J','Portugal B','Belgique','16 jun'),
(56,'group','J','Azerbaïdjan','Éthiopie','16 jun'),
(57,'group','J','Portugal B','Azerbaïdjan','20 jun'),
(58,'group','J','Belgique','Éthiopie','20 jun'),
(59,'group','J','Belgique','Azerbaïdjan','24 jun'),
(60,'group','J','Éthiopie','Portugal B','24 jun'),
-- GROUPE K
(61,'group','K','Colombie','Cameroun','16 jun'),
(62,'group','K','Venezuela','Slovénie','16 jun'),
(63,'group','K','Colombie','Venezuela','20 jun'),
(64,'group','K','Cameroun','Slovénie','20 jun'),
(65,'group','K','Cameroun','Venezuela','24 jun'),
(66,'group','K','Slovénie','Colombie','24 jun'),
-- GROUPE L
(67,'group','L','Japon','Croatie','17 jun'),
(68,'group','L','Malawi','Biélorussie','17 jun'),
(69,'group','L','Japon','Malawi','21 jun'),
(70,'group','L','Croatie','Biélorussie','21 jun'),
(71,'group','L','Croatie','Malawi','25 jun'),
(72,'group','L','Biélorussie','Japon','25 jun'),
-- HUITIÈMES
(1000,'r32',null,'TBD','TBD','29 jun'),
(1001,'r32',null,'TBD','TBD','29 jun'),
(1002,'r32',null,'TBD','TBD','30 jun'),
(1003,'r32',null,'TBD','TBD','30 jun'),
(1004,'r32',null,'TBD','TBD','01 jul'),
(1005,'r32',null,'TBD','TBD','01 jul'),
(1006,'r32',null,'TBD','TBD','02 jul'),
(1007,'r32',null,'TBD','TBD','02 jul'),
-- QUARTS
(1008,'r16',null,'TBD','TBD','04 jul'),
(1009,'r16',null,'TBD','TBD','04 jul'),
(1010,'r16',null,'TBD','TBD','05 jul'),
(1011,'r16',null,'TBD','TBD','05 jul'),
-- DEMIES
(1012,'sf',null,'TBD','TBD','09 jul'),
(1013,'sf',null,'TBD','TBD','10 jul'),
-- 3ème place
(1014,'3rd',null,'TBD','TBD','18 jul'),
-- FINALE
(1015,'final',null,'TBD','TBD','19 jul');

-- Labels pour les matchs à élimination directe
update matches set label = 'Huitième ' || (id - 999) where phase = 'r32';
update matches set label = 'Quart ' || (id - 1007) where phase = 'r16';
update matches set label = 'Demi-finale ' || (id - 1011) where phase = 'sf';
update matches set label = '3ème place' where phase = '3rd';
update matches set label = 'FINALE' where phase = 'final';
