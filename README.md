JavaScript WorkShop at 07 - 09.10.2014
Content
http://www.it-schulungen.com/seminare/softwareentwicklung/javascript/javascript-fortgeschrittene-programmierung.html

Projekt Thema:
=============

Client: AngularJS
- Suche in profiles

Server: Node.js
- WS Profile CRUD
- WS Profile Search
- Mongo


data structure
[{
	firstname: 'String',
	lastname: 'String',
	email: 'String'
}]


Server
	- start server: $ nodemon server/app.coffee

API

	# p - search by property
	# q - search string
	# m - max result entries
	# s - sort by property

	example: http://localhost:3030/api/users?q=Adam&s=surname
