# Author - Pallav Mahamana
# this script scrapes gita from asitis.com and spits out a gitasitis.json file containing all shlokas
# with translations and purports

from colorama import Fore, Style # For colors in console stdout
import requests, json
from bs4 import BeautifulSoup # For parsing and scraping



gitasitis = []

def scrape_shloka(url):
	page = requests.get(url)
	soup = BeautifulSoup(page.content,'html.parser')
	try:
		shloka = soup.find("span",class_="Italic").text
		print(Fore.YELLOW+shloka) #For Logging Purpose

	except:
		shloka = ""
	try:
		translation = soup.find("div",class_="Translation").text
	except:
		translation = ""
	try:
		purport = soup.find("div",class_="Purport").text
	except:
		purport = ""
	try:
		syn = soup.find("div",class_="Synonyms-SA").text.split(';')
	except:
		syn = ""

	print(Fore.GREEN+translation+'\n') #For Logging Purpose

	gitasitis.append(
		{"TEXT":url.split('/')[-1].rsplit('.html')[0],
		"SHLOKA":shloka,
		"SYN":syn,
		"TRANSLATION":translation,
		"PURPORT":purport
		})


gita = {}
ch = 1
while(ch<19):
	page = requests.get("https://asitis.com/"+str(ch))
	soup = BeautifulSoup(page.content,'html.parser')
	h4 = soup.findAll("h4")
	for ele in h4:
		if ele.find("a",href=True):
			scrape_shloka(ele.find("a")['href'])
	gita[ch] = gitasitis
	gitasitis = []
	ch = ch + 1

# write gitasitis.json

with open('gitasitis.json','w',encoding='utf-8') as fp:
	json.dump([gita],fp,indent=4)

print(Style.RESET_ALL) # reset stdout colors

