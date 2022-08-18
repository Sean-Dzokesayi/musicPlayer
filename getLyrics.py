from time import sleep
import lyricsgenius
import json

# genius = lyricsgenius.Genius("FMu2V4mu3q_pxu4rOI2FaR7-OxnCCFLXquYomy_BWjRC9lp8OyakFZu-EbcqiVa2")
# f = open('./MusicPlayer/Data/Songs.json')
# data = json.load(f)
# f.close()

# lyrics = {}
# counter = 0

# get all songs from the songs json file and update it with lyrics



# for i in data:
#     if(counter % 100 == 0):
#         sleep(1)
#     print("----------------------------------------")
#     print(str(counter) + ": " + i["title"])     
#     try:
#         song = genius.search_song(i["title"], i["artist"])
#         lyrics[counter] = song.lyrics
#     except:
#         print("An eror occured")

    
#     counter += 1
#     print("----------------------------------------")
#     print("----------------------------------------\n\n")
    


songData = []
lyrics = {}
counter = 0

with open("./MusicPlayer/Data/Lyrics.json", "r") as outfile:
    lyrics = json.load(outfile)

with open("./MusicPlayer/Data/Songs.json", "r") as outfile:
    songData = json.load(outfile)

    for i in songData:
       try:
             songData[counter]["lyrics"] = lyrics[str(counter)]
       except:
            print("")
       counter += 1


f = open("./MusicPlayer/Data/Songs.json", "w")
f.write(json.dumps(songData))
f.close()




