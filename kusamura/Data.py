# -*- coding:utf-8 -*-

__author__ = 'Kusamura'

import re

class Data:
	def __init__(self, fileName):
		self.fileName = fileName

		file = open('chaps/' + fileName + '.html', 'r')
		data = file.read() #data: ファイルの内容を１つの文字列として格納
		file.close()

		data = data[data.find('<BODY >'):]
		data = data[:data.rfind('</BODY>')] #<BODY > </BODY>内のみを抽出

		data = re.sub("<!--" + "(\s|.)*?" + "-->", " ", data) #コメントアウトの削除
		data = re.sub("<" + "(\s|.)*?" + ">", " ", data) #タグの削除
		data = data.replace("&nbsp", " ") # &nbspを半角スペースに変換

		self.wordList = []
		escapeCharSet = "().,$:;-'`\n&?/*!\\={}"
		for word in data.split(): #単語で分割
			word = word.strip(escapeCharSet) #不要な文字を削除
			if not word == "":
				self.wordList.append(word) #単語一覧を作成

	def getWordList(self):
		return self.wordList

	def getWordSet(self): #wordListを集合に変換
		wordSet = set([])
		for word in self.wordList:
			wordSet.add(word)
		return wordSet