# -*- coding:utf-8 -*-

__author__ = 'Kusamura'

class Frequency:
	def docFrequency(self, index):
		freq = {} #文書頻度を辞書型で格納{key, freq}
		for k, v in index.getIndex().items():
			freq[k] = len(v)
		return freq

	def termFrequency(self, dataList):
		freqList = {} #{章番号,{key, frequency}}
		for data in dataList:
			freqList[data.fileName] = self.oneFileTermFrequency(data) #freqListに１つのファイルに対しての結果を追加
		return freqList

	def oneFileTermFrequency(self, data): #あるファイルに対しての単語頻度
		words = data.getWordList() #dataから、単語の一覧を取得
		freq = {} #{key, freqency}
		for word in words: #wordの頻度をインクリメント
			if freq.has_key(word):
				freq[word] = freq[word] + 1
			else:
				freq[word] = 1
		return freq