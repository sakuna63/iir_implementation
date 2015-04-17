# -*- coding:utf-8 -*-

__author__ = 'Kusamura'

from InvertedIndex import InvertedIndex

class Search:
	def __init__(self, index):
		self.index = index.getIndex() #転置インデックスの呼び出し

	def do(self, keyword): #検索実行
		print keyword + ' ->',
		if self.index.has_key(keyword): #単語が存在すれば章のリストを返す
			print self.index[keyword]
		else: #単語が存在しなければ空リストを返す
			print []
