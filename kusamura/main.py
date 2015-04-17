# -*- coding:utf-8 -*-

__author__ = 'Kusamura'

from Data import Data
from InvertedIndex import InvertedIndex
from Search import Search
from Frequency import Frequency

if __name__ == '__main__':
	fileList = [] #章の一覧
	for line in open('chaps/chap_title.tsv', 'r'): #chaps_titleから章の一覧を生成
		fileList.append(line[:-1].split('\t')[0][2:])
	dataList = [] #Dataクラス(ファイルから読み込んだデータ)のリスト
	for fileName in fileList:
		dataList.append(Data(fileName))

	index = InvertedIndex(dataList) #転置インデックスを作成

#	module = Search(index) #検索モジュール
#	keys = ['retrieval', 'half-a-trillion', 'thus', 'layer', 'test', 'hoge', 'hogehoge']
#	for key in keys:
#		module.do(key)

#	print index.countKeys() #辞書内の語数をカウント

#	print Frequency().docFrequency(index) #辞書頻度

	print Frequency().termFrequency(dataList) #単語頻度