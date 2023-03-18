#encoding: utf-8
import os.path
import MySQLdb

import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
import csv
import uuid
import os

from tornado.options import define, options
define("port", default=8000, help="run on the given port", type=int)

class sqlCannedHandler(tornado.web.RequestHandler):
	def post(self):
		self.set_header('Content-Type', 'text/csv')
		self.set_header('Content-Disposition', 'attachment; filename="file.csv"')

		s = self.request.files
		print(s)
		cmd = s.get('filxx',[])[0].get('body')
		fileName = checkMySql(cmd)

		cnt = 0
		with open(fileName,'rb') as fp:
			while True:
				cnt+=1
				data = fp.read(4096)
				#print(data)
				if not data:
					break
				self.write(data)
		self.finish()
		print("write done" + str(cnt))
		os.remove(fileName)

class sqlPipeLineHandler(tornado.web.RequestHandler):
	def get(self):
		self.set_header('Content-Type', 'text/csv')
		self.set_header('Content-Disposition', 'attachment; filename="file.csv"')

		cmd = self.get_argument('arg')
		fileName = checkMySql(cmd)
		cnt = 0
		with open(fileName,'rb') as fp:
			while True:
				cnt+=1
				data = fp.read(4096)
				#print(data)
				if not data:
					break
				self.write(data)
		self.finish()
		print("write done" + str(cnt))
		os.remove(fileName)

class IndexHandler(tornado.web.RequestHandler):
	def get(self):
		self.render('index.html')

def checkMySql(mySqlText):
	cs = db.cursor()
	cs.execute(mySqlText)
	rows = [tuple([i[0] for i in cs.description],)]
	rows += cs.fetchall()
	fileName = "tmpQuery"+str(uuid.uuid4())+".csv"
	fp = open(fileName, 'w')
	myFile = csv.writer(fp)
	lstLen = len(rows)
	lstLen = min(1000,lstLen)
	rows = rows[:lstLen]

	myFile.writerows(rows)
	fp.close()
	return fileName

if __name__ == '__main__':
	db = MySQLdb.connect("localhost", "COSC580_A2", "", "TripleThreat", charset='utf8')
	tornado.options.parse_command_line()
	app = tornado.web.Application(

		handlers=[
			(r'/', IndexHandler), 
			(r'/sqlPipeLine',sqlPipeLineHandler),
			(r'/sqlCanned',sqlCannedHandler),
			],
		static_path='dist'
	)
	http_server = tornado.httpserver.HTTPServer(app)
	http_server.listen(options.port)
	tornado.ioloop.IOLoop.instance().start()
