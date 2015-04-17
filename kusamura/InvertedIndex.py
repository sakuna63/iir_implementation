# -*- coding: utf-8 -*-

__author__ = 'Kusamura'

class InvertedIndex:

	def __init__(self, dataList):
		self.index = {} #転置インデックス: dictionary(keyword, List<ID>)
		for data in dataList:
			self.indexingOneData(data)

	def indexingOneData(self, data): #引数で与えられたDataに対してindexing
		for word in data.getWordSet():
			if(self.index.has_key(word)):
				self.index[word] = self.index[word] + [data.fileName] #keyが存在していればvalueに追加
			else:
				self.index[word] = [data.fileName] #keyが存在していなければ生成

	def getIndex(self):
		return self.index

	def getKeys(self):
		return self.index.keys()

	def countKeys(self):
		return len(self.index.keys())

if __name__ == "__main__":
#	print InvertedIndex().getKeys()
#	for k, v in InvertedIndex().getIndex().items():
#		print (k, v)
	print InvertedIndex().countKeys()