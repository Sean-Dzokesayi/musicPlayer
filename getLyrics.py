from time import sleep
import lyricsgenius
import json

genius = lyricsgenius.Genius("FMu2V4mu3q_pxu4rOI2FaR7-OxnCCFLXquYomy_BWjRC9lp8OyakFZu-EbcqiVa2")
f = open('./MusicPlayer/Data/Songs.json')
data = json.load(f)
f.close()

lyrics = {}
counter = 0


for i in data:
    if(counter % 100 == 0):
        sleep(1)
    print("----------------------------------------")
    print(str(counter) + ": " + i["title"])     
    try:
        song = genius.search_song(i["title"], i["artist"])
        
    except:
        print("An eror occured")

    lyrics[counter] = song.lyrics
    counter += 1
    print("----------------------------------------")
    print("----------------------------------------\n\n")
    


with open("./MusicPlayer/Data/Lyrics.json", "w") as outfile:
    json.dump(lyrics, outfile)


