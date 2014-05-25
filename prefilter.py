#!/usr/bin/python

# Questo filtro prende i dati prodotti dal downloader dell'ego network su Android e precondiziona i dati come segue:
# 1) elimina i post in/out verso l'utente proprietario dell'ego-network
# 2) somma i post ricevuti/inviati da un utente all'altro in un unico campo
# 3) calcola il massimo tempo intercorso dal primo post di un utente verso l'altro
# 4) produce un peso 1 per gli utenti che non hanno post (o che hanno scambiato il primo post fino a 30gg indietro)
# 5) altrimenti produce un peso normalizzato (1 + totposts / maxduration)

import sys

line_no = 0
user = {}
exclude_uid = 10202887345656400L

while True:
	line = sys.stdin.readline()
	if not line:
		break
	line_no += 1
	if line_no == 1:
		continue
	fields = line.split("\t")
	uid1 = long(fields[0])
	uid2 = long(fields[1])
	num_posts = int(fields[2])
	duration = int(fields[3])
	if uid1 == exclude_uid or uid2 == exclude_uid:
		continue
	if uid1 > uid2:
		tmp = uid2
		uid2 = uid1
		uid1 = tmp
	if not user.has_key(uid1):
		user[uid1] = {}
	if not user[uid1].has_key(uid2):
		user[uid1][uid2] = (0, 0)
	
	user[uid1][uid2] = (user[uid1][uid2][0]+num_posts, max(user[uid1][uid2][1], duration))

print "uid1\tuid2\tweight"
for uid1 in user.keys():
	for uid2 in user[uid1].keys():
		num_posts, duration = user[uid1][uid2]
		weight = 1
		if duration >= 60*60*24*30:
			weight = 1 + num_posts * 1.0 / duration
		print "%s\t%s\t%s"  % (uid1, uid2, weight)

