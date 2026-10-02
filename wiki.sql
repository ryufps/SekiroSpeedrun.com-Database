BEGIN TRANSACTION;
CREATE TABLE bookmarks (
        id INTEGER PRIMARY KEY,
        user_id INTEGER NOT NULL REFERENCES users(id),
        page_id INTEGER NOT NULL REFERENCES wiki_pages(id),
        created_at DATETIME,
        CONSTRAINT uq_bookmark_user_page UNIQUE (user_id, page_id)
    );
CREATE TABLE categories (
	id INTEGER NOT NULL, 
	title VARCHAR(100) NOT NULL, 
	image VARCHAR(200), 
	description TEXT, position INTEGER NOT NULL DEFAULT 0, slug VARCHAR(120), 
	PRIMARY KEY (id)
);
INSERT INTO "categories" VALUES(1,'Resources & Tools','https://sekiroshadowsdietwice.wiki.fextralife.com/file/Sekiro-Shadows-Die-Twice/loaded_axe-upgrade-material-sekiro-wiki-guide.png','Downloads and guides for speedrun tools',0,'resources-tools');
INSERT INTO "categories" VALUES(2,'Misc','https://sekiroshadowsdietwice.wiki.fextralife.com/file/Sekiro-Shadows-Die-Twice/healing_gourd-quick-item-sekiro-wiki-guide.png','Miscellaneous directory for unsorted things',4,'misc');
INSERT INTO "categories" VALUES(3,'Strategies','https://assets1.ignimgs.com/2019/04/05/sekiro2-1534875272558-1280w-1554501685565.jpg','Directory of all strats and techniques. Go to "Speedrun Routes" instead to find guides for specific runs',2,'strategies');
INSERT INTO "categories" VALUES(4,'Game Wiki','https://static.wikia.nocookie.net/game-pedia/images/6/69/Sekiro_Box_Art.png/revision/latest?cb=20180612151209&path-prefix=de','Game mechanic info',3,'game-wiki');
INSERT INTO "categories" VALUES(5,'Speedrun Routes','https://static.wikia.nocookie.net/shadowsdietwice/images/3/3e/Antique_Map_Titles.png/revision/latest/scale-to-width-down/650?cb=20190413185202','Routes for various speedrun categories',1,'speedrun-routes');
CREATE TABLE pending_edits (
	id INTEGER NOT NULL, 
	page_id INTEGER NOT NULL, 
	title VARCHAR(150) NOT NULL, 
	content TEXT NOT NULL, 
	category_id INTEGER, 
	editor_id INTEGER, 
	created_at DATETIME, 
	status VARCHAR(20), submitted_at DATETIME, reviewed_at DATETIME, reviewed_by_id INTEGER REFERENCES users(id), review_note TEXT, original_title VARCHAR(150), original_content TEXT, original_category_id INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(page_id) REFERENCES wiki_pages (id), 
	FOREIGN KEY(category_id) REFERENCES categories (id), 
	FOREIGN KEY(editor_id) REFERENCES users (id)
);
INSERT INTO "pending_edits" VALUES(1,3,'Inside Ako (Mikiri) Armored Warrior','## Inside Ako (Mikiri) Armored Warrior

The inside Ako strategy involves using the Ako inside to buff up while simultaneously triggering Armored Warriors AI to start up an attack. This saves time over buffing outside, as normally you need to wait a moment for his AI to properly respond to you being there. Mikiri is used as a key part of the strategy because a Thrust attack can be baited out consistently every time with this approach.

There are 6 possible patterns that Armored Warrior, assuming that the Ako is used in the right spot.

Low Horizontal Swing Opener (Low Swing) [youtube]BLwCjllSccQ[/youtube]

High Horizontal Swing Opener (High Swing) [youtube]x26PGCo3vO0[/youtube]

Shove Opener [youtube]2jzlJzo1k88[/youtube]

Overhead into High Swing Opener [youtube]g31ny_JvpDE[/youtube]

Overhead into Low Swing Opener (no footage sorry :c)


Overhead into Shove Opener [youtube]uaerk17R2yk[/youtube]


### 7-Hit Variation

A faster but riskier variation, where block hits (l1 into r1 on controller, or right click into left click on kbm) are used to squeeze in 7 hits instead of 6 during the Berserk start-up. By pressing block then attack Wolf will do a different attack animation. By doing the following it''s possible to squeeze in 7 as opposed to 6 hits after the mikiri: block, attack, attack, attack, attack, attack, block, attack, attack.

This variation has the downside that it can make Armored Warrior seemingly randomly cancel his Berserk and start doing regular attacks instead, which loses a large amount of time. It is not that rare for it to happen, so generally this 7-jhit variation is not consistent, but may be useful if the timesave is absolutely required.',1,2,'2026-02-25 13:53:25.576815','rejected',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "pending_edits" VALUES(2,10,'LiveSplit','## LiveSplit
LiveSplit is a timer program for speedrunners that is both easy to use and full of features.

You can download the latest version of LiveSplit [here](https://livesplit.org/). The downloaded file will have to be extracted and the folder placed somewhere you will remember.

Right clicking the LiveSplit window and going to settings allows you to edit various settings. it''s highly recommended to enable Global Hotkeys, as this allows you to split, reset, undo split and skip split while in-game. You can also change the keybinds while you''re here.
![image](https://i.imgur.com/RezD2Uy.png)

Note: The numpad buttons won''t work while shift is pressed. This is good to know if you play with keyboard and mouse and use shift to sprint, as you won''t be able to manual split/reset/undo/skip while holding shift. But that should be fine thought, since most players will use autosplitting.

## SoulSplitter
SoulSplitter is a LiveSplit plugin developed by [Wasted](https://sekiro.ryufps.de/wiki/5) that is designed to provide autosplitting and timekeeping across all the FromSoftware games available on PC. It is also the official leaderboard timer for Sekiro speedruns and includes various fixes that the community has agreed upon. Enabling it and using it is required for PC speedrun leaderboard submissions.

SoulSplitter''s included mods and fixes:
* Auto start and stop

* No intro movies mod

* IGT fix by B3LYP

* Cutscene blackscreen removal by Wasted

* Autosplitting by Wasted

* Event Flag logger and tracker by Wasted

* Improved tutorial pop-up removal by Wasted

* SteamID check bypass for save files by Uberhalit

**Note: Do not use other versions of these mods for leaderboard submissions. Only use them as provided automatically through LiveSplit**.

### How to Setup LiveSplit for Speedrunning (SoulSplitter Setup)
Read section above about LiveSplit and LiveSplit installation first.
1. Open LiveSplit, right-click it and select Edit Splits.
2. Find Sekiro in the Game Name Field.
![image](https://i.imgur.com/amQ9HMr.png)
3. Activate the integrated game time component.
![image](https://i.imgur.com/R1d3TTL.png)
4. Right-click LiveSplit and select Compare Against --> Game Time.
![image](https://i.imgur.com/J6yByQy.png)
5. Done!

## In-Game Time (IGT)
Sekiro has a built in timer, usually referred to as IGT (In-Game Time or In-Game Timer). However, the default behavior of it is not ideal. Its biggest problem is that there''s an issue with the way the time is incremented, which makes the timer count at a rate that is both slower than real time is supposed to run and hardware dependent in an unfair way.

The community has solved this on PC with the IGT Fix by B3LYP. The fixed version of IGT is usually referred to as modified In-Game Time, or mIGT for short. It has also been referred to as wIGT, or Wasted IGT, after Wasted took over maintaining and developing the Sekiro plugin, under the SoulSplitter project. Importantly, modified IGT is designed to run 1:1 with real time, assuming no game slowdowns due to lag or loading screens. Each second of actual gameplay equates to 1 second on the timer.

For the leaderboards, PC runs use modified IGT through LiveSplit, while console runs use the default IGT.

## Autosplitting
With SoulSplitter activated in the Edit Splits menu, you can make custom autosplits. The autosplitter gives the user freedom to setup autosplit triggers for almost anything in the game, allowing you to customize them to how you see fit. Most beginners will want to download a pre-configured .lss split file that has everything already set up and running. Below is a section on where to download splits of other players.

### How to Create Autosplits
to be added

### How to Find Event Flags (Event Flag Logger)
to be added

### What Makes a Good Autosplit?
Generally speaking, you should make a split where ever you feel like it. However, there are some considerations you should make to get the most out of LiveSplit. LiveSplit is supposed to enhance your progress as a player. It''s not supposed to be an obstacle you have to wrestle with.

* Consider splitting in the same places as others, so that you can compare with them more easily to better tell where you could save time. Below is a section that explains how to download the splits that other players use.
* Always test newly added autosplits before doing a run.
* Place autosplits at bottlenecks and be careful of autosplit points that can vary. An example is splitting on Gyoubu kill. If Gyoubu is killed close to where you need to go, then the next split will be shorter, and if he is killed far from where you need to go, then the next split will be longer. This is why most people choose to split on opening the gate after killing Gyoubu in glitchless, instead of splitting directly on kill. The door is a bottleneck that you have to go through (unless you''re doing [AP1 Bull](https://sekiro.ryufps.de/wiki/7)).
* Consider the precision of the autosplit you have made. The autosplitter itself is precise and accurate, but some in-game things aren''t. This is an extension of the point above, but applies more to how you choose to implement the split rather than where you place it. You can never have a precise split on Gyoubu kill, but it''s possible to have an imprecise autosplit on a spot that should otherwise be a good point to split at. Such as if you have a position split with a way too large size, or a size so small that you may run by it and miss it entirely. Test the autosplit to make sure it always triggers at the same point/time.

## Downloading Splits
Some premade .lss split files with autosplits can be downloaded [here](https://www.speedrun.com/sekiro/resources).

You can also use the website [therun.gg](https://therun.gg/games/Sekiro%3A%20Shadows%20Die%20Twice) to view and download the splits of other runners.

When you download someone else''s splits, it can be a good idea to go to Edit Splits --> Other and then Clear History and Clear Times. This will reset all the stats and times from the splits.

## Recording LiveSplit in Videos
The most popular program for recording and livestreaming is [Open Broadcaster Software (OBS)](https://obsproject.com/). It allows adding multiple layers to your scene, where you would usually use a Game Capture for Sekiro with a Window Capture for LiveSplit put on top of it.

To make a Game Capture Source in OBS:

1. Press the + in the Sources box and choose Game Capture Source. Shown below:
![image](https://www.speedrun.com/static/blob/rz2x1ke0.png)

Game Capture will only show the game, therefore we need to add a separate Source for LiveSplit itself. For capturing LiveSplit, we use a Window Capture Source.

2. Add the Window Capture in the same way you added the Game Capture in the step above (make sure that LiveSplit is open while doing this).

3. After naming it, the following window will appear. Select LiveSplit as the window.
![image](https://www.speedrun.com/static/blob/qzp2mle3.png)

I recommend setting the **"Window Match Priority"** to **"Match title, otherwise find window of same executable"**. This ensures that the Source will exclusively look for the LiveSplit window to capture.

4. Done!

### Making LiveSplit Transparent
The usual way that people make LiveSplit transparent is through a filter in OBS, which will only make it look transparent in the recording and NOT for you. Alternatively, you can use the Transparent LiveSplit fork, which makes LiveSplit''s own background transparent, instead of filtering it out in the recording.

Follow the tutorial below to make LiveSplit transparent in the recording (not needed if using the Transparent LiveSplit fork).
1. **You want to use a black background on LiveSplit. Do not use a color like green, blue or anything like that**, as this will mess with the other elements. Using the default black/dark grey background works as well.
![image](https://www.speedrun.com/static/blob/rz2x18e0.png)

The background color can be changed in layout settings.
![image](https://www.speedrun.com/static/blob/yzrrgjz4.png)

2. Right click the Window Capture you created for LiveSplit (mine is called Splits) and press Filters.
![image](https://www.speedrun.com/static/blob/5e1kpvn0.png)

3. Add a **Color Key** (not a Chroma Key). Set the type to Custom Colour and choose black. Then finally, adjust the Similarity slider until the background disappears. You will get the best looking result with a solid black LiveSplit background.
![image](https://www.speedrun.com/static/blob/xz0og0zl.png)

4. Done!

## Troubleshooting
If you have issues with the timer not automatically starting or not correctly showing the game time, triple check you are comparing against Game Time. Otherwise try restarting LiveSplit, running LiveSplit as Administrator or restarting your PC. If you need help feel free to ask in the #support channel on the [Sekiro Speedrunning Discord server](https://discord.gg/A7kWEPkKEq).

### LiveSplit Error: "The Auto Splitter could not be activated"
The most common cause of this error is that anti-virus will sometimes falsely flag SoulSplitter as an unwatend program and can quarantine the files without giving you a notification. [Here is the guide on how to create an anti-virus exclusion](https://soulsspeedruns.com/livesplit/#troubleshooting).

### LiveSplit Error: "Incomplete installation. Missing files"
Sometimes, the anti-virus fix isn''t enough. If you get an error about missing files, then you need to manually download the SoulSplitter component files from Github via the following steps:
1. Close LiveSplit.
2. Go to the [SoulSplitter Github downloads page](https://github.com/FrankvdStam/SoulSplitter/releases).
3. Download the .zip file from whatever is the latest release (do not download the ones named "source code").
4. Extract the .zip file.
5. Navigate to your LiveSplit components folder.
6. Drag the extracted files into the LiveSplit/components folder (replace files if asked).
7. Apply the anti-virus fix explained [here](https://soulsspeedruns.com/livesplit/#troubleshooting).
8. Done!

## Extra Tools for LiveSplit
to be added

## Credits
Thanks to XeroGoesFast for authoring the original LiveSplit guide.
Thanks to B3LYP for releasing the initial Sekiro timer plugin for LiveSplit.
Thanks to RefinedHornet for contributions to the old Sekiro timer.
Thanks to CapitaineToinon for contributions to the old Sekiro timer.
Thanks to Wasted for revolutionizing the Sekiro plugin with the SoulSplitter project.',1,2,'2026-03-11 17:06:28.094033','rejected',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "pending_edits" VALUES(3,16,'Mitchriz','## Mitchriz
Mitchriz is a speedrun content creator with a focus on Sekiro, Elden Ring and Lies of P.',2,8,'2026-09-17 14:59:37.537872','rejected',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "pending_edits" VALUES(5,34,'Shura Restricted','## Shura Restricted
Shura Restricted is generally referred to as Any% or Any% Restricted.

## Shura Restricted Guides
Gin42_ has made a full guide for Shura Restricted.
[youtube]wHK3qTTV_pY[/youtube]

## Shura Restricted Route
This guide for Shura Restricted is made by the editors of the wiki.

### Tutorial Section
Talk to Kuro, and after receiving the Healing Gourd, you can press the menu button to cancel out of the dialogue early.

After speaking to Kuro, you use the [Tutorial Grapple Glitch](/wiki/tutorial-grapple-glitch) to exit the Moonview Tower faster.
[youtube]zFL1mjWWVfA[/youtube]

Before leaving the tutorial remember to get the 2x Ash pickup right after running past Leader Shigenori Yamauchi.

### Ashina Outskirts
### Ogre Skip
Ogre Skip takes a lot of time to learn, but is around 35s faster than fighting Ogre. 
[youtube]jwto28bmImA[/youtube]

Fighting Ogre instead is also fine. When you''re getting started it can be a great idea, as it allows for more run completions and lets you prioritize practicing more important things like Emma/Isshin and Ape Skip.
 
### Canyon
You can optionally use [Canyon Skip](/wiki/canyon-skip) to save 7s or Double Canyon Skip to save 14s.

### Gyoubu Skip
When entering Gyoubu''s arena, you want to get the 2x Ash pickup in his arena. You need to pick it up quickly, as the pick-up will be unavailable for a while once Gyoubu starts his scripted opening dialogue where he screams his name.

### Bull Skip
[youtube]lAKV66fW4A0[/youtube]

### Lone Shadow Skip
Alternatively, you can fight Lone Shadow Longswordsman, which is around 12s slower.

### Snake Eyes
There are 2 common ways of fighting this boss:
#### 180s
You can do a 180 every time Snake Eyes blocks your attack, causing her to take Vitality damage.
#### Dead-angling
You can cheese Snake Eyes by Dead-angling her at the edge of the platform you start the fight on.

### Mibu Village
You want to get the 1x Divine Confetti pickup from one of the houses in the village

### Corrupted Monk
[youtube]3IMBc2EcGiQ[/youtube]
Doing the Stealth Deathblow with only 4 ash is very precise. It is a good idea to pick up 6 or more to make it easier. You can find the extra Ash pickups here.
[youtube]RO5AVSdmHHQ[/youtube]

### Genichiro
Genichiro corner cheese tutorial:
[youtube]shdnn-LEp_s[/youtube]

### Senpou Airswim
When quitting out at the elevator, make sure you are not too high up. If you quit out and reload in a wrong spot while airswimming, the game won''t load the map that the player is in, which will result in a blackscreen that will kill the player after some time. This is a big timeloss that should be avoided.

After exiting airswim, you want to make sure to keep aggro from enemies, so that your stable ground position is not updated. After getting the Senpou Temple Grounds Idol and quitting out, you should be placed back in airswim if your last stable ground position was still when you were airswimming.

### Ape Skip
Ape Skip is required for the route to work. If you mess it up, it takes around 3 minutes to get back and try it again, so it''s highly recommended to spend a lot of time to make it consistent.
[youtube]NXTK-FEluL8[/youtube]
[youtube]Ptcm94MuvJ8[/youtube]

After getting the Shelter Stone, Homeward Idol to last Communed Idol. This will place you at the Senpou Temple Grounds.

### Monkey Skip
Monkey Skip is required for the route to work. However, you can retry it with only minor timeloss if you miss it. It is extremely difficult to become consistent at Monkey Skip. It is okay to have a 10% or lower success rate. A success rate of 25% or higher would be considered extremely high level. Mitchriz has a tutorial on how to do Monkey Skip:
[youtube]56g7lWP0utY[/youtube]

After Monkey Skip, get the Mortal Blade by talking to the Divine Child. Once it is obtained, the Invasion Event will start and your Last Communed Idol will be set as Ashina Castle - Abandoned Dungeon. Use the Homeward Idol to go to Last Communed Idol after picking up the Mortal Draw to go to Emma/Isshin.

### Emma

### Isshin',5,8,'2026-09-17 15:51:11.573890','rejected',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "pending_edits" VALUES(6,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Pick the .zip that corresponds to your operating system. The bundled windows version can be used if the regular windows version does not work.

### Import, Load & Replace

Import, load and replace are the main functions of the Save Organizer that you use. Knowing how they work are important to using the program effectively.

Importing means taking your current active save file and storing it in the Organizer.

Loading means replacing your current active save file with whichever save you loaded. Loading a save from the Organizer works like a save state, where each time you load that save, you will be put at the exact state that save was in when it was imported.

Replacing is like importing, but it works for overwriting save files that you want to make changes to. Note that this button will permanently delete the replaced save file, so make sure you think before you click it if any important save files are being used.


### Additional Tips

- It''s important to know that one save file contains ALL your save data, all your saved games and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file into the Save Organizer before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- Save files can only be loaded while you are on the title screen. You cannot load a save while you are on the main menu. However, if you are fast, you can press continue and then tab out of the game and load a save before you get to the main menu.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.
- It''s recommended to create multiple Profiles to sort your save files. One Profile per speedrun category is a good starting point.

### Downloading Save Files
If you want to download and use a save file from another player, you need to do the following steps: (Make sure to backup your own save file first, as this process will completely overwrite your save data).

1. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated. It includes a mod that allows you to load save files tied to other Steam accounts. Simply having LiveSplit and Sekiro open will make the mod take effect.

2. Download the save file(s), usually you will get a zip file that can be extracted out to a folder.

Deeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer

3. Move the downloaded save file into the folder where you keep your Save Organizer save files. If you downloaded a folder full of saves, you can also put that folder there. Each folder under the main one will form a Profile in the Save Organizer.

4. If you moved the files to the right place, they should appear in your Save Organizer after restarting it.

5. Launch the game and get to the title screen. (not the main menu).

6. Load a save file, change the settings to your taste on the main menu then replace the save.

7. Get back to the title screen by any means necessary and repeat step 6 until all save files have been updated.

',1,1,'2026-09-23 05:19:45.441227','rejected',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "pending_edits" VALUES(7,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Pick the .zip that corresponds to your operating system. The bundled windows version can be used if the regular windows version does not work.

### Import, Load & Replace

Import, load and replace are the main functions of the Save Organizer that you use. Knowing how they work are important to using the program effectively.

Importing means taking your current active save file and storing it in the Organizer.

Loading means replacing your current active save file with whichever save you loaded. Loading a save from the Organizer works like a save state, where each time you load that save, you will be put at the exact state that save was in when it was imported.

Replacing is like importing, but it works for overwriting save files that you want to make changes to. Note that this button will permanently delete the replaced save file, so make sure you think before you click it if any important save files are being used.


### Additional Tips

- It''s important to know that one save file contains ALL your save data, all your saved games and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file into the Save Organizer before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- Save files can only be loaded while you are on the title screen. You cannot load a save while you are on the main menu. However, if you are fast, you can press continue and then tab out of the game and load a save before you get to the main menu.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.
- It''s recommended to create multiple Profiles to sort your save files. One Profile per speedrun category is a good starting point.

### Downloading Save Files
If you want to download and use a save file from another player, you need to do the following steps: (Make sure to backup your own save file first, as this process will completely overwrite your save data).

1. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated. It includes a mod that allows you to load save files tied to other Steam accounts. Simply having LiveSplit and Sekiro open will make the mod take effect.

2. Download the save file(s), usually you will get a zip file that can be extracted out to a folder.

3. Move the downloaded save file into the folder where you keep your Save Organizer save files. If you downloaded a folder full of saves, you can also put that folder there. Each folder under the main one will form a Profile in the Save Organizer.
Edited


5. Launch the game and get to the title screen. (not the main menu).

6. Load a save file, change the settings to your taste on the main menu then replace the save. Test Edit



',1,1,'2026-09-29 02:37:18.434774','rejected','2026-09-29 02:37:18.433259','2026-09-29 02:41:11.895733',1,'Test',NULL,NULL,NULL);
INSERT INTO "pending_edits" VALUES(8,63,'Dojo Skip','## Dojo Skip
Dojo Skip refers to a trick that skips going inside Ashina Castle and allows early access to the roof. This is most commonly used in glitchless categories before Genichiro. There''s two versions of the skip, Backside & Frontside 

## Backside Dojo Skip
This version makes use of a window near the intended path to make it onto the roof. This is the easier but slower version of the skip, although it still saves decent time compared to the intended path. This version also allows the player to grab one quick Fistful of Ash found near the window, making it a good option for beginners as it also allows for an easy 5 ash [Corrupted Monk Cheese](https://sekirospeedrun.com/wiki/corrupted-monk-cheese).

koko838 made a tutorial on this version of the skip:
[youtube]aTMXl5NShj4[/youtube]

## Frontside Dojo Skip
This is the harder version of the skip, making use of the collision on the front side of the roof and saving around 7 seconds over backside. Note that this can also be performed to reach the roof faster after the first invasion, but the time save there is much smaller.

Pennek has made 2 tutorials on the skip:
[youtube]Fb3tdwepZnE[/youtube]
[youtube]vjTOwn6XHaU[/youtube]',3,7,'2026-09-30 16:47:04.996806','approved','2026-09-30 16:47:04.993615','2026-09-30 17:10:44.627663',2,NULL,NULL,NULL,NULL);
INSERT INTO "pending_edits" VALUES(9,50,'Corrupted Monk Cheese','## Corrupted Monk Cheese
Corrupted Monk Cheese refers to performing a stealth deathblow on Corrupted Monk (illusion) after stunning her with enough Snap Seeds and Fistfuls of Ash. It is not considered a glitch in either Speedruns or Hitless Runs.

## 4 Ash Corrupted Monk Cheese
This is the fastest and the hardest way to perform this strat, as the window in which you need to start using your consumables is very precise. It consists of using 3 Snap Seeds and 4 Fistfuls of Ash to make Corrupted Monk backstep just far enough to get a stealth deathblow. There is a tutorial for this cheese by ponetchmas:
[youtube]3IMBc2EcGiQ[/youtube]

## 5/6 Ash Variations
You can make the timing window for this strat more forgiving by using more Fistfuls of Ash. Beginners will use 5 or 6 of them to make the cheese consistent for them.',3,7,'2026-09-30 16:54:15.172993','approved','2026-09-30 16:54:15.172633','2026-09-30 17:11:04.368843',2,NULL,NULL,NULL,NULL);
INSERT INTO "pending_edits" VALUES(10,50,'Corrupted Monk Cheese','## Corrupted Monk Cheese
Corrupted Monk Cheese refers to performing an Aerial Stealth Deathblow on [Corrupted Monk (False)](/wiki/corrupted-monk-false) encountered in Ashina Depths. It is not considered a glitch in either Speedruns or Hitless Runs.

## Ash, Snap Seed & Firecrackers Variation
The most common way of killing Corrupted Monk. Just after the Corrupted Monk is triggered, you can interrupt her movement and stagger he backwards, without her detecting you, by hitting her with [Fistfuls of Ash](/wiki/fistful-of-ash), [Snap Seeds](/wiki/snap-seed) or Firecrackers from behind.

In most Speedruns, 3 Snap Seeds and 4-10 Ash will be used. It is highly recommended for beginners, to use 5 or more Ash. Firecrackers can be used like an Ash for this method. That means that the maximum possible usable items is however many Firecracker uses you have emblems for, plus 10 Ash and 3 Snap Seeds.
There is a tutorial for this cheese by ponetchmas:
[youtube]3IMBc2EcGiQ[/youtube]

Ash Pickup locations:
[youtube]RO5AVSdmHHQ[/youtube]

### 4 Ash
The fastest and hardest way to perform the strat is with 3 Snap Seeds and 4 Ash, which saves around 2-3s over using 6 Ash in most categories.

## Mist Raven Variation
An alternative method for Corrupted Monk Cheese is using Mist Raven and [Contact Medicine](/wiki/contact-medicine) to perform [Mist Raven On-Demand](/wiki/mist-raven-on-demand). With this strategy, you use the Contact Medicine before triggering the fight, then run behind her and use the Mist Raven vertically (no directional inputs held) and then attempt to get the Aerial Stealth Deathblow. Note this is not 100% consistent due to the Mist Raven teleport height/distance being inconsistent.',3,2,'2026-09-30 18:18:09.455314','approved','2026-09-30 18:18:09.454220','2026-09-30 18:20:07.053479',2,NULL,NULL,NULL,NULL);
INSERT INTO "pending_edits" VALUES(11,10,'LiveSplit','## LiveSplit
LiveSplit is a timer program for speedrunners that is both easy to use and full of features.

You can download the latest version of LiveSplit [here](https://livesplit.org/). The downloaded file will have to be extracted and the folder placed somewhere you will remember.

Right clicking the LiveSplit window and going to settings allows you to edit various settings. it''s highly recommended to enable Global Hotkeys, as this allows you to split, reset, undo split and skip split while in-game. You can also change the keybinds while you''re here.
![image](https://i.imgur.com/RezD2Uy.png)

Note: The numpad buttons won''t work while shift is pressed. This is good to know if you play with keyboard and mouse and use shift to sprint, as you won''t be able to manual split/reset/undo/skip while holding shift. But that should be fine thought, since most players will use autosplitting.

## SoulSplitter
SoulSplitter is a LiveSplit plugin developed by [Wasted](/wiki/wasted) that is designed to provide autosplitting and timekeeping across all the FromSoftware games available on PC. It is also the official leaderboard timer for Sekiro speedruns and includes various fixes that the community has agreed upon. Enabling it and using it is **required** for PC speedrun leaderboard submissions.

SoulSplitter''s included mods and fixes:
* Timer auto start and stop

* No intro movies mod

* IGT fix by B3LYP

* Cutscene blackscreen removal by Wasted

* Autosplitting by Wasted

* Event Flag logger and tracker by Wasted

* Improved tutorial pop-up removal by Wasted

* SteamID check bypass for save files by Uberhalit

**Note: Do not use other versions of these mods for leaderboard submissions. Only use them as provided automatically through LiveSplit**.

### How to Setup LiveSplit for Speedrunning (SoulSplitter Setup)
Read section above about LiveSplit and LiveSplit installation first.
1. Open LiveSplit, right-click it and select Edit Splits.
2. Find Sekiro in the Game Name Field.
![image](https://i.imgur.com/amQ9HMr.png)
3. Activate the integrated game time component.
![image](https://i.imgur.com/R1d3TTL.png)
4. Right-click LiveSplit and select Compare Against --> Game Time.
![image](https://i.imgur.com/J6yByQy.png)
5. Done!

## In-Game Time (IGT)
Sekiro has a built in timer, usually referred to as IGT (In-Game Time or In-Game Timer). However, the default behavior of it is not ideal. Its biggest problem is that there''s an issue with the way the time is incremented, which makes the timer count at a rate that is both slower than real time is supposed to run and hardware dependent in an unfair way.

The community has solved this on PC with the IGT Fix by B3LYP. The fixed version of IGT is usually referred to as modified In-Game Time, or mIGT for short. It has also been referred to as wIGT, or Wasted IGT, after Wasted took over maintaining and developing the Sekiro plugin, under the SoulSplitter project. Importantly, modified IGT is designed to run 1:1 with real time, assuming no game slowdowns due to lag or loading screens. Each second of actual gameplay equates to 1 second on the timer.

For the leaderboards, PC runs use modified IGT through LiveSplit, while console runs use the default IGT.

## Autosplitting
With SoulSplitter activated in the Edit Splits menu, you can make custom autosplits. The autosplitter gives the user freedom to setup autosplit triggers for almost anything in the game, allowing you to customize them to how you see fit. Most beginners will want to download a pre-configured .lss split file that has everything already set up and running. Below is a section on where to download splits of other players.

### How to Create Autosplits
to be added

### How to Find Event Flags (Event Flag Logger)
to be added

### What Makes a Good Autosplit?
Generally speaking, you should make a split where ever you feel like it. However, there are some considerations you should make to get the most out of LiveSplit. LiveSplit is supposed to enhance your progress as a player. It''s not supposed to be an obstacle you have to wrestle with.

* Consider splitting in the same places as others, so that you can compare with them more easily to better tell where you could save time. Below is a section that explains how to download the splits that other players use.
* Always test newly added autosplits before doing a run.
* Place autosplits at bottlenecks and be careful of autosplit points that can vary. An example is splitting on Gyoubu kill. If Gyoubu is killed close to where you need to go, then the next split will be shorter, and if he is killed far from where you need to go, then the next split will be longer. This is why most people choose to split on opening the gate after killing Gyoubu in glitchless, instead of splitting directly on kill. The door is a bottleneck that you have to go through (unless you''re doing [AP1 Bull](/wiki/attack-power-1-bull).
* Consider the precision of the autosplit you have made. The autosplitter itself is precise and accurate, but some in-game things aren''t. This is an extension of the point above, but applies more to how you choose to implement the split rather than where you place it. You can never have a precise split on Gyoubu kill, but it''s possible to have an imprecise autosplit on a spot that should otherwise be a good point to split at. Such as if you have a position split with a way too large size, or a size so small that you may run by it and miss it entirely. Test the autosplit to make sure it always triggers at the same point/time.

## Downloading Splits
Some premade .lss split files with autosplits can be downloaded [here](https://www.speedrun.com/sekiro/resources).

You can also use the website [therun.gg](https://therun.gg/games/Sekiro%3A%20Shadows%20Die%20Twice) to view and download the splits of other runners.

When you download someone else''s splits, it can be a good idea to go to Edit Splits --> Other and then Clear History and Clear Times. This will reset all the stats and times from the splits.

## Recording LiveSplit in Videos
The most popular program for recording and livestreaming is [Open Broadcaster Software (OBS)](https://obsproject.com/). It allows adding multiple layers to your scene, where you would usually use a Game Capture for Sekiro with a Window Capture for LiveSplit put on top of it.

To make a Game Capture Source in OBS:

1. Press the + in the Sources box and choose Game Capture Source. Shown below:
![image](https://www.speedrun.com/static/blob/rz2x1ke0.png)

Game Capture will only show the game, therefore we need to add a separate Source for LiveSplit itself. For capturing LiveSplit, we use a Window Capture Source.

2. Add the Window Capture in the same way you added the Game Capture in the step above (make sure that LiveSplit is open while doing this).

3. After naming it, the following window will appear. Select LiveSplit as the window.
![image](https://www.speedrun.com/static/blob/qzp2mle3.png)

I recommend setting the **"Window Match Priority"** to **"Match title, otherwise find window of same executable"**. This ensures that the Source will exclusively look for the LiveSplit window to capture.

4. Done!

### Making LiveSplit Transparent
The usual way that people make LiveSplit transparent is through a filter in OBS, which will only make it look transparent in the recording and NOT for you. Alternatively, you can use the Transparent LiveSplit fork, which makes LiveSplit''s own background transparent, instead of filtering it out in the recording.

Follow the tutorial below to make LiveSplit transparent in the recording (not needed if using the Transparent LiveSplit fork).
1. **You want to use a black background on LiveSplit. Do not use a color like green, blue or anything like that**, as this will mess with the other elements. Using the default black/dark grey background works as well.
![image](https://www.speedrun.com/static/blob/rz2x18e0.png)

The background color can be changed in layout settings.
![image](https://www.speedrun.com/static/blob/yzrrgjz4.png)

2. Right click the Window Capture you created for LiveSplit (mine is called Splits) and press Filters.
![image](https://www.speedrun.com/static/blob/5e1kpvn0.png)

3. Add a **Color Key** (not a Chroma Key). Set the type to Custom Colour and choose black. Then finally, adjust the Similarity slider until the background disappears. You will get the best looking result with a solid black LiveSplit background.
![image](https://www.speedrun.com/static/blob/xz0og0zl.png)

4. Done!

## Troubleshooting
If you have issues with the timer not automatically starting or not correctly showing the game time, triple check you are comparing against Game Time. Otherwise try restarting LiveSplit, running LiveSplit as Administrator or restarting your PC. If you need help feel free to ask in the #support channel on the [Sekiro Speedrunning Discord server](https://discord.gg/A7kWEPkKEq).

### LiveSplit Error: "The Auto Splitter could not be activated"
The most common cause of this error is that anti-virus will sometimes falsely flag SoulSplitter as an unwatend program and can quarantine the files without giving you a notification. [Here is the guide on how to create an anti-virus exclusion](https://soulsspeedruns.com/livesplit/#troubleshooting).

### LiveSplit Error: "Incomplete installation. Missing files"
Sometimes, the anti-virus fix isn''t enough. If you get an error about missing files, then you need to manually download the SoulSplitter component files from Github via the following steps:
1. Close LiveSplit.
2. Go to the [SoulSplitter Github downloads page](https://github.com/FrankvdStam/SoulSplitter/releases).
3. Download the .zip file from whatever is the latest release (do not download the ones named "source code").
4. Extract the .zip file.
5. Navigate to your LiveSplit components folder.
6. Drag the extracted files into the LiveSplit/components folder (replace files if asked).
7. Apply the anti-virus fix explained [here](https://soulsspeedruns.com/livesplit/#troubleshooting).
8. Done!

## Extra Tools for LiveSplit
to be added

## Credits
Thanks to XeroGoesFast for authoring the original LiveSplit guide.
Thanks to B3LYP for releasing the initial Sekiro timer plugin for LiveSplit.
Thanks to RefinedHornet for contributions to the old Sekiro timer.
Thanks to CapitaineToinon for contributions to the old Sekiro timer.
Thanks to Wasted for revolutionizing the Sekiro plugin with the SoulSplitter project.',1,2,'2026-09-30 20:30:19.734654','approved','2026-09-30 20:30:19.733480','2026-09-30 20:30:34.988359',2,NULL,NULL,NULL,NULL);
INSERT INTO "pending_edits" VALUES(12,23,'Pennek','## Pennek
Pennek is a Sekiro Speedrunner and glitch hunter.',2,2,'2026-09-30 21:19:43.527285','approved','2026-09-30 21:19:43.526379','2026-09-30 21:19:48.453494',2,NULL,NULL,NULL,NULL);
CREATE TABLE users (
	id INTEGER NOT NULL, 
	username VARCHAR(80) NOT NULL, 
	password VARCHAR(200) NOT NULL, 
	role VARCHAR(20), 
	profile_picture VARCHAR(500), 
	created_at DATETIME, force_password_change BOOLEAN NOT NULL DEFAULT 0, 
	PRIMARY KEY (id), 
	UNIQUE (username)
);
INSERT INTO "users" VALUES(1,'RiyuFPS','','maintainer','https://files.catbox.moe/bdbf3w.jpg','2026-02-22 11:01:06.388527',0);
INSERT INTO "users" VALUES(2,'Holm','','maintainer','https://static-cdn.jtvnw.net/jtv_user_pictures/5bd2674e-4fd9-4974-b5f4-baccea892005-profile_image-70x70.png','2026-02-22 11:01:22.061875',0);
INSERT INTO "users" VALUES(3,'Aluerie','','user','https://i.ibb.co/PZK8mCLW/Pfp-square-800-800.jpg','2026-09-16 19:30:23.303911',0);
INSERT INTO "users" VALUES(4,'Logan360sg','','verified',NULL,'2026-09-16 19:34:42.226577',0);
INSERT INTO "users" VALUES(5,'Silentsolid','','verified',NULL,'2026-09-16 19:35:05.036028',0);
INSERT INTO "users" VALUES(6,'kierran','','user',NULL,'2026-09-16 19:37:32.265247',0);
INSERT INTO "users" VALUES(7,'koko838','','verified','https://static-cdn.jtvnw.net/jtv_user_pictures/154ce9bf-642b-4284-853e-4ab682b5b7ed-profile_image-70x70.png','2026-09-16 19:45:50.240738',0);
INSERT INTO "users" VALUES(8,'kellyskater','','verified','https://files.catbox.moe/e1luf4.png','2026-09-16 23:33:30.422490',0);
INSERT INTO "users" VALUES(9,'pay_','','verified','https://static-cdn.jtvnw.net/jtv_user_pictures/e8d4e53c-2589-4d12-82ce-c78208ff674a-profile_image-70x70.png','2026-09-17 03:36:33.380742',0);
INSERT INTO "users" VALUES(10,'Yv999','','user',NULL,'2026-09-17 16:40:09.973183',0);
INSERT INTO "users" VALUES(11,'Typical','','user',NULL,'2026-09-18 03:22:38.313999',0);
INSERT INTO "users" VALUES(12,'XiaoXiangYeYu','','user','https://files.catbox.moe/9w5ayl.jpeg','2026-09-18 09:19:46.471228',0);
INSERT INTO "users" VALUES(13,'jvnjvn','','user',NULL,'2026-09-19 08:55:19.921610',0);
CREATE TABLE wiki_pages (
	id INTEGER NOT NULL, 
	title VARCHAR(150) NOT NULL, 
	content TEXT NOT NULL, 
	status VARCHAR(20), 
	deleted_at DATETIME, 
	deleted_by_id INTEGER, 
	category_before_delete_id INTEGER, 
	category_id INTEGER, 
	author_id INTEGER, 
	created_at DATETIME, 
	updated_at DATETIME, slug VARCHAR(180), submitted_at DATETIME, reviewed_at DATETIME, reviewed_by_id INTEGER REFERENCES users(id), review_note TEXT, original_title VARCHAR(150), original_content TEXT, original_category_id INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(deleted_by_id) REFERENCES users (id), 
	FOREIGN KEY(category_before_delete_id) REFERENCES categories (id), 
	FOREIGN KEY(category_id) REFERENCES categories (id), 
	FOREIGN KEY(author_id) REFERENCES users (id)
);
INSERT INTO "wiki_pages" VALUES(1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Pick the .zip that corresponds to your operating system. The bundled windows version can be used if the regular windows version does not work.

### Import, Load & Replace

Import, load and replace are the main functions of the Save Organizer that you use. Knowing how they work are important to using the program effectively.

Importing means taking your current active save file and storing it in the Organizer.

Loading means replacing your current active save file with whichever save you loaded. Loading a save from the Organizer works like a save state, where each time you load that save, you will be put at the exact state that save was in when it was imported.

Replacing is like importing, but it works for overwriting save files that you want to make changes to. Note that this button will permanently delete the replaced save file, so make sure you think before you click it if any important save files are being used.


### Additional Tips

- It''s important to know that one save file contains ALL your save data, all your saved games and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file into the Save Organizer before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- Save files can only be loaded while you are on the title screen. You cannot load a save while you are on the main menu. However, if you are fast, you can press continue and then tab out of the game and load a save before you get to the main menu.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.
- It''s recommended to create multiple Profiles to sort your save files. One Profile per speedrun category is a good starting point.

### Downloading Save Files
If you want to download and use a save file from another player, you need to do the following steps: (Make sure to backup your own save file first, as this process will completely overwrite your save data).

1. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated. It includes a mod that allows you to load save files tied to other Steam accounts. Simply having LiveSplit and Sekiro open will make the mod take effect.

2. Download the save file(s), usually you will get a zip file that can be extracted out to a folder.

3. Move the downloaded save file into the folder where you keep your Save Organizer save files. If you downloaded a folder full of saves, you can also put that folder there. Each folder under the main one will form a Profile in the Save Organizer.

4. If you moved the files to the right place, they should appear in your Save Organizer after restarting it.

5. Launch the game and get to the title screen. (not the main menu).

6. Load a save file, change the settings to your taste on the main menu then replace the save.

7. Get back to the title screen by any means necessary and repeat step 6 until all save files have been updated.

','approved',NULL,NULL,NULL,1,2,'2026-02-22 12:17:05.314734','2026-07-19 00:56:45.587741','save-file-organizer',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(2,'Practice Tools','## Practice Tools
Practice tools are used to practice more efficiently. Multiple different tools are available, all of which have different benefits.

Aside from Practice Tools, it is recommended that everyone use the [Save Organizer](https://sekirospeedrun.com/wiki/1). The Save Organizer ends up being the most important tool, so make sure to get that up and running first.

- [SekiroTool by Shilkey & Lecentz](https://github.com/borgCode/SekiroTool/releases)
- [JohnDiSanDonato''s Practice Tool](https://github.com/veeenu/sekiro-practice-tool/releases)
- [Cheat Engine](https://sekirospeedrun.com/wiki/4)

## Support
Practice tools are made by volunteers from the community and thus may have bugs. Some of the practice tool developers may not be updating their tools anymore. For help and questions it is best to ask in the #support channel on the [Sekiro Speedrunning Discord server](https://discord.gg/A7kWEPkKEq).

## Online Ban
Sekiro does not have a real online mode, therefore you cannot get banned. However, if you use the Sekiro Online mod with cheats from any of the Practice Tools, you will most likely get banned.','approved',NULL,NULL,NULL,1,2,'2026-02-22 13:03:25.682704','2026-07-19 00:44:18.933714','practice-tools',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(3,'Inside Ako (Mikiri) Armored Warrior','## Inside Ako (Mikiri) Armored Warrior

Inside Ako Mikiri Armored Warrior, also known as Mikiri Roberto, involves using the Ako inside Armored Warrior''s arena right in front of him to buff up while simultaneously triggering his AI to start up an attack. This saves time over buffing outside, as normally you need to wait a moment for his AI to properly respond to you being there. Mikiri is used as a key part of the strategy because a Thrust attack can be baited out consistently every time with this approach.

There are 6 possible patterns that Armored Warrior, assuming that the Ako is used in the right spot.
![Image Description](https://cdn.discordapp.com/attachments/552479436872613894/1476242994972852234/roberto_ako_inside_mikiri_strat_flowchart.png?ex=69a069ed&is=699f186d&hm=973a6b8e72ecd38429c5991687d1c435f538120eceb59a6008f7507c0968b778&)

Low Horizontal Swing Opener (Low Swing)
[youtube]BLwCjllSccQ[/youtube]

High Horizontal Swing Opener (High Swing)
[youtube]x26PGCo3vO0[/youtube]

Shove Opener
[youtube]2jzlJzo1k88[/youtube]

Overhead into High Swing Opener
[youtube]g31ny_JvpDE[/youtube]

Overhead into Low Swing Opener (no footage sorry :c)


Overhead into Shove Opener
[youtube]uaerk17R2yk[/youtube]


### 7-Hit Variation
A faster but riskier variation, where block hits (l1 into r1 on controller, or right click into left click on kbm) are used to squeeze in 7 hits instead of 6 during the Berserk start-up. By pressing block then attack Wolf will do a different attack animation. By doing the following it''s possible to squeeze in 7 as opposed to 6 hits after the mikiri: block, attack, attack, attack, attack, attack, block, attack, attack. This only works if the first attack after the Mikiri staggers Armored Warrior.

This variation has the downside that it can make Armored Warrior seemingly randomly cancel his Berserk and start doing regular attacks instead, which loses a large amount of time. It is not that rare for it to happen and because you only save 1 hit worth of time by doing the 7-hit variation, it generally does not save time that consistently, but may be useful if the timesave is absolutely required.','approved',NULL,NULL,NULL,3,2,'2026-02-24 11:56:48.776383','2026-03-11 05:14:28.356134','inside-ako-mikiri-armored-warrior',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(4,'Cheat Engine','## Cheat Engine

Cheat Engine, CE for short, is a tool for reading and editing game memory that gives the user a high degree of customization and freedom. Most CE users will use pre-made Cheat Tables (.ct files) that include all sorts of cheat scripts that may be useful for practicing and testing. However, experienced users will be able to use CE to create their own cheat scripts and for reverse engineering game mechanics to better understand them.

### Cheat Tables

This is a list of the recommended public cheat tables:

- [Holm''s Cheat Engine Table](https://www.speedrun.com/sekiro/resources/u3rhg) is the best simple cheat table for practicing most things.
- [Eladidu''s Cheat Engine Table](https://github.com/ElaDiDu/Sekiro-Practice-CT/releases) is the most expansive cheat table, it''s very powerful but can be hard to use.','approved',NULL,NULL,NULL,1,2,'2026-02-24 18:37:00.673198','2026-02-24 18:40:47.131022','cheat-engine',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(5,'Wasted','## Wasted
Wasted is a community member famous for developing the autosplitter for Sekiro, [SoulSplitter](/wiki/livesplit#soulsplitter).','approved',NULL,NULL,NULL,2,2,'2026-03-10 17:48:31.694466','2026-09-17 17:10:17.356938','wasted',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(6,'Gyoubu Skip','## Gyoubu Skip
Gyoubu Skip, also known as Horse Skip, is a skip with multiple variations that involves circumventing needing to fight Gyoubu Oniwa.

## Tower Jump Variation

Using a [Delayed Jump](https://sekirospeedrun.com/wiki/delayed-jump) the top of the tower near the Ashina Castle Gate, you can reach the top of the wall with a ledgegrab.

## Mist Raven Variation

Using Mist Raven together with Contact Medicine let''s you do [Mist Raven On-Demand](/wiki/mist-raven-on-demand), which can give a vertical teleport if used while standing still on the ground. Normally, you cannot wall jump after using Mist Raven. But if you block mid air after getting the vertical teleport, you regain the ability to wall jump. This requires the Mid-air Deflection Skill. After the vertical teleport, you can wall jump up high enough to reach the roof with a ledgegrab.
Video Example:
[youtube]eIv7gEKePEQ[/youtube]

On version 1.04 and below, you can also add in a ledge grab to regain the ability to jump even faster, which makes it easier to reach the top.
Video Example:
[youtube]Y9IxrDVZtNk [/youtube]

Note: The height gained from a vertical Mist Raven teleport is inconsistent, sometimes you will get a low teleport for seemingly no reason. This has not been figured out yet, but is theorized to be impacted by framerate.

This has been used in Mortal Journey Gauntlet Restricted, and in any other category where you have the necessary items and need to kill Gyoubu and immediately interact with the Ashina Castle Gate Sculptor''s Idol, where going to the tower would be a detour. However, it is not popular due to its inconsistency.

## In Glitchless

Gyoubu Skip is not allowed in glitchless speedruns. However, the tower jump is allowed if Gyoubu is dead. When used in glitchless, this is usually referred to as "Tower Jump". This can be used to skip having to open the gate and would usually be done as part of the [Attack Power 1 Bull](/wiki/attack-power-1-bull).

## History

Gyoubu Skip was theorized to be possible for a while before a reliable method was developed. Eventually, the Tower Jump method was found by Distortion2.','approved',NULL,NULL,NULL,3,2,'2026-03-10 17:59:05.393876','2026-09-17 16:59:13.738588','gyoubu-skip',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(7,'Attack Power 1 Bull','## Attack Power 1 Bull

Attack Power 1 Bull, or AP1 Bull, is a strategy for Glitchless that involves fighting Blazing Bull at 1 Attack Power after using the tower to perform Gyoubu Skip to skip opening the gate. This is only allowed in Glitchless after Gyoubu has been killed. When used in this way in glitchless, Gyoubu Skip is usually referred to as Tower Jump instead because you are not actually skipping Gyoubu.

A side effect of skipping the gate is that you don''t get to sit at an Idol before Blazing Bull, which means that you have to fight Bull at 1AP. Immediately after deathblowing Bull, you will use the Homeward Idol to travel to last communed Idol, which places you at the Ashina Castle Idol, as it is unlocked for free and set as the most recent Idol after Bull is killed. Here you sit at the Idol immediately after loading in and upgrade to AP2 before going to Genichiro. Note: you cannot interact with the Idol right away if you decide to run out the gate because the guards outside are playing scripted dialogue, during which the player cannot interact with items or interaction prompts.

Video Explanation:
[youtube]QkYEwd671Po[/youtube]

There may be slight variations depending on the exact route that the speedrun uses.

## In Shura Glitchless and Immortal Severance Glitchless
The strategy was originally invented for Shura Glitchless, but works the exact same for Immortal Severance Glitchless.

There is debate around how much time it saves, but it''s estimated to be around 2s if Bull gives the best RNG, which is 2 headbutts in a row.

## In All Memories Glitchless
In theory, the strat could work in All Mems Glitchless. However, after Genichiro in All Mems Glitchless, you need to buy 3 Yash from Blackhat Badger, which requires you to have 390 Sen. This means that you need to stand still and use a Sen Pouch at some point between picking it up before Gyoubu and before buying them. The current World Record of 53:19 by Yeruka uses the Sen Pouch while waiting for the gate to open after Blazing Bull dies. With AP1 Bull, you have to travel immediately to not lose time, which cuts out the section where you could normally use it without timeloss. So you would need to find a new spot to use the Sen Pouch, which might lose time.

If AP1 Bull can save up to 2s, then it could potentially save time overall with the timeloss from using the Sen Pouch included. It needs to be tested though.

## In All Memories & Prayer Beads Glitchless
In All Memories & Prayer Beads Glitchless, you Homeward Idol to Dilapidated Temple immediately after killing Blazing Bull in order to get Shinobi Skillbook and fit the Firecracker prosthetic. Fitting the prosthetic early is done so that Spirit Emblem collection can begin immediately, as the route is very tight on Emblems. Theoretically, you could do AP1 Bull and then upgrade AP to 2 when using the Sculptors Idol at Dilapidated Temple to travel back to Ashina Castle. However, since you buy the firecrackers from the Battlefield Memorial Mob, the angle you come from would make going to the tower slower than usual compared to the door. This needs to be tested.

## In Other Categories
AP1 Bull only makes sense to use in categories that require killing Blazing Bull, such as in glitchless categories or in glitched speedruns that need to kill all bosses or collect the 2 Prayer Beads he drops. A different variant of AP1 Bull that uses an aggro chain to save even more time is used in All Memories & Prayer Beads Restricted and All Bosses & Minibosses Restricted. The standard glitchless AP1 Bull strat is useless in categories where glitches are allowed due to this.

## History

It was discovered by XiaoZhi, aka Jason, on April 13th, 2021. It was originally designed without the tower jump in mind, but it''s clear that it is only faster when the tower jump is included.

It has historically seen very limited use due to its inconsistency. However, it had a period between January 2024 and June 2024, where a streak of Shura Glitchless WRs was set using it. It was first used to achieve a Shura Glitchless WR of 28:31 by Sev1nG on January 24th, 2024. Then again on February 14th, 2024 with a time of 28:29 by Sev1nG, again on March 23, 2024 with a time of 28:23 by Sev1nG and finally on June 9th, 2024 with a time of 28:22 by PumpKin. On September 20th, 2024, Yeruka beat PumpKin''s 28:22 with a time of 28:21. Yeruka has held the record continuously since, breaking his own record many times and notably does not use the strat. However, some players have tried breaking the record using AP1 Bull, but have so far been unsuccessful.

AP1 Bull has become an infamous strat due to its legacy.','approved',NULL,NULL,NULL,3,2,'2026-03-10 18:03:21.210823','2026-03-10 18:03:25.063439','attack-power-1-bull',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(8,'Bull Skip','## Bull Skip
Bull Skip is a skip that let''s you bypass having to fight Blazing Bull. It works on all game versions.

Video Tutorial:
[youtube]lAKV66fW4A0[/youtube]

## Patched
**The version of the skip shown above works on all versions of the game.** However, on April 23rd, 2019, patch 1.03 was released, which fixed the at the time only known way of performing Bull Skip, a way which has since been dubbed right-side Bull Skip.
Video of the right-side version that was patched:
[youtube]BxQvA3Kqh7M[/youtube]

The right side version is useless though, as the left-side version that works on all versions is faster than the right side version anyway.

## History
Bull Skip was discovered on March 28th, 2019, a week after release, by MrBundarian.','approved',NULL,NULL,NULL,3,2,'2026-03-10 18:35:45.068649','2026-07-15 12:39:03.747640','bull-skip',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(9,'Monkey Skip','## Monkey Skip
Monkey Skip is a skip that allows skipping the Folding Screen Monkeys boss in Senpou Temple.

## Regular Version
The regular version is performed via a [Delayed Jump](/wiki/delayed-jump) from a tree branch outside of the Senpou Temple Main Hall and lets you enter directly into the Inner Sanctum without fighting the Folding Screen Monkeys. The delayed jump is generally considered to be near frame perfect.
Video Tutorial:
[youtube]56g7lWP0utY[/youtube]

## Grapple Swap Version
The Grapple Swap version is an easier alternative that requires getting a Prosthetic Tool and using the Grapple Swap glitch to launch onto the roof.

Video example:
[youtube]qojSIJ91gFU[/youtube]

## Common Use Cases
Monkey Skip is most famously used in the Any% speedrun, Shura Restricted and Shura Unrestricted. It is also used in Immortal Severance Restricted, sometimes referred to as "Immortal Severance Any%".

## In Other Categories
**Monkey Skip is not allowed in Glitchless.** It also cannot be used in categories that require you to kill the Folding Screen Monkeys (such as in All Memories Restricted). It generally sees limited use in glitched categories, outside of short any% style runs, as doing Monkey Skip makes you miss getting the Attack Power upgrade from the Memory they drop, which overall ends up being slower for Shura No Airswim and Immortal Severance No Airswim. In both No Airswim categories, the Monkeys Grapple Launch is used instead.

## History
Monkey Skip was theorized to be possible by Marky around April 20th, 2019. However, [he did not manage to get it to work](https://streamable.com/3low9). It was first shown to be possible when [Distortion2 managed to land it during a testing livestream](https://www.twitch.tv/distortion2/clip/FaintAliveVelociraptorSpicyBoy) on April 24th, 2019. It proved to be insanely precise, and was thus not used in runs until [MItchriz](/wiki/mitchriz), on May 27th, 2020, discovered a consistent setup. Mitchriz used it break [LilAggy](/wiki/lilaggy)''s Any% World Record of [21:19](https://www.speedrun.com/sekiro/runs/z01g5wjy) with a time of [21:09](https://www.speedrun.com/sekiro/runs/z152krgy) on June 1st, 2020, stopping LilAggy''s nearly 1 year long reign as the WR holder. The day after, on June 2nd, he posted the tutorial linked above, which enabled other runners to be able to do the skip. On June 7th, LilAggy reclaimed the WR with a time of [21:02](https://www.speedrun.com/sekiro/runs/zx27l3km), and then beat his own record the day after on June 8th with the first sub 21-minute completion of the game with a time of [20:39](https://www.speedrun.com/sekiro/runs/y4wq6gdm). Monkey Skip has been a key part of the Any% speedrun since then.','approved',NULL,NULL,NULL,3,2,'2026-03-10 19:32:56.599299','2026-09-19 06:43:12.529071','monkey-skip',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(10,'LiveSplit','## LiveSplit
LiveSplit is a timer program for speedrunners that is both easy to use and full of features.

You can download the latest version of LiveSplit [here](https://livesplit.org/). The downloaded file will have to be extracted and the folder placed somewhere you will remember.

Right clicking the LiveSplit window and going to settings allows you to edit various settings. it''s highly recommended to enable Global Hotkeys, as this allows you to split, reset, undo split and skip split while in-game. You can also change the keybinds while you''re here.
![image](https://i.imgur.com/RezD2Uy.png)

Note: The numpad buttons won''t work while shift is pressed. This is good to know if you play with keyboard and mouse and use shift to sprint, as you won''t be able to manual split/reset/undo/skip while holding shift. But that should be fine thought, since most players will use autosplitting.

## SoulSplitter
SoulSplitter is a LiveSplit plugin developed by [Wasted](/wiki/wasted) that is designed to provide autosplitting and timekeeping across all the FromSoftware games available on PC. It is also the official leaderboard timer for Sekiro speedruns and includes various fixes that the community has agreed upon. Enabling it and using it is **required** for PC speedrun leaderboard submissions.

SoulSplitter''s included mods and fixes:
* Timer auto start and stop

* No intro movies mod

* IGT fix by B3LYP

* Cutscene blackscreen removal by Wasted

* Autosplitting by Wasted

* Event Flag logger and tracker by Wasted

* Improved tutorial pop-up removal by Wasted

* SteamID check bypass for save files by Uberhalit

**Note: Do not use other versions of these mods for leaderboard submissions. Only use them as provided automatically through LiveSplit**.

### How to Setup LiveSplit for Speedrunning (SoulSplitter Setup)
Read section above about LiveSplit and LiveSplit installation first.
1. Open LiveSplit, right-click it and select Edit Splits.
2. Find Sekiro in the Game Name Field.
![image](https://i.imgur.com/amQ9HMr.png)
3. Activate the integrated game time component.
![image](https://i.imgur.com/R1d3TTL.png)
4. Right-click LiveSplit and select Compare Against --> Game Time.
![image](https://i.imgur.com/J6yByQy.png)
5. Done!

## In-Game Time (IGT)
Sekiro has a built in timer, usually referred to as IGT (In-Game Time or In-Game Timer). However, the default behavior of it is not ideal. Its biggest problem is that there''s an issue with the way the time is incremented, which makes the timer count at a rate that is both slower than real time is supposed to run and hardware dependent in an unfair way.

The community has solved this on PC with the IGT Fix by B3LYP. The fixed version of IGT is usually referred to as modified In-Game Time, or mIGT for short. It has also been referred to as wIGT, or Wasted IGT, after Wasted took over maintaining and developing the Sekiro plugin, under the SoulSplitter project. Importantly, modified IGT is designed to run 1:1 with real time, assuming no game slowdowns due to lag or loading screens. Each second of actual gameplay equates to 1 second on the timer.

For the leaderboards, PC runs use modified IGT through LiveSplit, while console runs use the default IGT.

## Autosplitting
With SoulSplitter activated in the Edit Splits menu, you can make custom autosplits. The autosplitter gives the user freedom to setup autosplit triggers for almost anything in the game, allowing you to customize them to how you see fit. Most beginners will want to download a pre-configured .lss split file that has everything already set up and running. Below is a section on where to download splits of other players.

### How to Create Autosplits
to be added

### How to Find Event Flags (Event Flag Logger)
to be added

### What Makes a Good Autosplit?
Generally speaking, you should make a split where ever you feel like it. However, there are some considerations you should make to get the most out of LiveSplit. LiveSplit is supposed to enhance your progress as a player. It''s not supposed to be an obstacle you have to wrestle with.

* Consider splitting in the same places as others, so that you can compare with them more easily to better tell where you could save time. Below is a section that explains how to download the splits that other players use.
* Always test newly added autosplits before doing a run.
* Place autosplits at bottlenecks and be careful of autosplit points that can vary. An example is splitting on Gyoubu kill. If Gyoubu is killed close to where you need to go, then the next split will be shorter, and if he is killed far from where you need to go, then the next split will be longer. This is why most people choose to split on opening the gate after killing Gyoubu in glitchless, instead of splitting directly on kill. The door is a bottleneck that you have to go through (unless you''re doing [AP1 Bull](/wiki/attack-power-1-bull).
* Consider the precision of the autosplit you have made. The autosplitter itself is precise and accurate, but some in-game things aren''t. This is an extension of the point above, but applies more to how you choose to implement the split rather than where you place it. You can never have a precise split on Gyoubu kill, but it''s possible to have an imprecise autosplit on a spot that should otherwise be a good point to split at. Such as if you have a position split with a way too large size, or a size so small that you may run by it and miss it entirely. Test the autosplit to make sure it always triggers at the same point/time.

## Downloading Splits
Some premade .lss split files with autosplits can be downloaded [here](https://www.speedrun.com/sekiro/resources).

You can also use the website [therun.gg](https://therun.gg/games/Sekiro%3A%20Shadows%20Die%20Twice) to view and download the splits of other runners.

When you download someone else''s splits, it can be a good idea to go to Edit Splits --> Other and then Clear History and Clear Times. This will reset all the stats and times from the splits.

## Recording LiveSplit in Videos
The most popular program for recording and livestreaming is [Open Broadcaster Software (OBS)](https://obsproject.com/). It allows adding multiple layers to your scene, where you would usually use a Game Capture for Sekiro with a Window Capture for LiveSplit put on top of it.

To make a Game Capture Source in OBS:

1. Press the + in the Sources box and choose Game Capture Source. Shown below:
![image](https://www.speedrun.com/static/blob/rz2x1ke0.png)

Game Capture will only show the game, therefore we need to add a separate Source for LiveSplit itself. For capturing LiveSplit, we use a Window Capture Source.

2. Add the Window Capture in the same way you added the Game Capture in the step above (make sure that LiveSplit is open while doing this).

3. After naming it, the following window will appear. Select LiveSplit as the window.
![image](https://www.speedrun.com/static/blob/qzp2mle3.png)

I recommend setting the **"Window Match Priority"** to **"Match title, otherwise find window of same executable"**. This ensures that the Source will exclusively look for the LiveSplit window to capture.

4. Done!

### Making LiveSplit Transparent
The usual way that people make LiveSplit transparent is through a filter in OBS, which will only make it look transparent in the recording and NOT for you. Alternatively, you can use the Transparent LiveSplit fork, which makes LiveSplit''s own background transparent, instead of filtering it out in the recording.

Follow the tutorial below to make LiveSplit transparent in the recording (not needed if using the Transparent LiveSplit fork).
1. **You want to use a black background on LiveSplit. Do not use a color like green, blue or anything like that**, as this will mess with the other elements. Using the default black/dark grey background works as well.
![image](https://www.speedrun.com/static/blob/rz2x18e0.png)

The background color can be changed in layout settings.
![image](https://www.speedrun.com/static/blob/yzrrgjz4.png)

2. Right click the Window Capture you created for LiveSplit (mine is called Splits) and press Filters.
![image](https://www.speedrun.com/static/blob/5e1kpvn0.png)

3. Add a **Color Key** (not a Chroma Key). Set the type to Custom Colour and choose black. Then finally, adjust the Similarity slider until the background disappears. You will get the best looking result with a solid black LiveSplit background.
![image](https://www.speedrun.com/static/blob/xz0og0zl.png)

4. Done!

## Troubleshooting
If you have issues with the timer not automatically starting or not correctly showing the game time, triple check you are comparing against Game Time. Otherwise try restarting LiveSplit, running LiveSplit as Administrator or restarting your PC. If you need help feel free to ask in the #support channel on the [Sekiro Speedrunning Discord server](https://discord.gg/A7kWEPkKEq).

### LiveSplit Error: "The Auto Splitter could not be activated"
The most common cause of this error is that anti-virus will sometimes falsely flag SoulSplitter as an unwatend program and can quarantine the files without giving you a notification. [Here is the guide on how to create an anti-virus exclusion](https://soulsspeedruns.com/livesplit/#troubleshooting).

### LiveSplit Error: "Incomplete installation. Missing files"
Sometimes, the anti-virus fix isn''t enough. If you get an error about missing files, then you need to manually download the SoulSplitter component files from Github via the following steps:
1. Close LiveSplit.
2. Go to the [SoulSplitter Github downloads page](https://github.com/FrankvdStam/SoulSplitter/releases).
3. Download the .zip file from whatever is the latest release (do not download the ones named "source code").
4. Extract the .zip file.
5. Navigate to your LiveSplit components folder.
6. Drag the extracted files into the LiveSplit/components folder (replace files if asked).
7. Apply the anti-virus fix explained [here](https://soulsspeedruns.com/livesplit/#troubleshooting).
8. Done!

## Extra Tools for LiveSplit
to be added

## Credits
Thanks to XeroGoesFast for authoring the original LiveSplit guide.
Thanks to B3LYP for releasing the initial Sekiro timer plugin for LiveSplit.
Thanks to RefinedHornet for contributions to the old Sekiro timer.
Thanks to CapitaineToinon for contributions to the old Sekiro timer.
Thanks to Wasted for revolutionizing the Sekiro plugin with the SoulSplitter project.','approved',NULL,NULL,NULL,1,2,'2026-03-10 20:21:52.467295','2026-09-30 20:30:34.989899','livesplit',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(11,'Delayed Jump','## Delayed Jump
A Delayed Jump is a jump done at the very last moment possible when going off a ledge, in a way that makes you do the jump after having already fallen off the ledge. This type of jump allows the player to gain more distance than a standard jump.

It''s possible to both do a sprinting and a walking speed delayed jump, but in most circumstances, talk about delayed jumps refer to the sprinting variation.

A common misconception is that all delayed jumps have a frame perfect timing window. In reality, each type of ledge will have a different timing and different window of opportunity for a success jump.

## Ledges and Terrain','approved',NULL,NULL,NULL,4,2,'2026-03-11 07:25:03.692619','2026-03-14 08:16:30.445271','delayed-jump',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(12,'LilAggy','## LilAggy
LilAggy is a Twitch and Youtube content creator focusing on FromSoftware games. He held many World Records in Sekiro speedruns during the period 2019-2021. Most notably he was the first player to beat Sekiro in under 20 minutes.','approved',NULL,NULL,NULL,2,2,'2026-03-11 15:35:59.607268','2026-03-11 15:36:11.345995','lilaggy',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(13,'27-hit Ogre (Chinese Ogre)','# 27-hit Ogre (Chinese Ogre)
27-hit Ogre, also known as Chinese Ogre, is a strategy for Chained Ogre that allows you to kill him in 1 hit less than the normal 28-hit fight. When Ogre pivots, he recovers posture, so by preventing him from turning you can save 1 hit on the fight.

Because you have to stay in front of him, you need to do creative attack strafing to avoid getting hit, it would be pointless to try to do 27-hit ogre and then dodge his moves as that would end up both losing way more time than just circlestrafing around him, and would likely also result in him recovering enough posture to make it a 28-hit kill.

There is currently no tutorial for it, but a good resource to learn it is [this Bilibili playlist](https://www.bilibili.com/video/BV1FYqUYKEn5/) by Chinese runner Asphyxiansz. A common issue for the strat is that you will have something that works for some of Ogre''s attack patterns, but won''t for others. It is not merely a matter of reacting to whatever he does, you will also need to setup your position and attack animation so that you can be in the right position for any of the follow ups. Ideally, you should have something that works against most patterns. But there will be some rare patterns that you may have to dodge on.','approved',NULL,NULL,NULL,3,2,'2026-03-11 16:51:43.600072','2026-03-11 16:51:48.885926','27-hit-ogre-chinese-ogre',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(14,'Tutorial Window Jump','## Tutorial Window Jump
Tutorial Window Jump is a jump that lets you exit the Moonview Tower in the tutorial/intro section around 0.5s faster than usual.

Video Tutorial:
[youtube]T9fcivlGr78[/youtube]

This is used in Glitchless. However, for categories allowing glitches, [Tutorial Grapple Glitch](/wiki/tutorial-grapple-glitch) is a significantly better alternative for getting out of the Moonview Tower fast.

## History
Discovered by [Pennek](/wiki/pennek)','approved',NULL,NULL,NULL,3,2,'2026-03-11 17:03:11.978103','2026-07-19 02:09:46.161355','tutorial-window-jump',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(15,'Tutorial Grapple Glitch','## Tutorial Grapple Glitch
Tutorial Grapple Glitch allows you to use the grappling hook during the tutorial/intro section when hanging from a ledge specifically. Using the grapple at all during the tutorial/intro section is normally impossible because Wolf has not had his arm cut off nor the prosthetic arm attached yet in the story.

While ledge hanging, if you press crouch, jump or deflect on the same frame as you press grapple, Wolf is able to grapple in the tutorial.

This is used to exit the Moonview Tower around 0.5s faster in glitched speedruns. This is not allowed in glitchless speedruns. For glitchless, there is an alternative method called [Tutorial Window Jump](/wiki/tutorial-window-jump). Note: [TeamHitless](https://www.teamhitless.com/) allows the Tutorial Grapple Glitch in their otherwise mostly glitchless no-hit runs.

Video Tutorial:
[youtube]zFL1mjWWVfA[/youtube]

## History
Discovered by accident by Mommyemma77','approved',NULL,NULL,NULL,3,2,'2026-03-12 05:25:39.784618','2026-07-19 03:01:37.831834','tutorial-grapple-glitch',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(16,'MItchriz','## Mitchriz
Mitchriz is a speedrun content creator with a focus on Sekiro, Elden Ring and Lies of P.','approved',NULL,NULL,NULL,2,2,'2026-03-14 08:15:00.060467','2026-03-14 08:15:08.097786','mitchriz',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(17,'Sculptor''s Idol','## Sculptor''s Idol
Sculptor''s Idols serve as checkpoints and allow the player a variety of options including to rest.

## List of Idols
As grouped by the Travel Menu.

## Last Idol IDs
Internally, the game has IDs for the location of your last Idol. This not only includes locations of actual Sculptor''s Idols but also of default map locations and checkpoints (such as the location inside the Temple at Dilapidated Temple after the tutorial section).

An In-use list is provided containing only the IDs that are used during regular gameplay, and a separate full list of all working IDs is listed below that.

### In-use List


### Full list
1002949 - Hirata Map Default Location
1002950 - Dragonspring - Hirata Estate
1002951 - Estate Path
1002952 - Bamboo Thicket Slope
1002953 - Hirata Estate - Main Hall
1002954 - Hirata Estate - Hidden Temple
1002955 - Hirata Audience Chamber
1002956 - Hirata Map Default Location
1002957 - Hirata Map Default Location
1002959 - Hitara Map Default Location

1102949 - Ashina Outskirts Map Default Location
1102950 - Dilapidated Temple
1102951 - Outskirts Wall - Gate Path
1102952 - Outskirts Wall - Stairway
1102953 - Underbridge Valley
1102954 - Ashina Castle Gate Fortress
1102955 - Ashina Castle Gate
1102956 - Ashina Outskirts 
1102957 - Flames of Hatred
1102958 - Ashina Outskirts Broken Bridge
1102959 - Ashina Outskirts After Chained Ogre
1102960 - Ashina Castle Gate
1102961 - Ashina Outskirts Map Default Location
1102962 - Ashina Outskirts Map Default Location
1102963 - Ashina Outskirts Map Default Location
1102964 - Ashina Outskirts Map Default Location

1112949 - Ashina Castle Map Default Location
1112950 - Ashina Castle
1112951 - Upper Tower - Antechamber
1112952 - Castle Tower Lookout
1112953 - Upper Tower - Kuro’s Room
1112954 - Great Serpent Shrine
1112955 - Abandoned Dungeon Entrance
1112956 - Old Grave
1112957 - Upper Tower - Ashina Dojo
1112958 - Ashina Castle Map Default Location
1112959 - Ashina Castle Map Default Location

1122949 - Game Start Location
1122950 - Near Secret Passage
1122951 - Ashina Reservoir
1122952 - Game Start Location
1122953 - Game Start Location
1122954 - Game Start Location

1302948 - Abandoned Dungeon Map Default Location
1302949 - Abandoned Dungeon Map Default Location
1302950 - Underground Waterway
1302951 - Bottomless Hole
1302952 - Abandoned Dungeon Map Default Location
1302953 - Abandoned Dungeon Map Default Location
1302954 - Abandoned Dungeon Map Default Location	

1502949 - Ashina Depths Map Default Location
1502950 - Hidden Forest
1502951 - Mibu Village
1502952 - Water Mill
1502953 - Wedding Cave
1502954 - Ashina Depths Map Default Location
1502955 - Ashina Depths Map Default Location

1702948 - Sunken Valley Default Location
1702949 - Sunken Valley Default Location
1702950 - Sunken Valley
1702951 - Gun Fort
1702952 - Riven Cave
1702953 - Guardian Ape’s Watering Hole
1702954 - Poison Pool
1702955 - Ashina Depths
1702956 - Guardian Ape’s Burrow
1702957 - Under-Shrine Valley
1702958 - Bodhisattva Valley
1702959 - Sunken Valley Default Location
1702960 - Sunken Valley Default Location

2002948 - Senpou Map Default Location
2002949 - Senpou Map Default Location
2002950 - Senpou Temple, Mt. Kongo
2002951 - Shugendo
2002952 - Temple Grounds
2002953 - Main Hall
2002954 - Inner Sanctum
2002955 - Sunken Valley Cavern
2002956 - Bell Demon’s Temple
2002957 - Inner Sanctum Post-Monkeys Location
2002958 - Monkeys Arena
2002959 - Senpou Map Default Location
2002960 - Senpou Map Default Location

2502948 - Fountainhead Palace Map Default Location
2502949 - Fountainhead Palace Map Default Location
2502950 - Fountainhead Palace
2502951 - Vermilion Bridge
2502952 - Flower Viewing Stage
2502953 - Great Sakura
2502954 - Palace Grounds
2502955 - Sanctuary
2502956 - Mibu Manor
2502957 - Feeding Grounds
2502958 - Near Pot Noble
2502959 - Fountainhead Palace Map Default Location
2502960 - Fountainhead Palace Map Default Location','approved',NULL,NULL,NULL,4,2,'2026-03-14 08:29:19.127232','2026-09-16 19:34:09.080293','sculptor-s-idol',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(18,'Canyon Skip','## Canyon Skip
Not to be confused with Snake Skip. Canyon Skip refers to two possible skips that are performed in the canyon area of Ashina Outskirts where the Great Serpent is encountered for the first time.

## Single Canyon Skip
Also known as Baby Canyon.

Video Tutorial: 
[youtube]Q9Tzs5RVvSY[/youtube]


## Double Canyon Skip
Double Canyon usually refers to doing both Canyon Skips back to back, but sometimes is also used to refer to just the first Canyon Skip.

The timing window for the delayed jump is generally believed to be close to frame perfect.','approved',NULL,NULL,NULL,3,2,'2026-03-15 06:08:20.988320','2026-03-15 08:24:21.904992','canyon-skip',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(19,'Gourd Seed','## Gourd Seed

A Gourd Seed is a Key Item that can be given to Emma to upgrade the Healing Gourd. Each Gourd Seed given increases the Healing Gourd''s number of uses by 1, up to a maximum of 10.

## Acquisition

There are 9 Gourd Seeds in the game. Each one can only be acquired once, so in order to upgrade the Healing Gourd to its maximum of 10 uses, all 9 of them need to be found. All 9 can be acquired in one New Game cycle and are not missable, except when going for Shura ending. In which case, the 9th Gourd Seed, located in Fountainhead Palace, is not obtainable. Any Gourd Seeds not collected can be collected on New Game+. On New Game+, if a Gourd Seed has already been acquired, it will be replaced with a different item.

1. In Ashina Outskirts, dropped by [General Naomori Kawarada](/wiki/general-naomori-kawarada). When Invasion 2 is triggered, if Kawarada was not defeated, he will disappear and his Gourd Seed will become purchasable for 2400 Sen from the Offering Box at Dilapidated Temple.

2. In Ashina Outskirts, after [Chained Ogre](/wiki/chained-ogre-outskirts), in the building above, on the left, the item pick-up will be by two soldier uniforms hanging on a wall.

3. In Ashina Outskirts, after [Gyoubu Oniwa](/wiki/gyoubu-oniwa), 1 Gourd Seed can be purchased for 1000 Sen from the Battlefield Memorial Mob.

4. In Ashina Castle, in a chest by the Castle Antechamber Idol.

5. At Dilapidated Temple, after Genichiro is defeated, Fujioka the Info Broker will appear and sell 1 Gourd Seed for 2000 Sen.

6. In Senpou Temple, after the cricket room, the item pick-up will be in front of an immortal monk.

7. In Sunken Valley, after the Serpent''s Shrine, on the way towards Gunfort, take a sidepath on the left. Continue and climb up, the item pick-up will be in a corner in a wall cavity.

8. In Ashina Depths, Mibu Village, the item pick-up will be in the middle at the base of a large lit up tree.

9. In Fountainhead Palace, in a chest near the Palace Grounds Idol.

## Gourd Seed Duplication

It is possible to gain infinite Gourd Seeds by exploiting a glitch with the Reflections of Strength. The Offering Box, where normally up to 1 Gourd Seed can be bought from, exists during Reflections and Gauntlets. In this state, the Offering Box doesn''t have the flags for disabling items that have already been acquired or purchased, letting you purchase all of the items that it can possible sell, even if they have already been acquired.

By entering Demon of Hatred or Sword Saint Reflection, which take place during the Invasion 2 world state, and navigating to Dilapidated Temple, you are able to purchase 1 Gourd Seed from the Offering Box for 2400 Sen. When you exit the Reflection, the Sen will be refunded, but the Gourd Seed will stay in your inventory. Note: it is not possible to upgrade the Healing Gourd above the intended 10 maximum uses.','approved',NULL,NULL,NULL,4,2,'2026-07-15 12:18:25.955263','2026-09-19 06:54:08.634807','gourd-seed',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(20,'Distortion2','## Distortion2
Distortion2 is a Twitch and Youtube content creator, who is famous for pioneering Sekiro speedrunning in the early days.','approved',NULL,NULL,NULL,2,2,'2026-07-15 12:43:13.496054','2026-07-15 12:43:18.011696','distortion2',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(21,'WormdogBS','## WormdogBS
Wormdog is a Sekiro Speedrunner, who has the record for the holding the most Sekiro Speedrun World Records simultaneously, at 12.','approved',NULL,NULL,NULL,2,2,'2026-07-15 12:45:30.255607','2026-09-16 18:55:48.699010','wormdogbs',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(22,'B3LYP','## B3LYP
B3LYP, also known as just B3, is a Fromsoft game mod maker, who discovered that In-Game Time in certain Fromsoft games, including Sekiro, has an FPS-dependent clockdrift that makes the timer run in a hardware dependent and inaccurate way. B3LYP created the IGT fix that solves the issue and forms the basis of the timing method that Sekiro PC Speedruns use called Modified In-Game Time.','approved',NULL,NULL,NULL,2,2,'2026-07-15 12:52:00.686223','2026-09-19 05:37:00.315640','b3lyp',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(23,'Pennek','## Pennek
Pennek is a Sekiro Speedrunner and glitch hunter.','approved',NULL,NULL,NULL,2,2,'2026-07-19 01:25:58.636895','2026-09-30 21:19:48.455204','pennek',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(24,'Shura Glitchless','## Shura Glitchless
Shura Glitchless is Sekiro''s most popular speedrun. It''s often recommended as a good starting point for new speedrunners, as it requires a relatively small amount of time investment to learn the basics and isn''t too long of a run.

## Shura Glitchless Guides
[Mitchriz](https://sekirospeedrun.com/wiki/mitchriz) has created a great beginner guide for Shura Glitchless. It''s a few years old now, but still has good information.
[youtube]vgBAo5tqd5A[/youtube]

## Shura Glitchless Route
This guide for Shura Glitchless is made by the editors of the wiki.

### Tutorial Section
Before starting the run, make sure to disable subtitles to allow for Dialogue Skipping.

Make your way to the Moonview Tower, where Kuro is.

Talk to Kuro, and after receiving the Healing Gourd, you can press the menu button to cancel out of the dialogue early.

After speaking to Kuro, you can optionally use [Tutorial Window Jump](/wiki/tutorial-window-jump) to exit the window 0.5s faster.

### Ashina Outskirts

### Chained Ogre
When fighting Ogre, you can optionally use the [27-hit Ogre (Chinese Ogre)](/wiki/27-hit-ogre-chinese-ogre) strat to save 1 hit on Ogre, who normally will take 28 hits to kill.

### Canyon
When going through the canyon, you can optionally use [Canyon Skip](/wiki/canyon-skip) to save 7s or Double Canyon Skip to save 14s over the standard pathing.

### Gyoubu Oniwa
After the Canyon, you want to get the 1x Ako pickup on the left before going to Gyoubu. This Ako is used on Gyoubu''s 2nd phase.

When entering Gyoubu''s arena, you want to get the 2x Ash pickup in his arena. You need to pick it up quickly, as the pick-up will be unavailable for a while once Gyoubu starts his scripted opening dialogue where he screams his name.

Gyoubu is one of the most technically demanding fights in the game, and also involves a lot of situation based decision-making in terms of positioning and baiting him to do certain moves.
Ponetchmas has a tutorial for phase 1.
[youtube]wvRqTMCrhp4[/youtube]
Holm has a video where he explains how he does the full fight.
[youtube]_Ror00wWRlo[/youtube]

### Blazing Bull
Before going to Bull, you want to get the 2x Ako pickup near the cliff.

### Genichiro
Genichiro corner cheese tutorial.
[youtube]shdnn-LEp_s[/youtube]

### Armored Warrior
[Inside Ako (Mikiri) Armored Warrior](/wiki/inside-ako-mikiri-armored-warrior)

### Folding Screen Monkeys

### Gunfort

### Centipede Giraffe
[youtube]yrlm9QCklqQ[/youtube]

### Snake Eyes

### Mibu Village

### Corrupted Monk
Ponetchmas has a tutorial for the Monk Stealth Deathblow:
[youtube]3IMBc2EcGiQ[/youtube]

Doing the deathblow with 4 ashes is hard. So it''s recommended to get 6 or more ashes. Holm made a video about the available ash pickups.
[youtube]RO5AVSdmHHQ[/youtube]

### Guardian Ape
SpicyWe1ner has a tutorial for phase 1 Guardian Ape.
[youtube]gX4qJqKKtPo[/youtube]

Phase 2 generally has two strategies. The standard strat, where you deflect the plunge and headshot him with MD on the ground, and the other where you aim for MD headshots while he''s standing up, sometimes called the scream headshot strat.
Ponetchmas has a tutorial for the easier ground headshot strat.
[youtube]o9N7IHItotA[/youtube]

Ponetchmas has a tutorial for the scream headshot strat.
[youtube]reCQEDCvK9I[/youtube]


### Emma

### Isshin','approved',NULL,NULL,NULL,5,2,'2026-07-19 01:36:20.435876','2026-07-19 03:38:30.432081','shura-glitchless',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(25,'JohnDiSanDonato','## JohnDiSanDonato
JohnDiSanDonato (JDSD) is a Speedrunner and developer who created [JDSD''s Practice Tool](https://github.com/veeenu/sekiro-practice-tool/releases) for Sekiro.','approved',NULL,NULL,NULL,2,2,'2026-07-19 02:32:04.302800','2026-07-19 02:32:21.058693','johndisandonato',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(26,'Scrap Iron','## Scrap Iron
Scrap Iron is an Upgrade Material Item that is used for Prosthetic Tool Upgrades.','approved',NULL,NULL,NULL,4,2,'2026-07-19 03:44:07.413684','2026-07-19 04:00:18.421375','scrap-iron',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(27,'Healing Gourd','## Healing Gourd
The Healing Gourd is a Quick Item that heals the player upon use.','approved',NULL,NULL,NULL,4,2,'2026-07-19 04:11:23.759344','2026-07-19 04:15:04.776241','healing-gourd',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(28,'Ceramic Shard','## Ceramic Shard
A Ceramic Shard is a Consumable Quick Item that can be thrown to distract enemies.','approved',NULL,NULL,NULL,4,2,'2026-07-19 04:12:47.879726','2026-07-19 04:15:07.259159','ceramic-shard',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(29,'Yellow Gunpowder','## Yellow Gunpowder
Yellow Gunpowder is an Upgrade Material Item used for Prosthetic Tool Upgrades.','approved',NULL,NULL,NULL,4,2,'2026-07-19 04:13:34.629875','2026-07-19 04:15:09.350855','yellow-gunpowder',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(30,'Scrap Magnetite','## Scrap Magnetite
Scrap Magnetite is an Upgrade Material Item used for Prosthetic Tool Upgrades.','approved',NULL,NULL,NULL,4,2,'2026-07-19 04:14:58.306871','2026-07-19 04:15:11.048135','scrap-magnetite',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(31,'Ponetchmas','## Ponetchmas
Ponetchmas is a Sekiro speedrunner who is known for making tutorials and helping runners improve. He has also held the World Record in Immortal Severance Glitchless and All Memories & Prayer Beads Glitchless.','approved',NULL,NULL,NULL,2,2,'2026-07-19 10:46:20.155441','2026-07-19 10:58:18.210439','ponetchmas',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(32,'Ako''s Sugar','## Ako''s Sugar
Ako''s Sugar, also known as just Ako, is a Consumable Quick Item that buffs the player''s vitality damage by 12.5% and posture damage by 25% for 30s. If the player has the Devotion skill, the duration will be 45s instead.

Only one Sugar buff can be active at a time. If a new Sugar is used while Ako is already active, it will remove the Ako''s buff and apply the new Sugar''s buff.','approved',NULL,NULL,NULL,4,2,'2026-07-19 10:57:04.208619','2026-07-19 11:00:05.510933','ako-s-sugar',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(33,'Yashariku''s Sugar','## Yashariku''s Sugar
Yashariku''s Sugar, also known as Yash, is a Consumable Quick Item that temporarily buffs the player''s vitality damage by 25% and posture damage by 50%, and halves the player''s maximum HP for 30s (45s with Devotion Skill).

Only one Sugar buff can be active at a time. If a new Sugar is used while Yash is already active, it will remove the Yash''s buff and apply the new Sugar''s buff.','approved',NULL,NULL,NULL,4,2,'2026-07-19 10:59:44.130352','2026-09-20 06:32:19.749277','yashariku-s-sugar',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(34,'Shura Restricted','## Shura Restricted
Shura Restricted is generally referred to as Any% or Any% Restricted.

## Shura Restricted Guides
Gin42_ has made a full guide for Shura Restricted.
[youtube]wHK3qTTV_pY[/youtube]

## Shura Restricted Route
This guide for Shura Restricted is made by the editors of the wiki.

### Tutorial Section
Talk to Kuro, and after receiving the Healing Gourd, you can press the menu button to cancel out of the dialogue early.

After speaking to Kuro, you use the [Tutorial Grapple Glitch](/wiki/tutorial-grapple-glitch) to exit the Moonview Tower faster.
[youtube]zFL1mjWWVfA[/youtube]

Before leaving the tutorial remember to get the 2x Ash pickup right after running past Leader Shigenori Yamauchi.

### Ashina Outskirts
### Ogre Skip
Ogre Skip takes a lot of time to learn, but is around 35s faster than fighting Ogre. 
[youtube]jwto28bmImA[/youtube]

Fighting Ogre instead is also fine. When you''re getting started it can be a great idea, as it allows for more run completions and lets you prioritize practicing more important things like Emma/Isshin and Ape Skip.
 
### Canyon
You can optionally use [Canyon Skip](/wiki/canyon-skip) to save 7s or Double Canyon Skip to save 14s.

### Gyoubu Skip
When entering Gyoubu''s arena, you want to get the 2x Ash pickup in his arena. You need to pick it up quickly, as the pick-up will be unavailable for a while once Gyoubu starts his scripted opening dialogue where he screams his name.

### Bull Skip
[youtube]lAKV66fW4A0[/youtube]

### Lone Shadow Skip
Alternatively, you can fight Lone Shadow Longswordsman, which is around 12s slower.

### Snake Eyes

### Mibu Village

### Corrupted Monk
[youtube]3IMBc2EcGiQ[/youtube]
Doing the Stealth Deathblow with only 4 ash is very precise. It is a good idea to pick up 6 or more to make it easier. You can find the extra Ash pickups here.
[youtube]RO5AVSdmHHQ[/youtube]

### Genichiro
Genichiro corner cheese tutorial.
[youtube]shdnn-LEp_s[/youtube]

### Senpou Airswim
When quitting out at the elevator, make sure you are not too high up. If you quit out and reload in a wrong spot while airswimming, the game won''t load the map that the player is in, which will result in a blackscreen that will kill the player after some time. This is a big timeloss that should be avoided.

After exiting airswim, you want to make sure to keep aggro from enemies, so that your stable ground position is not updated. After getting the Senpou Temple Grounds Idol and quitting out, you should be placed back in airswim if your last stable ground position was still when you were airswimming.

### Ape Skip
Ape Skip is required for the route to work. If you mess it up, it takes around 3 minutes to get back and try it again, so it''s highly recommended to spend a lot of time to make it consistent.
[youtube]NXTK-FEluL8[/youtube]
[youtube]Ptcm94MuvJ8[/youtube]

After getting the Shelter Stone, Homeward Idol to last Communed Idol. This will place you at the Senpou Temple Grounds.

### Monkey Skip
Monkey Skip is required for the route to work. However, you can retry it with only minor timeloss if you miss it. It is extremely difficult to become consistent at Monkey Skip. It is okay to have a 10% or lower success rate. A success rate of 25% or higher would be considered extremely high level. Mitchriz has a tutorial on how to do Monkey Skip:
[youtube]56g7lWP0utY[/youtube]

After Monkey Skip, get the Mortal Blade by talking to the Divine Child. Once it is obtained, the Invasion Event will start and your Last Communed Idol will be set as Ashina Castle - Abandoned Dungeon. Use the Homeward Idol to go to Last Communed Idol after picking up the Mortal Draw to go to Emma/Isshin.

### Emma

### Isshin','approved',NULL,NULL,NULL,5,2,'2026-07-19 12:33:39.893829','2026-07-19 12:33:43.599413','shura-restricted',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(35,'Phantom Kunai (Upgrade Material)','## Phantom Kunai (Upgrade Material)
The Phantom Kunai is a Unique Upgrade Material used for unlocking the Phantom Kunai Prosthetic Tool Upgrade.

The Phantom Kunai can be purchased from Anayama the Peddler in Ashina Outskirts for 3000 Sen. After Invasion 2 takes place, Anayama will die and the Phantom Kunai will appear for sale in the Offering Box for 4500 Sen. Note: If the player kills Anayama, the Phantom Kunai will still first appear in the Offering Box after Invasion 2 happens.','approved',NULL,NULL,NULL,4,2,'2026-08-02 18:41:38.421327','2026-08-02 18:41:44.852324','phantom-kunai-upgrade-material',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(36,'Leader Shigenori Yamauchi','## Leader Shigenori Yamauchi
Leader Shigenori Yamauchi is a Miniboss that appears in Ashina Reservoir during the Tutorial. He is only available to fight during the Tutorial.

When defeated, he drops 1 Pellet, but doesn''t drop any XP or Sen due to it being in the Tutorial. Defeating him also sets your Last Communed Idol to right after where you killed him, acting as a checkpoint should you die.','approved',NULL,NULL,NULL,4,2,'2026-08-03 21:22:01.621498','2026-08-03 21:56:01.801832','leader-shigenori-yamauchi',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(37,'Corrupted Monk (False)','## Corrupted Monk (False)
Corrupted Monk is a Boss that appears in Ashina Depths.','approved',NULL,NULL,NULL,4,2,'2026-08-03 21:43:44.984184','2026-08-03 21:56:03.565830','corrupted-monk-false',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(38,'Long-arm Centipede Giraffe','## Long-arm Centipede Giraffe
Long-arm Centipede Giraffe is a Miniboss that appears in Sunken Valley at the Gunfort Shrine.','approved',NULL,NULL,NULL,4,2,'2026-08-03 21:55:56.182320','2026-08-03 21:56:05.220343','long-arm-centipede-giraffe',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(39,'Chained Ogre (Outskirts)','## Chained Ogre (Outskirts)
Chained Ogre is a Miniboss that appears in Ashina Outskirts. He disappears once Invasion 2 starts.','approved',NULL,NULL,NULL,4,2,'2026-08-04 20:31:58.116657','2026-08-04 20:32:04.886888','chained-ogre-outskirts',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(40,'Snap Seed','## Snap Seed
A Snap Seed is a Consumable Quick Item.','approved',NULL,NULL,NULL,4,2,'2026-08-06 07:55:32.515516','2026-08-06 08:05:06.836999','snap-seed',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(41,'Robert''s Firecrackers','## Robert''s Firecrackers
Robert''s Firecrackers is a unique Upgrade Material that can be Fitted to Wolf''s Prosthetic Arm in order to unlock the Shinobi Firecrackers Prosthetic.

Robert''s Firecrackers are obtained by purchasing them. They can be bought for 500 from either the Crow''s Bed Memorial Mob in Ashina Outskirts or the Battlefield Memorial Mob by Gyoubu''s arena. Once they have been bought from either Memorial Mob, they cannot be purchased again.','approved',NULL,NULL,NULL,4,2,'2026-08-06 08:04:57.320053','2026-08-06 08:05:10.182935','robert-s-firecrackers',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(42,'Ceramic Shard','## Ceramic Shard
A Ceramic Shard is a Consumable Quick Item that can be thrown in order to distract enemies.','approved',NULL,NULL,NULL,4,2,'2026-08-06 08:11:25.374281','2026-08-06 08:15:25.502797','ceramic-shard-2',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(43,'Sen','## Sen
Sen is the currency used in-game to buy things.','approved',NULL,NULL,NULL,4,2,'2026-08-06 08:12:39.452229','2026-08-06 08:15:30.763276','sen',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(44,'Shuriken Wheel','## Shuriken Wheel
The Shuriken Wheel is a unique Upgrade Material that can be Fitted to Wolf''s Prosthetic Arm in order to unlock the Loaded Shuriken Prosthetic.

The Shuriken Wheel can be picked up in Ashina Outskirts near General Naomori Kawarada.','approved',NULL,NULL,NULL,4,2,'2026-08-06 08:15:15.929687','2026-08-06 08:15:35.436740','shuriken-wheel',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(45,'Dousing Powder','## Dousing Powder
Dousing Powder is a Consumable Quick Item that heals the Burn status effect, and for a time decreases Burn buildup, increases Burn resistance and reduces damage from incoming Burn attacks.','approved',NULL,NULL,NULL,4,2,'2026-08-06 15:53:20.378159','2026-08-06 16:25:04.012674','dousing-powder',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(46,'Antidote Powder','## Antidote Powder
Antidote Powder is a Consumable Quick Item that heals the Poison status effect and temporarily increases Poison resistance.','approved',NULL,NULL,NULL,4,2,'2026-08-06 15:54:55.759475','2026-08-06 16:25:05.762994','antidote-powder',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(47,'Pacifying Agent','## Pacifying Agent
Pacifying Agent is a Consumable Quick Item that reduces Terror status effect buildup and increases Terror resistance for a time.','approved',NULL,NULL,NULL,4,2,'2026-08-06 15:57:22.362853','2026-08-06 16:25:02.146182','pacifying-agent',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(48,'Mist Raven On-Demand','## Mist Raven On-Demand
Mist Raven On-Demand is a technique that combines a constantly damaging status effect with Mist Raven in order to be able to use it without needing to time it with an enemy attack. This is most commonly done by using Contact Medicine to inflict Poison to oneself.

Mist Raven On-Demand is used in speedruns that go to NG+, such as NG+7 speedruns or All Achievements. It''s used for gaining height in order to reach places that you normally cannot.

## History
Mist Raven On-Demand was discovered by T2k5 on April 2nd, 2019.','approved',NULL,NULL,NULL,3,2,'2026-08-06 16:24:56.354250','2026-08-06 16:25:07.454682','mist-raven-on-demand',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(49,'Contact Medicine','## Contact Medicine
Contact Medicine is a Consumable Quick Item that when used applies a weak Poison effect to the player that deals 2dmg/s for 40s. While one Poison effect is active, the player cannot be inflicted with a new one until the previous one expires. This way Contact Medicine can be used to stay immune to strong Poison effects at the cost of taking 2dmg/s.

In Speedrunning, Contact Medicine is often used when a strategy requires taking damage or dying because it''s one of the most convenient ways to deal a specific amount of damage yourself.','approved',NULL,NULL,NULL,4,2,'2026-08-07 00:00:46.926944','2026-09-16 04:25:11.904528','contact-medicine',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(50,'Corrupted Monk Cheese','## Corrupted Monk Cheese
Corrupted Monk Cheese refers to performing an Aerial Stealth Deathblow on [Corrupted Monk (False)](/wiki/corrupted-monk-false) encountered in Ashina Depths. It is not considered a glitch in either Speedruns or Hitless Runs.

## Ash, Snap Seed & Firecrackers Variation
The most common way of killing Corrupted Monk. Just after the Corrupted Monk is triggered, you can interrupt her movement and stagger he backwards, without her detecting you, by hitting her with [Fistfuls of Ash](/wiki/fistful-of-ash), [Snap Seeds](/wiki/snap-seed) or Firecrackers from behind.

In most Speedruns, 3 Snap Seeds and 4-10 Ash will be used. It is highly recommended for beginners, to use 5 or more Ash. Firecrackers can be used like an Ash for this method. That means that the maximum possible usable items is however many Firecracker uses you have emblems for, plus 10 Ash and 3 Snap Seeds.
There is a tutorial for this cheese by ponetchmas:
[youtube]3IMBc2EcGiQ[/youtube]

Ash Pickup locations:
[youtube]RO5AVSdmHHQ[/youtube]

### 4 Ash
The fastest and hardest way to perform the strat is with 3 Snap Seeds and 4 Ash, which saves around 2-3s over using 6 Ash in most categories.

## Mist Raven Variation
An alternative method for Corrupted Monk Cheese is using Mist Raven and [Contact Medicine](/wiki/contact-medicine) to perform [Mist Raven On-Demand](/wiki/mist-raven-on-demand). With this strategy, you use the Contact Medicine before triggering the fight, then run behind her and use the Mist Raven vertically (no directional inputs held) and then attempt to get the Aerial Stealth Deathblow. Note this is not 100% consistent due to the Mist Raven teleport height/distance being inconsistent.','approved',NULL,NULL,NULL,3,8,'2026-09-17 14:54:24.419583','2026-09-30 18:20:07.053998','corrupted-monk-cheese',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(51,'Ogre Skip','## Ogre Skip
Ogre Skip is a technique used to skip the fight with Chained Ogre in Ashina Outskirts.

## Execution
Ogre Skip is done by performing a [Delayed Jump](https://sekirospeedrun.com/wiki/delayed-jump) off a ledge close to Chained Ogre and curving around the wall to grab a ledge. The tutorial for this skip was made by Mitchriz:
[youtube]jwto28bmImA[/youtube]
The jump is considered to be frame perfect, meaning you have exactly 1 frame during which you have to press the jump button in order to get the Delayed Jump needed to reach the ledge. Because of that, beginners are generally discouraged from implementing the skip in their runs as it isn''t very consistent and leads to a lot of resets.','approved',NULL,NULL,NULL,3,8,'2026-09-17 15:30:28.624231','2026-09-17 16:41:05.605637','ogre-skip',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(52,'Dead-angling','## Dead-angling
Dead-angling is a common way of cheesing multiple bosses. It is performed by attacking while looking away from the boss with your sword still hitting them. This way the Boss AI doesn''t think to block the attacks and lets the player hit the Boss, dealing Vitality damage.

## Common Use Cases
The technique is used most commonly in boss fights with:
- Genichiro
- Owl
- Isshin (Walk My Isshin strat)
- Lone Shadow Longswordsman
- Snake Eyes','rejected',NULL,NULL,NULL,3,8,'2026-09-17 15:59:26.758009','2026-09-30 05:05:57.332058','dead-angling',NULL,'2026-09-30 05:05:57.331725',2,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(53,'Airswim','## Airswim
Airswim is a major glitch that allows the player to fly in the air while the game thinks the player is swimming in water.

## Execution
Airswim is performed by entering a body of water while Out of Bounds and diving (requires the [Mibu Breathing Technique](/wiki/mibu-breathing-technique) Skill). This allows the player to swim everywhere as if submerged in water. It''s caused by the game transitioning between the out-of-water and swimming states only when diving or resurfacing through the surface of the water.

## Common Use Cases
Airswim is used in the majority of the Glitched categories (excluding No Airswim subcategories) and is the foundation of Any% Speedruns. It''s most commonly used to skip most of Senpou Temple and Sunken Valley and is a core part of Ape Skip. It''s also used to enter boss fights, as cutscenes also bring the player out of the swimming state.','approved',NULL,NULL,NULL,3,8,'2026-09-17 16:10:40.221650','2026-09-17 17:17:47.106462','airswim',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(54,'Aggro-chain','## Aggro-chain
Aggro-chain is a mechanic that consists of entering combat to abuse the game''s Last Registered Position system

## Execution
The glitch starts by triggering a combat encounter, which sets the player''s Last Registered Position to one moments before entering combat. After performing actions, such as discovering a [Sculptor''s Idol](/wiki/sculptor-s-idol), the player can perform a quitout to revert the current position to the Last Registered Position.

## Common Use Cases
The mechanic is most commonly used in the Airswim glitch in Any% to grab the Temple Grounds Sculptor''s Idol before performing Ape Skip. This causes the Homeward Idol''s Last Communed Idol option to teleport the player to the Temple Grounds Idol.','pending',NULL,NULL,NULL,3,8,'2026-09-17 16:26:06.469405','2026-09-17 16:26:06.469408','aggro-chain',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(55,'Loaded Shuriken','## Loaded Shuriken
The Loaded Shuriken is a Prosthetic Tool.','approved',NULL,NULL,NULL,4,2,'2026-09-17 17:06:36.062334','2026-09-17 17:06:41.829220','loaded-shuriken',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(56,'Mibu Breathing Technique','## Mibu Breathing Technique
The Mibu Breathing Technique is a Skill that is unlocked by killing the Corrupted Monk in Ashina Depths.

When the skill is unlocked, the player gains the ability to dive under water.','approved',NULL,NULL,NULL,4,2,'2026-09-17 17:16:49.144400','2026-09-17 17:16:57.496107','mibu-breathing-technique',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(57,'Lump of Grave Wax','## Lump of Grave Wax
Lump of Grave Wax is an Upgrade Material Item used for Prosthetic Tool Upgrades.','approved',NULL,NULL,NULL,4,2,'2026-09-17 18:00:19.157704','2026-09-17 18:00:57.051684','lump-of-grave-wax',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(58,'Lump of Fat Wax','## Lump of Fat Wax
Lump of Fat Wax is an Upgrade Material Item used for Prosthetic Tool Upgrades.','approved',NULL,NULL,NULL,4,2,'2026-09-17 18:00:46.556388','2026-09-17 18:00:59.676700','lump-of-fat-wax',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(59,'Fulminated Mercury','## Fulminated Mercury
Fulminated Mercury is an Upgrade Material Item used for Prosthetic Tool Upgrades.','approved',NULL,NULL,NULL,4,2,'2026-09-17 18:02:08.805683','2026-09-17 18:04:18.540832','fulminated-mercury',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(60,'Lapis Lazuli','## Lapis Lazuli
Lapis Lazuli is an Upgrade Material Item used for Lazulite Prosthetic Tool Upgrades.','approved',NULL,NULL,NULL,4,2,'2026-09-17 18:03:01.649639','2026-09-17 18:04:21.641556','lapis-lazuli',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(61,'Black Gunpowder','## Black Gunpowder
Black Gunpowder is an Upgrade Material Item used for Prosthetic Tool Upgrades.','approved',NULL,NULL,NULL,4,2,'2026-09-17 18:03:42.766712','2026-09-17 18:04:10.599255','black-gunpowder',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(62,'Pine Resin Ember','## Pine Resin Ember
Pine Resin Ember is a unique Upgrade Material Item used in Prosthetic Upgrading to unlock Okinaga''s Flame Vent.','approved',NULL,NULL,NULL,4,2,'2026-09-17 18:07:54.778827','2026-09-17 18:08:00.519366','pine-resin-ember',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(63,'Dojo Skip','## Dojo Skip
Dojo Skip refers to a trick that skips going inside Ashina Castle and allows early access to the roof. This is most commonly used in glitchless categories before Genichiro. There''s two versions of the skip, Backside & Frontside 

## Backside Dojo Skip
This version makes use of a window near the intended path to make it onto the roof. This is the easier but slower version of the skip, although it still saves decent time compared to the intended path. This version also allows the player to grab one quick Fistful of Ash found near the window, making it a good option for beginners as it also allows for an easy 5 ash [Corrupted Monk Cheese](https://sekirospeedrun.com/wiki/corrupted-monk-cheese).

koko838 made a tutorial on this version of the skip:
[youtube]aTMXl5NShj4[/youtube]

## Frontside Dojo Skip
This is the harder version of the skip, making use of the collision on the front side of the roof and saving around 7 seconds over backside. Note that this can also be performed to reach the roof faster after the first invasion, but the time save there is much smaller.

Pennek has made 2 tutorials on the skip:
[youtube]Fb3tdwepZnE[/youtube]
[youtube]vjTOwn6XHaU[/youtube]','approved',NULL,NULL,NULL,3,7,'2026-09-18 17:47:09.166261','2026-09-30 17:10:44.629270','frontdojo-skip',NULL,'2026-09-30 04:49:19.546420',2,NULL,'Frontdojo Skip','## Frontdojo Skip
Frontdojo Skip refers to a trick that skips going inside Ashina Castle and allows early access to the roof. This is most commonly used in glitchless categories before Genichiro. Note that it can also be performed to reach the roof faster after the first invasion, but the time save there is much smaller.

## Execution
Pennek has made 2 tutorials on the skip.
[youtube]Fb3tdwepZnE[/youtube]
[youtube]vjTOwn6XHaU[/youtube]',3);
INSERT INTO "wiki_pages" VALUES(64,'Blazing Bull','## Blazing Bull
Blazing Bull is a Miniboss that appears in Ashina Castle.','approved',NULL,NULL,NULL,4,2,'2026-09-19 05:17:15.128890','2026-09-19 05:31:15.977712','blazing-bull',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(65,'General Naomori Kawarada','## General Naomori Kawarada
General Naomori Kawarada is a Miniboss that appears in Ashina Outskirts.','approved',NULL,NULL,NULL,4,2,'2026-09-19 06:47:12.577666','2026-09-19 06:47:19.809131','general-naomori-kawarada',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(66,'Gyoubu Oniwa','## Gyoubu Oniwa
Gyoubu Oniwa is a Boss that appears in Ashina Outskirts.','approved',NULL,NULL,NULL,4,2,'2026-09-19 06:51:26.655710','2026-09-19 06:51:33.564912','gyoubu-oniwa',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(67,'T2k5','## T2k5
T2k5 was a glitch hunter active during the early days of the speedrun in 2019.','approved',NULL,NULL,NULL,2,2,'2026-09-19 06:56:32.862529','2026-09-19 06:56:37.114259','t2k5',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(68,'Mr Bundarian','## Mr Bundarian
Mr Bundarian found the Bull Skip. He has since deleted his Youtube channel where the original Bull Skip video was uploaded.','approved',NULL,NULL,NULL,2,2,'2026-09-19 07:00:11.755270','2026-09-19 07:00:23.995841','mr-bundarian',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(69,'All Memories Unrestricted','## All Memories Unrestricted
All Memories Unrestricted is a newer speedrun category, created in 2026 after the discovery of Slot ID Manipulation, which allows generating memories and thus quickly fulfilling the All Memories objective.','approved',NULL,NULL,NULL,5,2,'2026-09-20 06:41:46.600243','2026-09-20 06:54:23.569919','all-memories-unrestricted',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(70,'Immortal Severance Glitchless','## Immortal Severance Glitchless
Commonly called IS Glitchless.

## Immortal Severance Glitchless Route
This guide for Immortal Severance Glitchless is made by the editors of the wiki.

### Tutorial Section
Before starting the run, make sure to disable subtitles to allow for Dialogue Skipping.

Make your way to the Moonview Tower, where Kuro is.

Talk to Kuro, and after receiving the Healing Gourd, you can press the menu button to cancel out of the dialogue early.

After speaking to Kuro, you can optionally use [Tutorial Window Jump](/wiki/tutorial-window-jump) to exit the window 0.5s faster.

### Ashina Outskirts

### Chained Ogre
When fighting Ogre, you can optionally use the [27-hit Ogre (Chinese Ogre)](/wiki/27-hit-ogre-chinese-ogre) strat to save 1 hit on Ogre, who normally will take 28 hits to kill.

### Canyon
When going through the canyon, you can optionally use [Canyon Skip](/wiki/canyon-skip) to save 7s or Double Canyon Skip to save 14s over the standard pathing.

### Gyoubu Oniwa
After the Canyon, you want to get the 1x Ako pickup on the left before going to Gyoubu. This Ako is used on Gyoubu''s 2nd phase.

When entering Gyoubu''s arena, you want to get the 2x Ash pickup in his arena. You need to pick it up quickly, as the pick-up will be unavailable for a while once Gyoubu starts his scripted opening dialogue where he screams his name.

Gyoubu is one of the most technically demanding fights in the game, and also involves a lot of situation based decision-making in terms of positioning and baiting him to do certain moves.
Ponetchmas has a tutorial for phase 1.
[youtube]wvRqTMCrhp4[/youtube]
Holm has a video where he explains how he does the full fight.
[youtube]_Ror00wWRlo[/youtube]

### Blazing Bull
Before going to Bull, you want to get the 2x Ako pickup near the cliff.

### Genichiro
Genichiro corner cheese tutorial.
[youtube]shdnn-LEp_s[/youtube]

### Dialogue

### Armored Warrior
[Inside Ako (Mikiri) Armored Warrior](/wiki/inside-ako-mikiri-armored-warrior)

### Folding Screen Monkeys

### Gunfort

### Centipede Giraffe
[youtube]yrlm9QCklqQ[/youtube]

### Snake Eyes
After getting past the Snake in the cave, pick up 3x Confetti when grappling up. Confetti will be used for Owl and phase 1 Dragon. The 3rd Confetti can be used wherever the player wants, but is usually used for phase 3 True Monk or before starting the final boss fight (Genichiro, Way of Tomoe and Isshin, the Sword Saint).

### Mibu Village

### Corrupted Monk
Ponetchmas has a tutorial for the Monk Stealth Deathblow:
[youtube]3IMBc2EcGiQ[/youtube]

Doing the deathblow with 4 ashes is hard. So it''s recommended to get 6 or more ashes. Holm made a video about the available ash pickups.
[youtube]RO5AVSdmHHQ[/youtube]

### Guardian Ape
SpicyWe1ner has a tutorial for phase 1 Guardian Ape. Note that in IS, you are limited in amount of [Yashariku''s Sugar](/wiki/yashariku-s-sugar), so it''s best to use an [Ako''s Sugar](/wiki/ako-s-sugar) for phase 1.
[youtube]gX4qJqKKtPo[/youtube]

Phase 2 generally has two strategies. The standard strat, where you deflect the plunge and headshot him with MD on the ground, and the other where you aim for MD headshots while he''s standing up, sometimes called the scream headshot strat.
Ponetchmas has a tutorial for the easier ground headshot strat.
[youtube]o9N7IHItotA[/youtube]

Ponetchmas has a tutorial for the scream headshot strat.
[youtube]reCQEDCvK9I[/youtube]

### Owl
You want to corner cheese owl and use a Confetti while doing so for increase HP damage.

### Dialogue 2

### True Monk

### Fountainhead Palace

### Divine Dragon
Before entering the fight, use a Confetti. The Confetti will let you kill the Old Dragons in 1 hit less.

### Genichiro, Way of Tomoe
Before entering the fight, use a Yash, and optionally your leftover Confetti.

### Isshin, the Sword Saint
','approved',NULL,NULL,NULL,5,2,'2026-09-20 06:54:15.714931','2026-09-20 06:54:20.759599','immortal-severance-glitchless',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(71,'UmN1k','## UmN1k
UmN1k is a Sekiro Glitch Hunter.','approved',NULL,NULL,NULL,2,2,'2026-09-20 07:01:21.644759','2026-09-20 07:01:26.589771','umn1k',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(72,'Dead Angle','## Dead angle

Dead angle is a common mechanic that can happen coincidentally or can be performed intentionally to prevent the enemy from blocking/deflecting attacks. Player attacks send an attack signal in front of them right before the damage hitbox spawns. Enemies who receive this attack signal will in turn raise their guard to block/deflect. If the player is turned away from the enemy when the attack signal is sent, then the attack will be a dead angle and will directly hit for vitality damage.

## Corner Cheeses
The most popular type of Dead Angle is a corner cheese, with the most known example being Genichiro Corner Cheese, where the player gets an enemy stuck in a corner and attacks a wall next to them with the hitbox hitting the enemy.

## 180 Dead Angle
180 Dead Angle, or 180 for short, is done by first getting an attack blocked by an enemy, queuing up another attack, turning away from the enemy during the attack animation and turning back to face them at the end of it. It is most commonly used in fights with Snake Eyes and Emma, the Gentle Blade.

## Block 180 Dead Angle
Block 180 Dead Angle uses the attack animation triggered by trying to use a Combat Art with none equipped (pressing attack while blocking) and doing the same turn as in a regular 180 Dead Angle.

## Crouch 180 Dead Angle
Crouch 180 Dead Angle uses the attack animation triggered by attacking while in the crouched state and doing the same turn as in a regular 180 Dead Angle.

## Dead Range
Dead Range can be performed when being far from an enemy that can close the distance quickly. The player needs to queue up an attack at a moment when the enemy is too far away to receive the attack signal but will rush in just in time to get hit. For example, Dead Range can be used against Isshin Ashina''s opening attack, where Isshin does a quick dash attack to the player.

## Common Use Cases
Dead Angles can be seen all throughout Sekiro speedruns, but the most prominent examples are:
* Genichiro corner cheese/Walk My Geni strat
* Emma, the Gentle Blade 180 strat
* Snake Eyes corner cheese/180 strat
* Lone Shadow Longswordsman corner cheese strat
* Owl corner cheese strat','approved',NULL,NULL,NULL,4,8,'2026-09-22 11:00:42.167062','2026-09-30 05:05:48.711004','dead-angle',NULL,'2026-09-30 05:05:48.709111',2,NULL,'Dead Angle','## Dead angle

Dead angle is a common mechanic that allows the player to attack an enemy without them blocking, in turn dealing Vitality damage, by being turned away before or during an attack.

## Detailed Explanation
Player attacks send an attack signal in front of them right before the damage hitbox spawns. This attack signal will be received by any enemy that the player is facing towards and they will in turn raise their guard to block/deflect. If the player is turned away from the enemy during the short window where the attack signal is sent, then the enemy won''t raise their guard to defend themselves.

## Corner Cheeses
The most popular type of Dead Angle is a corner cheese, with the most known example being Genichiro Corner Cheese, where the player gets an enemy stuck in a corner and attacks a wall next to them with the hitbox hitting the enemy.

## 180 Dead Angle
180 Dead Angle, or 180 for short, is done by first getting an attack blocked by an enemy, queuing up another attack, turning away from the enemy during the attack animation and turning back to face them at the end of it. It is most commonly used in fights with Snake Eyes and Emma, the Gentle Blade.

## Block 180 Dead Angle
Block 180 Dead Angle uses the attack animation triggered by trying to use a Combat Art with none equipped (pressing attack while blocking) and doing the same turn as in a regular 180 Dead Angle.

## Crouch 180 Dead Angle
Crouch 180 Dead Angle uses the attack animation triggered by attacking while in the crouched state and doing the same turn as in a regular 180 Dead Angle.

## Dead Range
Dead Range can be performed when being far from an enemy that can close the distance quickly. The player needs to queue up an attack at a moment when the enemy is too far away to receive the attack signal but will rush in just in time to get hit. For example, Dead Range can be used against Isshin Ashina''s opening attack, where Isshin does a quick dash attack to the player.

## Common Use Cases
Dead Angles can be seen all throughout Sekiro speedruns, but the most prominent examples are:
* Genichiro corner cheese/Walk My Geni strat
* Emma, the Gentle Blade 180 strat
* Snake Eyes corner cheese/180 strat
* Lone Shadow Longswordsman corner cheese strat
* Owl corner cheese strat',4);
INSERT INTO "wiki_pages" VALUES(73,'Dead Angle','## Dead Angle

Dead Angle is a common mechanic that allows the player to attack an enemy without them blocking, in turn dealing Vitality damage, by being turned away before or during an attack.

## Detailed Explanation
Player attacks send an attack signal in front of them right before the damage hitbox spawns. This attack signal will be received by any enemy that the player is facing towards and they will in turn raise their guard to block/deflect. If the player is turned away from the enemy during the short window where the attack signal is sent, then the enemy won''t raise their guard to defend themselves.

## Corner Cheeses
The most popular type of Dead Angle is a corner cheese, with the most known example being Genichiro Corner Cheese, where the player gets an enemy stuck in a corner and attacks a wall next to them with the hitbox hitting the enemy.

## 180 Dead Angle
180 Dead Angle, or 180 for short, is done by first getting an attack blocked by an enemy, queuing up another attack, turning away from the enemy during the attack animation and turning back to face them at the end of it. It is most commonly used in fights with Snake Eyes and Emma, the Gentle Blade.

## Block 180 Dead Angle
Block 180 Dead Angle uses the attack animation triggered by trying to use a Combat Art with none equipped (pressing attack while blocking) and doing the same turn as in a regular 180 Dead Angle.

## Crouch 180 Dead Angle
Crouch 180 Dead Angle uses the attack animation triggered by attacking while in the crouched state and doing the same turn as in a regular 180 Dead Angle.

## Common Use Cases
Dead Angles can be seen all throughout Sekiro speedruns, but the most prominent examples are:
* Genichiro corner cheese/Walk My Geni strat
* Emma, the Gentle Blade 180 strat
* Snake Eyes corner cheese/180 strat
* Lone Shadow Longswordsman corner cheese strat
* Owl corner cheese strat','rejected',NULL,NULL,NULL,4,8,'2026-09-22 11:18:36.547492','2026-09-30 05:05:55.094584','dead-angle-2',NULL,'2026-09-30 05:05:55.092528',2,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(74,'Fistful of Ash','## Fistful of Ash
Fistful of Ash is a Consumable Quick Item.','approved',NULL,NULL,NULL,4,2,'2026-09-30 17:52:04.662364','2026-09-30 17:52:39.434902','fistful-of-ash','2026-09-30 17:52:04.659331','2026-09-30 17:52:39.432672',2,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(75,'Healing Gourd','## Healing Gourd
The Healing Gourd is a reusable Quick Item that heals the player on use.','approved',NULL,NULL,NULL,4,2,'2026-09-30 18:26:47.096124','2026-09-30 18:28:24.439937','healing-gourd-2','2026-09-30 18:26:47.095253','2026-09-30 18:28:24.439600',2,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(76,'Homeward Idol','## Homeward Idol
The Homeward Idol is a reusable Quick Item that on use allows the player to teleport to their last communed Idol or to the Dilapidated Temple.','approved',NULL,NULL,NULL,4,2,'2026-09-30 18:28:15.886468','2026-09-30 18:28:32.695283','homeward-idol','2026-09-30 18:28:15.885299','2026-09-30 18:28:32.694856',2,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(77,'Mibu Balloon of Soul','## Mibu Balloon of Soul
Mibu Balloon of Soul is a Consumable Quick Item that makes the player acquire restorative power at a higher rate for a limited amount of time.','approved',NULL,NULL,NULL,4,2,'2026-09-30 18:35:39.128856','2026-09-30 18:35:44.241065','mibu-balloon-of-soul','2026-09-30 18:35:39.126969','2026-09-30 18:35:44.240018',2,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(78,'Bite Down','## Bite Down
Bite Down is a Consumable Quick Item that kills the player on use.','approved',NULL,NULL,NULL,4,2,'2026-09-30 18:36:26.941960','2026-09-30 18:41:12.080778','bite-down','2026-09-30 18:36:26.941319','2026-09-30 18:41:12.080118',2,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(79,'Red Lump','## Red Lump
Red Lump is a Consumable Quick Item that on use makes the player nearly unstaggerable but unable to resurrect for 30s.','approved',NULL,NULL,NULL,4,2,'2026-09-30 18:41:01.635189','2026-09-30 18:41:15.699161','red-lump','2026-09-30 18:41:01.634290','2026-09-30 18:41:15.698510',2,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(80,'Heavy Coin Purse','## Heavy Coin Purse
Heavy Coin Purse is a Consumable Quick Item that gives 500 [Sen](/wiki/sen) on use. Light Coin Purses, Heavy Coin Purses and Bulging Coin Purses serve as a way to store Sen so that it is not lost upon death. Many merchants sell them at a 10% markup as a way to store your Sen.','approved',NULL,NULL,NULL,4,2,'2026-09-30 18:49:34.302926','2026-09-30 18:54:54.931391','heavy-coin-purse','2026-09-30 18:49:34.301706','2026-09-30 18:54:54.928941',2,NULL,'Heavy Coin Purse','## Heavy Coin Purse
Heavy Coin Purse is a Consumable Quick Item that gives 500 Sen on use. Light Coin Purses, Heavy Coin Purses or Bulging Coin Purses serve as a way to store Sen so that it is not lost upon death. Many merchants sell them at a 10% markup as a way to store your Sen.',4);
INSERT INTO "wiki_pages" VALUES(81,'Light Coin Purse','## Light Coin Purse
Light Coin Purse is a Consumable Quick Item that gives 100 [Sen](/wiki/sen) on use. Light Coin Purses, Heavy Coin Purses and Bulging Coin Purses serve as a way to store Sen so that it is not lost upon death. Many merchants sell them at a 10% markup as a way to store your Sen.','approved',NULL,NULL,NULL,4,2,'2026-09-30 18:51:37.008176','2026-09-30 18:54:51.257511','light-coin-purse','2026-09-30 18:51:37.007733','2026-09-30 18:54:51.256493',2,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(82,'Bulging Coin Purse','## Bulging Coin Purse
Bulging Coin Purse is a Consumable Quick Item that gives 1000 [Sen](/wiki/sen) on use. Light Coin Purses, Heavy Coin Purses and Bulging Coin Purses serve as a way to store Sen so that it is not lost upon death. Many merchants sell them at a 10% markup as a way to store your Sen.','approved',NULL,NULL,NULL,4,2,'2026-09-30 18:52:39.715580','2026-09-30 18:54:58.688317','bulging-coin-purse','2026-09-30 18:52:39.715149','2026-09-30 18:54:58.687294',2,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(83,'SaraToga','## SaraToga
SaraToga is a Sekiro speedrunner and strat finder. They are most known for their NG+7 speedruns.','approved',NULL,NULL,NULL,2,2,'2026-09-30 20:33:02.400576','2026-09-30 20:33:07.499409','saratoga','2026-09-30 20:33:02.399377','2026-09-30 20:33:07.497894',2,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(84,'Guardian Ape','## Guardian Ape
Guardian Ape is a Boss that appears in Sunken Valley.','approved',NULL,NULL,NULL,4,2,'2026-09-30 20:40:30.258957','2026-09-30 21:08:18.709090','guardian-ape','2026-09-30 20:40:30.258542','2026-09-30 21:08:18.707914',2,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(85,'Divine Dragon','## Divine Dragon
Divine Dragon is a Boss that appears in Fountainhead Palace.','approved',NULL,NULL,NULL,4,2,'2026-09-30 20:41:02.990331','2026-09-30 21:17:25.267702','divine-dragon','2026-09-30 20:41:02.989927','2026-09-30 21:17:25.267351',2,NULL,NULL,NULL,NULL);
INSERT INTO "wiki_pages" VALUES(86,'Armored Warrior','## Armored Warrior
Armored Warrior is a Miniboss that appears in Senpou Temple.','approved',NULL,NULL,NULL,4,2,'2026-09-30 20:41:39.178644','2026-09-30 21:17:33.510122','armored-warrior','2026-09-30 20:41:39.177011','2026-09-30 21:17:33.509411',2,NULL,NULL,NULL,NULL);
CREATE TABLE wiki_revisions (
	id INTEGER NOT NULL, 
	page_id INTEGER, 
	title VARCHAR(150) NOT NULL, 
	content TEXT NOT NULL, 
	category_id INTEGER, 
	editor_id INTEGER, 
	created_at DATETIME, 
	PRIMARY KEY (id), 
	FOREIGN KEY(page_id) REFERENCES wiki_pages (id), 
	FOREIGN KEY(category_id) REFERENCES categories (id), 
	FOREIGN KEY(editor_id) REFERENCES users (id)
);
INSERT INTO "wiki_revisions" VALUES(1,1,'Save File Organizer','# 


Download Kahmul''s Save Organizer here. Note: The bundled windows version can be used if the regular version does not work.
https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases 

',1,2,'2026-02-22 12:32:29.105541');
INSERT INTO "wiki_revisions" VALUES(2,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

Usage tutorial:

[youtube]v=-m1PwqIZLyo[/youtube]


Download Kahmul''s Save Organizer here: https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases
Note: The bundled windows version can be used if the regular version does not work.

',1,2,'2026-02-22 12:34:50.431503');
INSERT INTO "wiki_revisions" VALUES(3,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

Usage tutorial:

[youtube]-m1PwqIZLyo[/youtube]


Download Kahmul''s Save Organizer here: https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases
Note: The bundled windows version can be used if the regular version does not work.

',1,2,'2026-02-22 12:35:32.389699');
INSERT INTO "wiki_revisions" VALUES(4,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]


Download Kahmul''s Save Organizer here: https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases
Note: The bundled windows version can be used if the regular version does not work.

',1,2,'2026-02-22 12:36:22.284322');
INSERT INTO "wiki_revisions" VALUES(5,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer here: https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases
Note: The bundled windows version can be used if the regular version does not work.

',1,2,'2026-02-22 12:39:57.893136');
INSERT INTO "wiki_revisions" VALUES(6,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

Usage tutorial: [youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer here: https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases
Note: The bundled windows version can be used if the regular version does not work.

',1,2,'2026-02-22 12:40:34.303195');
INSERT INTO "wiki_revisions" VALUES(7,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial: [youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer here: https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases
Note: The bundled windows version can be used if the regular version does not work.

',1,2,'2026-02-22 12:41:12.486623');
INSERT INTO "wiki_revisions" VALUES(8,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer here: https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases
Note: The bundled windows version can be used if the regular version does not work.

',1,2,'2026-02-22 12:42:41.563275');
INSERT INTO "wiki_revisions" VALUES(9,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer here: [Link](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases)
Note: The bundled windows version can be used if the regular version does not work.

',1,2,'2026-02-22 12:46:49.837702');
INSERT INTO "wiki_revisions" VALUES(10,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer here: [Link](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases)

Note: The bundled windows version can be used if the regular version does not work.

',1,2,'2026-02-22 12:47:51.368483');
INSERT INTO "wiki_revisions" VALUES(11,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer here: [Link](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases)

Note: The bundled windows version can be used if the regular version does not work.
asdasd

',1,2,'2026-02-22 12:52:25.325212');
INSERT INTO "wiki_revisions" VALUES(12,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer here: [Link](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases)

Note: The bundled windows version can be used if the regular version does not work.

',1,2,'2026-02-22 12:53:23.213662');
INSERT INTO "wiki_revisions" VALUES(13,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer: [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases)

Note: The bundled windows version can be used if the regular version does not work.

',1,2,'2026-02-22 12:53:49.481722');
INSERT INTO "wiki_revisions" VALUES(14,2,'Practice Tools','Practice tools are used to practice more efficiently. Multiple different tools are available, all of which have different benefits.


- [SekiroTool by Shilkey & Lecentz](https://github.com/borgCode/SekiroTool/releases)
- Item 2
- Item 3
',1,2,'2026-02-22 13:08:43.387997');
INSERT INTO "wiki_revisions" VALUES(15,2,'Practice Tools','Practice tools are used to practice more efficiently. Multiple different tools are available, all of which have different benefits.


- [SekiroTool by Shilkey & Lecentz](https://github.com/borgCode/SekiroTool/releases)
- [JohnDiSanDonato''s Practice Tool](https://github.com/veeenu/sekiro-practice-tool/releases)
- Item 3
',1,2,'2026-02-22 13:19:00.630510');
INSERT INTO "wiki_revisions" VALUES(16,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Note: The bundled windows version can be used if the regular version does not work.

',1,2,'2026-02-24 05:22:01.820428');
INSERT INTO "wiki_revisions" VALUES(17,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Note: The bundled windows version can be used if the regular version does not work.

### Additional Tips

- It''s important to know that one save file contains ALL your save data. All your playthroughs and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.

### Downloading save files
(Make sure to backup your own savefile first, as this process will completely overwrite your old save data).
If you want to download and use a savefile from another player, you need to do the following steps:
1. Download the save file (which is supposed to be a S0000.sl2.)
2. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated.
3. Move the downloaded save file into the folder where you keep your save organizer save files.
4. Launch the game',1,2,'2026-02-24 05:26:30.739824');
INSERT INTO "wiki_revisions" VALUES(18,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Note: The bundled windows version can be used if the regular version does not work.

### Additional Tips

- It''s important to know that one save file contains ALL your save data. All your playthroughs and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file into the Save Organizer before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- Save files can only be loaded while you are on the title screen. You cannot load a save while you are on the main menu. However, if you are fast, you can press continue and then tab out of the game and load a save before you get to the main menu.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.

### Downloading save files
(Make sure to backup your own savefile first, as this process will completely overwrite your old save data).
If you want to download and use a savefile from another player, you need to do the following steps:
1. Download the save file (which is supposed to be a S0000.sl2.)
2. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated.
3. Move the downloaded save file into the folder where you keep your save organizer save files.
4. If you moved the files to the right place, they should appear in your Save Organizer after restarting it.
5. Launch the game and get to the title screen. (not the main menu).
6. Load a save file, change the settings to your taste on the main menu then replace the save.
7. Get back to the title screen by any means necessary and repeat step 6 until all save files have been updated.',1,2,'2026-02-24 05:27:06.387265');
INSERT INTO "wiki_revisions" VALUES(19,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Note: The bundled windows version can be used if the regular version does not work.

### Additional Tips

- It''s important to know that one save file contains ALL your save data. All your playthroughs and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file into the Save Organizer before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- Save files can only be loaded while you are on the title screen. You cannot load a save while you are on the main menu. However, if you are fast, you can press continue and then tab out of the game and load a save before you get to the main menu.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.

### Downloading save files
(Make sure to backup your own savefile first, as this process will completely overwrite your old save data).
If you want to download and use a savefile from another player, you need to do the following steps:
1. Download the save file (which is supposed to be a S0000.sl2.)
2. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated.
3. Move the downloaded save file into the folder where you keep your save organizer save files.
4. If you moved the files to the right place, they should appear in your Save Organizer after restarting it.
5. Launch the game and get to the title screen. (not the main menu).
6. Load a save file, change the settings to your taste on the main menu then replace the save.
7. Get back to the title screen by any means necessary and repeat step 6 until all save files have been updated.
1. Item 1
2. Item 2
3. Item 3
',1,2,'2026-02-24 05:27:24.696378');
INSERT INTO "wiki_revisions" VALUES(20,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Note: The bundled windows version can be used if the regular version does not work.

### Additional Tips

- It''s important to know that one save file contains ALL your save data. All your playthroughs and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file into the Save Organizer before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- Save files can only be loaded while you are on the title screen. You cannot load a save while you are on the main menu. However, if you are fast, you can press continue and then tab out of the game and load a save before you get to the main menu.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.

### Downloading save files
(Make sure to backup your own savefile first, as this process will completely overwrite your old save data).
If you want to download and use a savefile from another player, you need to do the following steps:
1. Download the save file (which is supposed to be a S0000.sl2.)
2. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated.
3. Move the downloaded save file into the folder where you keep your save organizer save files.
4. If you moved the files to the right place, they should appear in your Save Organizer after restarting it.
5. Launch the game and get to the title screen. (not the main menu).
6. Load a save file, change the settings to your taste on the main menu then replace the save.
7. Get back to the title screen by any means necessary and repeat step 6 until all save files have been updated.
',1,2,'2026-02-24 05:48:43.180614');
INSERT INTO "wiki_revisions" VALUES(21,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Pick the .zip that corresponds to your operating system. The bundled windows version can be used if the regular windows version does not work.

### Additional Tips

- It''s important to know that one save file contains ALL your save data. All your playthroughs and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file into the Save Organizer before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- Save files can only be loaded while you are on the title screen. You cannot load a save while you are on the main menu. However, if you are fast, you can press continue and then tab out of the game and load a save before you get to the main menu.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.

### Downloading save files
(Make sure to backup your own savefile first, as this process will completely overwrite your old save data).
If you want to download and use a savefile from another player, you need to do the following steps:
1. Download the save file (which is supposed to be a S0000.sl2.)
2. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated.
3. Move the downloaded save file into the folder where you keep your save organizer save files.
4. If you moved the files to the right place, they should appear in your Save Organizer after restarting it.
5. Launch the game and get to the title screen. (not the main menu).
6. Load a save file, change the settings to your taste on the main menu then replace the save.
7. Get back to the title screen by any means necessary and repeat step 6 until all save files have been updated.
',1,2,'2026-02-24 05:53:30.310979');
INSERT INTO "wiki_revisions" VALUES(22,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Pick the .zip that corresponds to your operating system. The bundled windows version can be used if the regular windows version does not work.

### Additional Tips

- It''s important to know that one save file contains ALL your save data, all your saved games and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file into the Save Organizer before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- Save files can only be loaded while you are on the title screen. You cannot load a save while you are on the main menu. However, if you are fast, you can press continue and then tab out of the game and load a save before you get to the main menu.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.
- Loading a save from the Organizer works like a save state, where each time you load that save, you will be put at the exact state that save was in when it was saved. This means that the save can be used to practice things over and over again.

### Downloading Save Files
(Make sure to backup your own save file first, as this process will completely overwrite your save data).
If you want to download and use a save file from another player, you need to do the following steps:
1. Download the save file (which is supposed to be a S0000.sl2.)
2. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated.
3. Move the downloaded save file into the folder where you keep your save organizer save files.
4. If you moved the files to the right place, they should appear in your Save Organizer after restarting it.
5. Launch the game and get to the title screen. (not the main menu).
6. Load a save file, change the settings to your taste on the main menu then replace the save.
7. Get back to the title screen by any means necessary and repeat step 6 until all save files have been updated.
',1,2,'2026-02-24 06:00:37.742688');
INSERT INTO "wiki_revisions" VALUES(23,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Pick the .zip that corresponds to your operating system. The bundled windows version can be used if the regular windows version does not work.

### Import, Load & Replace

Import, load and replace are the main functions of the Save Organizer that you use. Knowing how they work are important to using the program effectively.

Importing means taking your current active save file and storing it in the Organizer.

Loading means replacing your current active save file with whichever save you loaded.

Replacing is like importing, but it works for updating save files that you want to change. Note that this button will permanently delete the replaced save file, so make sure you think before you click it if any important save files are being used.


### Additional Tips

- It''s important to know that one save file contains ALL your save data, all your saved games and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file into the Save Organizer before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- Save files can only be loaded while you are on the title screen. You cannot load a save while you are on the main menu. However, if you are fast, you can press continue and then tab out of the game and load a save before you get to the main menu.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.
- Loading a save from the Organizer works like a save state, where each time you load that save, you will be put at the exact state that save was in when it was saved. This means that the save can be used to practice things over and over again. If you want an already saved save file to have its progress updated, you need to "replace it" with 

### Downloading Save Files
(Make sure to backup your own save file first, as this process will completely overwrite your save data).
If you want to download and use a save file from another player, you need to do the following steps:
1. Download the save file (which is supposed to be a S0000.sl2.)
2. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated.
3. Move the downloaded save file into the folder where you keep your save organizer save files.
4. If you moved the files to the right place, they should appear in your Save Organizer after restarting it.
5. Launch the game and get to the title screen. (not the main menu).
6. Load a save file, change the settings to your taste on the main menu then replace the save.
7. Get back to the title screen by any means necessary and repeat step 6 until all save files have been updated.
',1,2,'2026-02-24 11:55:44.180860');
INSERT INTO "wiki_revisions" VALUES(24,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Pick the .zip that corresponds to your operating system. The bundled windows version can be used if the regular windows version does not work.

### Import, Load & Replace

Import, load and replace are the main functions of the Save Organizer that you use. Knowing how they work are important to using the program effectively.

Importing means taking your current active save file and storing it in the Organizer.

Loading means replacing your current active save file with whichever save you loaded.

Replacing is like importing, but it works for updating save files that you want to change. Note that this button will permanently delete the replaced save file, so make sure you think before you click it if any important save files are being used.


### Additional Tips

- It''s important to know that one save file contains ALL your save data, all your saved games and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file into the Save Organizer before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- Save files can only be loaded while you are on the title screen. You cannot load a save while you are on the main menu. However, if you are fast, you can press continue and then tab out of the game and load a save before you get to the main menu.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.
- Loading a save from the Organizer works like a save state, where each time you load that save, you will be put at the exact state that save was in when it was saved. This means that the save can be used to practice things over and over again. If you want an already saved save file to have its progress updated, you need to "replace it" with 

### Downloading Save Files
(Make sure to backup your own save file first, as this process will completely overwrite your save data).
If you want to download and use a save file from another player, you need to do the following steps:

1. Download the save file (which is supposed to be a S0000.sl2.)

2. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated.

3. Move the downloaded save file into the folder where you keep your save organizer save files.

4. If you moved the files to the right place, they should appear in your Save Organizer after restarting it.

5. Launch the game and get to the title screen. (not the main menu).

6. Load a save file, change the settings to your taste on the main menu then replace the save.

7. Get back to the title screen by any means necessary and repeat step 6 until all save files have been updated.
',1,2,'2026-02-24 13:33:30.057941');
INSERT INTO "wiki_revisions" VALUES(25,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Pick the .zip that corresponds to your operating system. The bundled windows version can be used if the regular windows version does not work.

### Import, Load & Replace

Import, load and replace are the main functions of the Save Organizer that you use. Knowing how they work are important to using the program effectively.

Importing means taking your current active save file and storing it in the Organizer.

Loading means replacing your current active save file with whichever save you loaded.

Replacing is like importing, but it works for updating save files that you want to change. Note that this button will permanently delete the replaced save file, so make sure you think before you click it if any important save files are being used.


### Additional Tips

- It''s important to know that one save file contains ALL your save data, all your saved games and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file into the Save Organizer before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- Save files can only be loaded while you are on the title screen. You cannot load a save while you are on the main menu. However, if you are fast, you can press continue and then tab out of the game and load a save before you get to the main menu.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.
- Loading a save from the Organizer works like a save state, where each time you load that save, you will be put at the exact state that save was in when it was saved. This means that the save can be used to practice things over and over again. If you want an already saved save file to have its progress updated, you need to "replace it" with 

### Downloading Save Files
If you want to download and use a save file from another player, you need to do the following steps: (Make sure to backup your own save file first, as this process will completely overwrite your save data).

1. Download the save file (which is supposed to be a S0000.sl2.)

2. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated.

3. Move the downloaded save file into the folder where you keep your save organizer save files.

4. If you moved the files to the right place, they should appear in your Save Organizer after restarting it.

5. Launch the game and get to the title screen. (not the main menu).

6. Load a save file, change the settings to your taste on the main menu then replace the save.

7. Get back to the title screen by any means necessary and repeat step 6 until all save files have been updated.
',1,2,'2026-02-24 18:03:29.404864');
INSERT INTO "wiki_revisions" VALUES(26,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Pick the .zip that corresponds to your operating system. The bundled windows version can be used if the regular windows version does not work.

### Import, Load & Replace

Import, load and replace are the main functions of the Save Organizer that you use. Knowing how they work are important to using the program effectively.

Importing means taking your current active save file and storing it in the Organizer.

Loading means replacing your current active save file with whichever save you loaded.

Replacing is like importing, but it works for updating save files that you want to change. Note that this button will permanently delete the replaced save file, so make sure you think before you click it if any important save files are being used.


### Additional Tips

- It''s important to know that one save file contains ALL your save data, all your saved games and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file into the Save Organizer before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- Save files can only be loaded while you are on the title screen. You cannot load a save while you are on the main menu. However, if you are fast, you can press continue and then tab out of the game and load a save before you get to the main menu.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.
- Loading a save from the Organizer works like a save state, where each time you load that save, you will be put at the exact state that save was in when it was saved. This means that the save can be used to practice things over and over again. If you want an already saved save file to have its progress updated, you need to "replace it" with 

### Downloading Save Files
If you want to download and use a save file from another player, you need to do the following steps: (Make sure to backup your own save file first, as this process will completely overwrite your save data).

1. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated.

2. Download the save file (which is supposed to be a S0000.sl2.)

3. Move the downloaded save file into the folder where you keep your save organizer save files.

4. If you moved the files to the right place, they should appear in your Save Organizer after restarting it.

5. Launch the game and get to the title screen. (not the main menu).

6. Load a save file, change the settings to your taste on the main menu then replace the save.

7. Get back to the title screen by any means necessary and repeat step 6 until all save files have been updated.
',1,2,'2026-02-24 18:08:21.074628');
INSERT INTO "wiki_revisions" VALUES(27,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Pick the .zip that corresponds to your operating system. The bundled windows version can be used if the regular windows version does not work.

### Import, Load & Replace

Import, load and replace are the main functions of the Save Organizer that you use. Knowing how they work are important to using the program effectively.

Importing means taking your current active save file and storing it in the Organizer.

Loading means replacing your current active save file with whichever save you loaded.

Replacing is like importing, but it works for updating save files that you want to change. Note that this button will permanently delete the replaced save file, so make sure you think before you click it if any important save files are being used.


### Additional Tips

- It''s important to know that one save file contains ALL your save data, all your saved games and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file into the Save Organizer before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- Save files can only be loaded while you are on the title screen. You cannot load a save while you are on the main menu. However, if you are fast, you can press continue and then tab out of the game and load a save before you get to the main menu.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.
- It''s recommended to create multiple Profiles to sort your save files. One Profile per speedrun category is a good starting point.
- Loading a save from the Organizer works like a save state, where each time you load that save, you will be put at the exact state that save was in when it was saved. This means that the save can be used to practice things over and over again. If you want an already saved save file to have its progress updated, you need to "replace it" with 

### Downloading Save Files
If you want to download and use a save file from another player, you need to do the following steps: (Make sure to backup your own save file first, as this process will completely overwrite your save data).

1. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated. It includes a mod that allows you to load save files tied to other Steam accounts. Simply having LiveSplit and Sekiro open will make the mod take effect.

2. Download the save file(s), usually you will get a zip file that can be extracted out to a folder.

3. Move the downloaded save file into the folder where you keep your Save Organizer save files. If you downloaded a folder full of saves, you can also put that folder there. Each folder under the main one will form a Profile in the Save Organizer.

4. If you moved the files to the right place, they should appear in your Save Organizer after restarting it.

5. Launch the game and get to the title screen. (not the main menu).

6. Load a save file, change the settings to your taste on the main menu then replace the save.

7. Get back to the title screen by any means necessary and repeat step 6 until all save files have been updated.
',1,2,'2026-02-24 18:25:08.451801');
INSERT INTO "wiki_revisions" VALUES(28,2,'Practice Tools','Practice tools are used to practice more efficiently. Multiple different tools are available, all of which have different benefits.

Aside from Practice Tools, it is recommended that everyone use the [Save Organizer](https://riyu.pythonanywhere.com/wiki/1)

- [SekiroTool by Shilkey & Lecentz](https://github.com/borgCode/SekiroTool/releases)
- [JohnDiSanDonato''s Practice Tool](https://github.com/veeenu/sekiro-practice-tool/releases)
- Cheat Engine
',1,2,'2026-02-24 18:30:42.445548');
INSERT INTO "wiki_revisions" VALUES(29,4,'Cheat Engine','## Cheat Engine

Cheat Engine, CE for short, is a tool for reading and editing game memory that gives users a high degree of customization and freedom. Most CE users will use pre-made Cheat Tables (.ct files) that includes all sorts of scripts that may be useful for practicing and testing.

### Cheat Tables

This is a list of the recommended public cheat tables:

- [Holm''s Cheat Engine Table](https://www.speedrun.com/sekiro/resources/u3rhg) is the best simple cheat table for practicing most things.
- [Eladidu''s Cheat Engine Table](https://github.com/ElaDiDu/Sekiro-Practice-CT/releases) is the most expansive cheat table, it''s very powerful but can be hard to use.',1,2,'2026-02-24 18:38:48.985600');
INSERT INTO "wiki_revisions" VALUES(30,4,'Cheat Engine','## Cheat Engine

Cheat Engine, CE for short, is a tool for reading and editing game memory that gives users a high degree of customization and freedom. Most CE users will use pre-made Cheat Tables (.ct files) that includes all sorts of scripts that may be useful for practicing and testing. However, experienced users will be able to use CE to create their own cheat scripts and for reverse engineering game mechanics to better understand them.

### Cheat Tables

This is a list of the recommended public cheat tables:

- [Holm''s Cheat Engine Table](https://www.speedrun.com/sekiro/resources/u3rhg) is the best simple cheat table for practicing most things.
- [Eladidu''s Cheat Engine Table](https://github.com/ElaDiDu/Sekiro-Practice-CT/releases) is the most expansive cheat table, it''s very powerful but can be hard to use.',1,2,'2026-02-24 18:40:47.131268');
INSERT INTO "wiki_revisions" VALUES(31,3,'Inside Ako Armored Warrior','## Inside Ako Armored Warrior

5 RNG patterns.',1,2,'2026-02-24 20:59:11.416239');
INSERT INTO "wiki_revisions" VALUES(32,3,'Inside Ako Armored Warrior','## Inside Ako Armored Warrior

5 RNG patterns.

### 7-Hit Variation

Can fail.',1,2,'2026-02-25 13:52:36.136633');
INSERT INTO "wiki_revisions" VALUES(33,3,'Inside Ako (Mikiri) Armored Warrior','## Inside Ako (Mikiri) Armored Warrior

The inside Ako strategy involves using the Ako inside to buff up while simultaneously triggering Armored Warriors AI to start up an attack. This saves time over buffing outside, as normally you need to wait a moment for his AI to properly respond to you being there. Mikiri is used as a key part of the strategy because a Thrust attack can be baited out consistently every time with this approach.

There are 6 possible patterns that Armored Warrior, assuming that the Ako is used in the right spot.

Low Horizontal Swing Opener (Low Swing)
[youtube]BLwCjllSccQ[/youtube]

High Horizontal Swing Opener (High Swing)
[youtube]x26PGCo3vO0[/youtube]

Shove Opener
[youtube]2jzlJzo1k88[/youtube]

Overhead into High Swing Opener
[youtube]g31ny_JvpDE[/youtube]

Overhead into Low Swing Opener (no footage sorry :c)


Overhead into Shove Opener
[youtube]uaerk17R2yk[/youtube]


### 7-Hit Variation

A faster but riskier variation, where block hits (l1 into r1 on controller, or right click into left click on kbm) are used to squeeze in 7 hits instead of 6 during the Berserk start-up. By pressing block then attack Wolf will do a different attack animation. By doing the following it''s possible to squeeze in 7 as opposed to 6 hits after the mikiri: block, attack, attack, attack, attack, attack, block, attack, attack.

This variation has the downside that it can make Armored Warrior seemingly randomly cancel his Berserk and start doing regular attacks instead, which loses a large amount of time. It is not that rare for it to happen, so generally this 7-jhit variation is not consistent, but may be useful if the timesave is absolutely required.',1,2,'2026-02-25 15:44:14.075029');
INSERT INTO "wiki_revisions" VALUES(34,3,'Inside Ako (Mikiri) Armored Warrior','## Inside Ako (Mikiri) Armored Warrior

The inside Ako strategy involves using the Ako inside to buff up while simultaneously triggering Armored Warriors AI to start up an attack. This saves time over buffing outside, as normally you need to wait a moment for his AI to properly respond to you being there. Mikiri is used as a key part of the strategy because a Thrust attack can be baited out consistently every time with this approach.

There are 6 possible patterns that Armored Warrior, assuming that the Ako is used in the right spot.
![Image Description](https://cdn.discordapp.com/attachments/552479436872613894/1476242994972852234/roberto_ako_inside_mikiri_strat_flowchart.png?ex=69a069ed&is=699f186d&hm=973a6b8e72ecd38429c5991687d1c435f538120eceb59a6008f7507c0968b778&)

Low Horizontal Swing Opener (Low Swing)
[youtube]BLwCjllSccQ[/youtube]

High Horizontal Swing Opener (High Swing)
[youtube]x26PGCo3vO0[/youtube]

Shove Opener
[youtube]2jzlJzo1k88[/youtube]

Overhead into High Swing Opener
[youtube]g31ny_JvpDE[/youtube]

Overhead into Low Swing Opener (no footage sorry :c)


Overhead into Shove Opener
[youtube]uaerk17R2yk[/youtube]


### 7-Hit Variation

A faster but riskier variation, where block hits (l1 into r1 on controller, or right click into left click on kbm) are used to squeeze in 7 hits instead of 6 during the Berserk start-up. By pressing block then attack Wolf will do a different attack animation. By doing the following it''s possible to squeeze in 7 as opposed to 6 hits after the mikiri: block, attack, attack, attack, attack, attack, block, attack, attack.

This variation has the downside that it can make Armored Warrior seemingly randomly cancel his Berserk and start doing regular attacks instead, which loses a large amount of time. It is not that rare for it to happen, so generally this 7-jhit variation is not consistent, but may be useful if the timesave is absolutely required.',1,2,'2026-03-10 17:59:47.355095');
INSERT INTO "wiki_revisions" VALUES(35,2,'Practice Tools','Practice tools are used to practice more efficiently. Multiple different tools are available, all of which have different benefits.

Aside from Practice Tools, it is recommended that everyone use the [Save Organizer](https://riyu.pythonanywhere.com/wiki/1). The Save Organizer ends up being the most important tool, so make sure to get that up and running first.

- [SekiroTool by Shilkey & Lecentz](https://github.com/borgCode/SekiroTool/releases)
- [JohnDiSanDonato''s Practice Tool](https://github.com/veeenu/sekiro-practice-tool/releases)
- Cheat Engine
',1,2,'2026-03-10 19:48:23.935254');
INSERT INTO "wiki_revisions" VALUES(36,10,'LiveSplit','## LiveSplit
LiveSplit is a timer program for speedrunners that is both easy to use and full of features.

You can download the latest version of LiveSplit here. The downloaded file will have to be extracted and the folder placed somewhere you will remember.

Right clicking the LiveSplit window and going to settings allows you to edit various settings. it''s highly recommended to enable Global Hotkeys, as this allows you to split, reset, undo split and skip split while in-game. You can also change the keybinds while you''re here.


Note: The numpad buttons won''t work while shift is pressed. This is good to know if you play with keyboard and mouse and use shift to sprint, as you won''t be able to manual split/reset/undo/skip while holding shift. But that should be fine thought, since most players will use autosplitting.

## SoulSplitter
SoulSplitter is a LiveSplit plugin developed by Wasted that is designed to provide autosplitting and timekeeping across all the FromSoftware games available on PC. It is also the official leaderboard timer for Sekiro speedruns and includes various fixes that the community has agreed upon. Enabling it and using it is required for PC speedrun leaderboard submissions.

### How to Setup LiveSplit for Speedrunning (SoulSplitter Setup)
Read section above about LiveSplit and LiveSplit installation first.
1. Open LiveSplit, right-click it and select Edit Splits.
2. Find Sekiro in the Game Name Field.
![image](https://i.imgur.com/amQ9HMr.png)
3. Activate the integrated game time component.
![image](https://i.imgur.com/R1d3TTL.png)
4. Right-click LiveSplit and select Compare Against --> Game Time.
![image](https://i.imgur.com/J6yByQy.png)
5. Done!

## Autosplitting
With SoulSplitter activated in the Edit Splits menu, you can make custom autosplits. The autosplitter gives the user freedom to setup autosplit triggers for almost anything in the game, allowing you to customize them to how you see fit. Most beginners will want to download a pre-configured .lss split file that has everything already set up and running. Below is a section on where to download splits of other players.

### How to Create Autosplits
<to be added>

### What Makes a Good Autosplit?
Generally speaking, you should make a split where ever you feel like it. However, there are some considerations you should make to get the most out of LiveSplit. LiveSplit is supposed to enhance your progress as a player. It''s not supposed to be an obstacle you have to wrestle with.

* Consider splitting in the same places as others, so that you can compare with them more easily to better tell where you could save time. Below is a section that explains how to download the splits that other players use.
* Always test newly added autosplits before doing a run.
* Place autosplits at bottlenecks and be careful of autosplit points that can vary. An example is splitting on Gyoubu kill. If Gyoubu is killed close to where you need to go, then the next split will be shorter, and if he is killed far from where you need to go, then the next split will be longer. This is why most people choose to split on opening the gate after killing Gyoubu in glitchless, instead of splitting directly on kill. The door is a bottleneck that you have to go through (unless you''re doing [AP1 Bull](https://sekiro.ryufps.de/wiki/7)).
* Consider the precision of the autosplit you have made. The autosplitter itself is precise and accurate, but some in-game things aren''t. This is an extension of the point above, but applies more to how you choose to implement the split rather than where you place it. You can never have a precise split on Gyoubu kill, but it''s possible to have an imprecise autosplit on a spot that should otherwise be a good point to split at. Such as if you have a position split with a way too large size, or a size so small that you may run by it and miss it entirely. Test the autosplit to make sure it always triggers at the same point/time.

## Downloading Splits
Some premade .lss split files with autosplits can be downloaded here.

You can also use the website therun.gg to view and download the splits of other runners.

When you download someone else''s splits, it can be a good idea to go to Edit Splits --> Other and then Clear History and Clear Times. This will reset all the stats and times from the splits.

## Recording LiveSplit in Videos
The most popular program fro recording and livestreaming is Open Broadcaster Software (OBS). It allows adding multiple layers to your scene, where you would usually use a Game Capture for Sekiro with a Window Capture for LiveSplit put on top of it.

To make a Game Capture Source in OBS, press the + in the Sources box and choose Game Capture Source. Shown below:


Game Capture will only show the game, therefore we need to add a separate Source for LiveSplit itself',1,2,'2026-03-10 21:43:43.919316');
INSERT INTO "wiki_revisions" VALUES(37,10,'LiveSplit','## LiveSplit
LiveSplit is a timer program for speedrunners that is both easy to use and full of features.

You can download the latest version of LiveSplit [here](https://livesplit.org/). The downloaded file will have to be extracted and the folder placed somewhere you will remember.

Right clicking the LiveSplit window and going to settings allows you to edit various settings. it''s highly recommended to enable Global Hotkeys, as this allows you to split, reset, undo split and skip split while in-game. You can also change the keybinds while you''re here.
![image](https://i.imgur.com/RezD2Uy.png)

Note: The numpad buttons won''t work while shift is pressed. This is good to know if you play with keyboard and mouse and use shift to sprint, as you won''t be able to manual split/reset/undo/skip while holding shift. But that should be fine thought, since most players will use autosplitting.

## SoulSplitter
SoulSplitter is a LiveSplit plugin developed by [Wasted](https://sekiro.ryufps.de/wiki/5) that is designed to provide autosplitting and timekeeping across all the FromSoftware games available on PC. It is also the official leaderboard timer for Sekiro speedruns and includes various fixes that the community has agreed upon. Enabling it and using it is required for PC speedrun leaderboard submissions.

SoulSplitter''s included mods and fixes:
* Auto start and stop
* No intro movies mod
* IGT fix by B3LYP
* Cutscene blackscreen removal by Wasted
* Autosplitting by Wasted
* Event Flag logger and tracker by Wasted
* Improved tutorial pop-up removal by Wasted
* SteamID check bypass for save files by Uberhalit

**Note: Do not use other versions of these mods for leaderboard submissions. Only use them as provided automatically through LiveSplit**.

### How to Setup LiveSplit for Speedrunning (SoulSplitter Setup)
Read section above about LiveSplit and LiveSplit installation first.
1. Open LiveSplit, right-click it and select Edit Splits.
2. Find Sekiro in the Game Name Field.
![image](https://i.imgur.com/amQ9HMr.png)
3. Activate the integrated game time component.
![image](https://i.imgur.com/R1d3TTL.png)
4. Right-click LiveSplit and select Compare Against --> Game Time.
![image](https://i.imgur.com/J6yByQy.png)
5. Done!

## In-Game Time (IGT)
Sekiro has a built in timer, usually referred to as IGT (In-Game Time or In-Game Timer). However, the default behavior of it is not ideal. Its biggest problem is that there''s an issue with the way the time is incremented, which makes the timer count at a rate that is both slower than real time is supposed to run and hardware dependent in an unfair way.

The community has solved this on PC with the IGT Fix by B3LYP. The fixed version of IGT is usually referred to as modified In-Game Time, or mIGT for short. It has also been referred to as wIGT, or Wasted IGT, after Wasted took over maintaining and developing the Sekiro plugin, under the SoulSplitter project. Importantly, modified IGT is designed to run 1:1 with real time, assuming no game slowdowns due to lag or loading screens. Each second of actual gameplay equates to 1 second on the timer.

For the leaderboards, PC runs use modified IGT through LiveSplit, while console runs use the default IGT.

## Autosplitting
With SoulSplitter activated in the Edit Splits menu, you can make custom autosplits. The autosplitter gives the user freedom to setup autosplit triggers for almost anything in the game, allowing you to customize them to how you see fit. Most beginners will want to download a pre-configured .lss split file that has everything already set up and running. Below is a section on where to download splits of other players.

### How to Create Autosplits
to be added

### How to Find Event Flags (Event Flag Logger)
to be added

### What Makes a Good Autosplit?
Generally speaking, you should make a split where ever you feel like it. However, there are some considerations you should make to get the most out of LiveSplit. LiveSplit is supposed to enhance your progress as a player. It''s not supposed to be an obstacle you have to wrestle with.

* Consider splitting in the same places as others, so that you can compare with them more easily to better tell where you could save time. Below is a section that explains how to download the splits that other players use.
* Always test newly added autosplits before doing a run.
* Place autosplits at bottlenecks and be careful of autosplit points that can vary. An example is splitting on Gyoubu kill. If Gyoubu is killed close to where you need to go, then the next split will be shorter, and if he is killed far from where you need to go, then the next split will be longer. This is why most people choose to split on opening the gate after killing Gyoubu in glitchless, instead of splitting directly on kill. The door is a bottleneck that you have to go through (unless you''re doing [AP1 Bull](https://sekiro.ryufps.de/wiki/7)).
* Consider the precision of the autosplit you have made. The autosplitter itself is precise and accurate, but some in-game things aren''t. This is an extension of the point above, but applies more to how you choose to implement the split rather than where you place it. You can never have a precise split on Gyoubu kill, but it''s possible to have an imprecise autosplit on a spot that should otherwise be a good point to split at. Such as if you have a position split with a way too large size, or a size so small that you may run by it and miss it entirely. Test the autosplit to make sure it always triggers at the same point/time.

## Downloading Splits
Some premade .lss split files with autosplits can be downloaded [here](https://www.speedrun.com/sekiro/resources).

You can also use the website [therun.gg](https://therun.gg/games/Sekiro%3A%20Shadows%20Die%20Twice) to view and download the splits of other runners.

When you download someone else''s splits, it can be a good idea to go to Edit Splits --> Other and then Clear History and Clear Times. This will reset all the stats and times from the splits.

## Recording LiveSplit in Videos
The most popular program for recording and livestreaming is [Open Broadcaster Software (OBS)](https://obsproject.com/). It allows adding multiple layers to your scene, where you would usually use a Game Capture for Sekiro with a Window Capture for LiveSplit put on top of it.

To make a Game Capture Source in OBS:

1. Press the + in the Sources box and choose Game Capture Source. Shown below:
![image](https://www.speedrun.com/static/blob/rz2x1ke0.png)

Game Capture will only show the game, therefore we need to add a separate Source for LiveSplit itself. For capturing LiveSplit, we use a Window Capture Source.

2. Add the Window Capture in the same way you added the Game Capture in the step above (make sure that LiveSplit is open while doing this).

3. After naming it, the following window will appear. Select LiveSplit as the window.
![image](https://www.speedrun.com/static/blob/qzp2mle3.png)

3.5 I recommend setting the **"Window Match Priority"** to **"Match title, otherwise find window of same executable"**. This ensures that the Source will exclusively look for the LiveSplit window to capture.

4. Done!

### Making LiveSplit Transparent
The usual way that people make LiveSplit transparent is through a filter in OBS, which will only make it look transparent in the recording and NOT for you. Alternatively, you can use the Transparent LiveSplit fork, which makes LiveSplit''s own background transparent, instead of filtering it out in the recording.

Follow the tutorial below to make LiveSplit transparent in the recording (not needed if using the Transparent LiveSplit fork).
1. **You want to use a black background on LiveSplit. Do not use a color like green, blue or anything like that**, as this will mess with the other elements. Using the default black/dark grey background works as well.
![image](https://www.speedrun.com/static/blob/rz2x18e0.png)

The background color can be changed in layout settings.
![image](https://www.speedrun.com/static/blob/yzrrgjz4.png)

2. Right click the Window Capture you created for LiveSplit (mine is called Splits) and press Filters.
![image](https://www.speedrun.com/static/blob/5e1kpvn0.png)

3. Add a **Color Key** (not a Chroma Key). Set the type to Custom Colour and choose black. Then finally, adjust the Similarity slider until the background disappears. You will get the best looking result with a solid black LiveSplit background.
![image](https://www.speedrun.com/static/blob/xz0og0zl.png)

4. Done!

## Troubleshooting
If you have issues with the timer not automatically starting or not correctly showing the game time, triple check you are comparing against Game Time. Otherwise try restarting LiveSplit, running LiveSplit as Administrator or restarting your PC. If you need help feel free to ask in the #support channel on the [Sekiro Speedrunning Discord server](https://discord.gg/A7kWEPkKEq).

### LiveSplit Error: "The Auto Splitter could not be activated"
The most common cause of this error is that anti-virus will sometimes falsely flag SoulSplitter as an unwatend program and can quarantine the files without giving you a notification. [Here is the guide on how to create an anti-virus exclusion](https://soulsspeedruns.com/livesplit/#troubleshooting).

### LiveSplit Error: "Incomplete installation. Missing files"
Sometimes, the anti-virus fix isn''t enough. If you get an error about missing files, then you need to manually download the SoulSplitter component files from Github via the following steps:
1. Close LiveSplit.
2. Go to the [SoulSplitter Github downloads page](https://github.com/FrankvdStam/SoulSplitter/releases).
3. Download the .zip file from whatever is the latest release (do not download the ones named "source code").
4. Extract the .zip file.
5. Navigate to your LiveSplit components folder.
6. Drag the extracted files into the LiveSplit/components folder (replace files if asked).
7. Apply the anti-virus fix explained [here](https://soulsspeedruns.com/livesplit/#troubleshooting).
8. Done!

## Extra Tools for LiveSplit
to be added

## Credits
Thanks to XeroGoesFast for authoring the original LiveSplit guide.
Thanks to B3LYP for releasing the initial Sekiro timer plugin for LiveSplit.
Thanks to RefinedHornet for contributions to the old Sekiro timer.
Thanks to CapitaineToinon for contributions to the old Sekiro timer.
Thanks to Wasted for revolutionizing the Sekiro plugin with the SoulSplitter project.',1,2,'2026-03-10 21:47:14.675506');
INSERT INTO "wiki_revisions" VALUES(38,3,'Inside Ako (Mikiri) Armored Warrior','## Inside Ako (Mikiri) Armored Warrior

The inside Ako strategy involves using the Ako inside to buff up while simultaneously triggering Armored Warriors AI to start up an attack. This saves time over buffing outside, as normally you need to wait a moment for his AI to properly respond to you being there. Mikiri is used as a key part of the strategy because a Thrust attack can be baited out consistently every time with this approach.

There are 6 possible patterns that Armored Warrior, assuming that the Ako is used in the right spot.
![Image Description](https://cdn.discordapp.com/attachments/552479436872613894/1476242994972852234/roberto_ako_inside_mikiri_strat_flowchart.png?ex=69a069ed&is=699f186d&hm=973a6b8e72ecd38429c5991687d1c435f538120eceb59a6008f7507c0968b778&)

Low Horizontal Swing Opener (Low Swing)
[youtube]BLwCjllSccQ[/youtube]

High Horizontal Swing Opener (High Swing)
[youtube]x26PGCo3vO0[/youtube]

Shove Opener
[youtube]2jzlJzo1k88[/youtube]

Overhead into High Swing Opener
[youtube]g31ny_JvpDE[/youtube]

Overhead into Low Swing Opener (no footage sorry :c)


Overhead into Shove Opener
[youtube]uaerk17R2yk[/youtube]


### 7-Hit Variation

A faster but riskier variation, where block hits (l1 into r1 on controller, or right click into left click on kbm) are used to squeeze in 7 hits instead of 6 during the Berserk start-up. By pressing block then attack Wolf will do a different attack animation. By doing the following it''s possible to squeeze in 7 as opposed to 6 hits after the mikiri: block, attack, attack, attack, attack, attack, block, attack, attack.

This variation has the downside that it can make Armored Warrior seemingly randomly cancel his Berserk and start doing regular attacks instead, which loses a large amount of time. It is not that rare for it to happen, so generally this 7-jhit variation is not consistent, but may be useful if the timesave is absolutely required.',3,2,'2026-03-11 05:14:28.356424');
INSERT INTO "wiki_revisions" VALUES(39,10,'LiveSplit','## LiveSplit
LiveSplit is a timer program for speedrunners that is both easy to use and full of features.

You can download the latest version of LiveSplit [here](https://livesplit.org/). The downloaded file will have to be extracted and the folder placed somewhere you will remember.

Right clicking the LiveSplit window and going to settings allows you to edit various settings. it''s highly recommended to enable Global Hotkeys, as this allows you to split, reset, undo split and skip split while in-game. You can also change the keybinds while you''re here.
![image](https://i.imgur.com/RezD2Uy.png)

Note: The numpad buttons won''t work while shift is pressed. This is good to know if you play with keyboard and mouse and use shift to sprint, as you won''t be able to manual split/reset/undo/skip while holding shift. But that should be fine thought, since most players will use autosplitting.

## SoulSplitter
SoulSplitter is a LiveSplit plugin developed by [Wasted](https://sekiro.ryufps.de/wiki/5) that is designed to provide autosplitting and timekeeping across all the FromSoftware games available on PC. It is also the official leaderboard timer for Sekiro speedruns and includes various fixes that the community has agreed upon. Enabling it and using it is required for PC speedrun leaderboard submissions.

SoulSplitter''s included mods and fixes:
* Auto start and stop

* No intro movies mod

* IGT fix by B3LYP

* Cutscene blackscreen removal by Wasted

* Autosplitting by Wasted

* Event Flag logger and tracker by Wasted

* Improved tutorial pop-up removal by Wasted

* SteamID check bypass for save files by Uberhalit

**Note: Do not use other versions of these mods for leaderboard submissions. Only use them as provided automatically through LiveSplit**.

### How to Setup LiveSplit for Speedrunning (SoulSplitter Setup)
Read section above about LiveSplit and LiveSplit installation first.
1. Open LiveSplit, right-click it and select Edit Splits.
2. Find Sekiro in the Game Name Field.
![image](https://i.imgur.com/amQ9HMr.png)
3. Activate the integrated game time component.
![image](https://i.imgur.com/R1d3TTL.png)
4. Right-click LiveSplit and select Compare Against --> Game Time.
![image](https://i.imgur.com/J6yByQy.png)
5. Done!

## In-Game Time (IGT)
Sekiro has a built in timer, usually referred to as IGT (In-Game Time or In-Game Timer). However, the default behavior of it is not ideal. Its biggest problem is that there''s an issue with the way the time is incremented, which makes the timer count at a rate that is both slower than real time is supposed to run and hardware dependent in an unfair way.

The community has solved this on PC with the IGT Fix by B3LYP. The fixed version of IGT is usually referred to as modified In-Game Time, or mIGT for short. It has also been referred to as wIGT, or Wasted IGT, after Wasted took over maintaining and developing the Sekiro plugin, under the SoulSplitter project. Importantly, modified IGT is designed to run 1:1 with real time, assuming no game slowdowns due to lag or loading screens. Each second of actual gameplay equates to 1 second on the timer.

For the leaderboards, PC runs use modified IGT through LiveSplit, while console runs use the default IGT.

## Autosplitting
With SoulSplitter activated in the Edit Splits menu, you can make custom autosplits. The autosplitter gives the user freedom to setup autosplit triggers for almost anything in the game, allowing you to customize them to how you see fit. Most beginners will want to download a pre-configured .lss split file that has everything already set up and running. Below is a section on where to download splits of other players.

### How to Create Autosplits
to be added

### How to Find Event Flags (Event Flag Logger)
to be added

### What Makes a Good Autosplit?
Generally speaking, you should make a split where ever you feel like it. However, there are some considerations you should make to get the most out of LiveSplit. LiveSplit is supposed to enhance your progress as a player. It''s not supposed to be an obstacle you have to wrestle with.

* Consider splitting in the same places as others, so that you can compare with them more easily to better tell where you could save time. Below is a section that explains how to download the splits that other players use.
* Always test newly added autosplits before doing a run.
* Place autosplits at bottlenecks and be careful of autosplit points that can vary. An example is splitting on Gyoubu kill. If Gyoubu is killed close to where you need to go, then the next split will be shorter, and if he is killed far from where you need to go, then the next split will be longer. This is why most people choose to split on opening the gate after killing Gyoubu in glitchless, instead of splitting directly on kill. The door is a bottleneck that you have to go through (unless you''re doing [AP1 Bull](https://sekiro.ryufps.de/wiki/7)).
* Consider the precision of the autosplit you have made. The autosplitter itself is precise and accurate, but some in-game things aren''t. This is an extension of the point above, but applies more to how you choose to implement the split rather than where you place it. You can never have a precise split on Gyoubu kill, but it''s possible to have an imprecise autosplit on a spot that should otherwise be a good point to split at. Such as if you have a position split with a way too large size, or a size so small that you may run by it and miss it entirely. Test the autosplit to make sure it always triggers at the same point/time.

## Downloading Splits
Some premade .lss split files with autosplits can be downloaded [here](https://www.speedrun.com/sekiro/resources).

You can also use the website [therun.gg](https://therun.gg/games/Sekiro%3A%20Shadows%20Die%20Twice) to view and download the splits of other runners.

When you download someone else''s splits, it can be a good idea to go to Edit Splits --> Other and then Clear History and Clear Times. This will reset all the stats and times from the splits.

## Recording LiveSplit in Videos
The most popular program for recording and livestreaming is [Open Broadcaster Software (OBS)](https://obsproject.com/). It allows adding multiple layers to your scene, where you would usually use a Game Capture for Sekiro with a Window Capture for LiveSplit put on top of it.

To make a Game Capture Source in OBS:

1. Press the + in the Sources box and choose Game Capture Source. Shown below:
![image](https://www.speedrun.com/static/blob/rz2x1ke0.png)

Game Capture will only show the game, therefore we need to add a separate Source for LiveSplit itself. For capturing LiveSplit, we use a Window Capture Source.

2. Add the Window Capture in the same way you added the Game Capture in the step above (make sure that LiveSplit is open while doing this).

3. After naming it, the following window will appear. Select LiveSplit as the window.
![image](https://www.speedrun.com/static/blob/qzp2mle3.png)

I recommend setting the **"Window Match Priority"** to **"Match title, otherwise find window of same executable"**. This ensures that the Source will exclusively look for the LiveSplit window to capture.

4. Done!

### Making LiveSplit Transparent
The usual way that people make LiveSplit transparent is through a filter in OBS, which will only make it look transparent in the recording and NOT for you. Alternatively, you can use the Transparent LiveSplit fork, which makes LiveSplit''s own background transparent, instead of filtering it out in the recording.

Follow the tutorial below to make LiveSplit transparent in the recording (not needed if using the Transparent LiveSplit fork).
1. **You want to use a black background on LiveSplit. Do not use a color like green, blue or anything like that**, as this will mess with the other elements. Using the default black/dark grey background works as well.
![image](https://www.speedrun.com/static/blob/rz2x18e0.png)

The background color can be changed in layout settings.
![image](https://www.speedrun.com/static/blob/yzrrgjz4.png)

2. Right click the Window Capture you created for LiveSplit (mine is called Splits) and press Filters.
![image](https://www.speedrun.com/static/blob/5e1kpvn0.png)

3. Add a **Color Key** (not a Chroma Key). Set the type to Custom Colour and choose black. Then finally, adjust the Similarity slider until the background disappears. You will get the best looking result with a solid black LiveSplit background.
![image](https://www.speedrun.com/static/blob/xz0og0zl.png)

4. Done!

## Troubleshooting
If you have issues with the timer not automatically starting or not correctly showing the game time, triple check you are comparing against Game Time. Otherwise try restarting LiveSplit, running LiveSplit as Administrator or restarting your PC. If you need help feel free to ask in the #support channel on the [Sekiro Speedrunning Discord server](https://discord.gg/A7kWEPkKEq).

### LiveSplit Error: "The Auto Splitter could not be activated"
The most common cause of this error is that anti-virus will sometimes falsely flag SoulSplitter as an unwatend program and can quarantine the files without giving you a notification. [Here is the guide on how to create an anti-virus exclusion](https://soulsspeedruns.com/livesplit/#troubleshooting).

### LiveSplit Error: "Incomplete installation. Missing files"
Sometimes, the anti-virus fix isn''t enough. If you get an error about missing files, then you need to manually download the SoulSplitter component files from Github via the following steps:
1. Close LiveSplit.
2. Go to the [SoulSplitter Github downloads page](https://github.com/FrankvdStam/SoulSplitter/releases).
3. Download the .zip file from whatever is the latest release (do not download the ones named "source code").
4. Extract the .zip file.
5. Navigate to your LiveSplit components folder.
6. Drag the extracted files into the LiveSplit/components folder (replace files if asked).
7. Apply the anti-virus fix explained [here](https://soulsspeedruns.com/livesplit/#troubleshooting).
8. Done!

## Extra Tools for LiveSplit
to be added

## Credits
Thanks to XeroGoesFast for authoring the original LiveSplit guide.
Thanks to B3LYP for releasing the initial Sekiro timer plugin for LiveSplit.
Thanks to RefinedHornet for contributions to the old Sekiro timer.
Thanks to CapitaineToinon for contributions to the old Sekiro timer.
Thanks to Wasted for revolutionizing the Sekiro plugin with the SoulSplitter project.',1,2,'2026-03-11 05:20:54.399837');
INSERT INTO "wiki_revisions" VALUES(40,10,'LiveSplit','## LiveSplit
LiveSplit is a timer program for speedrunners that is both easy to use and full of features.

You can download the latest version of LiveSplit [here](https://livesplit.org/). The downloaded file will have to be extracted and the folder placed somewhere you will remember.

Right clicking the LiveSplit window and going to settings allows you to edit various settings. it''s highly recommended to enable Global Hotkeys, as this allows you to split, reset, undo split and skip split while in-game. You can also change the keybinds while you''re here.
![image](https://i.imgur.com/RezD2Uy.png)

Note: The numpad buttons won''t work while shift is pressed. This is good to know if you play with keyboard and mouse and use shift to sprint, as you won''t be able to manual split/reset/undo/skip while holding shift. But that should be fine thought, since most players will use autosplitting.

## SoulSplitter
SoulSplitter is a LiveSplit plugin developed by [Wasted](https://sekiro.ryufps.de/wiki/5) that is designed to provide autosplitting and timekeeping across all the FromSoftware games available on PC. It is also the official leaderboard timer for Sekiro speedruns and includes various fixes that the community has agreed upon. Enabling it and using it is required for PC speedrun leaderboard submissions.

SoulSplitter''s included mods and fixes:
* Auto start and stop

* No intro movies mod

* IGT fix by B3LYP

* Cutscene blackscreen removal by Wasted

* Autosplitting by Wasted

* Event Flag logger and tracker by Wasted

* Improved tutorial pop-up removal by Wasted

* SteamID check bypass for save files by Uberhalit

**Note: Do not use other versions of these mods for leaderboard submissions. Only use them as provided automatically through LiveSplit**.

### How to Setup LiveSplit for Speedrunning (SoulSplitter Setup)
Read section above about LiveSplit and LiveSplit installation first.
1. Open LiveSplit, right-click it and select Edit Splits.
2. Find Sekiro in the Game Name Field.
![image](https://i.imgur.com/amQ9HMr.png)
3. Activate the integrated game time component.
![image](https://i.imgur.com/R1d3TTL.png)
4. Right-click LiveSplit and select Compare Against --> Game Time.
![image](https://i.imgur.com/J6yByQy.png)
5. Done!

## In-Game Time (IGT)
Sekiro has a built in timer, usually referred to as IGT (In-Game Time or In-Game Timer). However, the default behavior of it is not ideal. Its biggest problem is that there''s an issue with the way the time is incremented, which makes the timer count at a rate that is both slower than real time is supposed to run and hardware dependent in an unfair way.

The community has solved this on PC with the IGT Fix by B3LYP. The fixed version of IGT is usually referred to as modified In-Game Time, or mIGT for short. It has also been referred to as wIGT, or Wasted IGT, after Wasted took over maintaining and developing the Sekiro plugin, under the SoulSplitter project. Importantly, modified IGT is designed to run 1:1 with real time, assuming no game slowdowns due to lag or loading screens. Each second of actual gameplay equates to 1 second on the timer.

For the leaderboards, PC runs use modified IGT through LiveSplit, while console runs use the default IGT.

## Autosplitting
With SoulSplitter activated in the Edit Splits menu, you can make custom autosplits. The autosplitter gives the user freedom to setup autosplit triggers for almost anything in the game, allowing you to customize them to how you see fit. Most beginners will want to download a pre-configured .lss split file that has everything already set up and running. Below is a section on where to download splits of other players.

### How to Create Autosplits
to be added

### How to Find Event Flags (Event Flag Logger)
to be added

### What Makes a Good Autosplit?
Generally speaking, you should make a split where ever you feel like it. However, there are some considerations you should make to get the most out of LiveSplit. LiveSplit is supposed to enhance your progress as a player. It''s not supposed to be an obstacle you have to wrestle with.

* Consider splitting in the same places as others, so that you can compare with them more easily to better tell where you could save time. Below is a section that explains how to download the splits that other players use.
* Always test newly added autosplits before doing a run.
* Place autosplits at bottlenecks and be careful of autosplit points that can vary. An example is splitting on Gyoubu kill. If Gyoubu is killed close to where you need to go, then the next split will be shorter, and if he is killed far from where you need to go, then the next split will be longer. This is why most people choose to split on opening the gate after killing Gyoubu in glitchless, instead of splitting directly on kill. The door is a bottleneck that you have to go through (unless you''re doing [AP1 Bull](https://sekiro.ryufps.de/wiki/7)).
* Consider the precision of the autosplit you have made. The autosplitter itself is precise and accurate, but some in-game things aren''t. This is an extension of the point above, but applies more to how you choose to implement the split rather than where you place it. You can never have a precise split on Gyoubu kill, but it''s possible to have an imprecise autosplit on a spot that should otherwise be a good point to split at. Such as if you have a position split with a way too large size, or a size so small that you may run by it and miss it entirely. Test the autosplit to make sure it always triggers at the same point/time.

## Downloading Splits
Some premade .lss split files with autosplits can be downloaded [here](https://www.speedrun.com/sekiro/resources).

You can also use the website [therun.gg](https://therun.gg/games/Sekiro%3A%20Shadows%20Die%20Twice) to view and download the splits of other runners.

When you download someone else''s splits, it can be a good idea to go to Edit Splits --> Other and then Clear History and Clear Times. This will reset all the stats and times from the splits.

## Recording LiveSplit in Videos
The most popular program for recording and livestreaming is [Open Broadcaster Software (OBS)](https://obsproject.com/). It allows adding multiple layers to your scene, where you would usually use a Game Capture for Sekiro with a Window Capture for LiveSplit put on top of it.

To make a Game Capture Source in OBS:

1. Press the + in the Sources box and choose Game Capture Source. Shown below:
![image](https://www.speedrun.com/static/blob/rz2x1ke0.png)

Game Capture will only show the game, therefore we need to add a separate Source for LiveSplit itself. For capturing LiveSplit, we use a Window Capture Source.

2. Add the Window Capture in the same way you added the Game Capture in the step above (make sure that LiveSplit is open while doing this).

3. After naming it, the following window will appear. Select LiveSplit as the window.
![image](https://www.speedrun.com/static/blob/qzp2mle3.png)

I recommend setting the **"Window Match Priority"** to **"Match title, otherwise find window of same executable"**. This ensures that the Source will exclusively look for the LiveSplit window to capture.

4. Done!

### Making LiveSplit Transparent
The usual way that people make LiveSplit transparent is through a filter in OBS, which will only make it look transparent in the recording and NOT for you. Alternatively, you can use the Transparent LiveSplit fork, which makes LiveSplit''s own background transparent, instead of filtering it out in the recording.

Follow the tutorial below to make LiveSplit transparent in the recording (not needed if using the Transparent LiveSplit fork).
1. **You want to use a black background on LiveSplit. Do not use a color like green, blue or anything like that**, as this will mess with the other elements. Using the default black/dark grey background works as well.
![image](https://www.speedrun.com/static/blob/rz2x18e0.png)

The background color can be changed in layout settings.
![image](https://www.speedrun.com/static/blob/yzrrgjz4.png)

2. Right click the Window Capture you created for LiveSplit (mine is called Splits) and press Filters.
![image](https://www.speedrun.com/static/blob/5e1kpvn0.png)

3. Add a **Color Key** (not a Chroma Key). Set the type to Custom Colour and choose black. Then finally, adjust the Similarity slider until the background disappears. You will get the best looking result with a solid black LiveSplit background.
![image](https://www.speedrun.com/static/blob/xz0og0zl.png)

4. Done!

## Troubleshooting
If you have issues with the timer not automatically starting or not correctly showing the game time, triple check you are comparing against Game Time. Otherwise try restarting LiveSplit, running LiveSplit as Administrator or restarting your PC. If you need help feel free to ask in the #support channel on the [Sekiro Speedrunning Discord server](https://discord.gg/A7kWEPkKEq).

### LiveSplit Error: "The Auto Splitter could not be activated"
The most common cause of this error is that anti-virus will sometimes falsely flag SoulSplitter as an unwatend program and can quarantine the files without giving you a notification. [Here is the guide on how to create an anti-virus exclusion](https://soulsspeedruns.com/livesplit/#troubleshooting).

### LiveSplit Error: "Incomplete installation. Missing files"
Sometimes, the anti-virus fix isn''t enough. If you get an error about missing files, then you need to manually download the SoulSplitter component files from Github via the following steps:
1. Close LiveSplit.
2. Go to the [SoulSplitter Github downloads page](https://github.com/FrankvdStam/SoulSplitter/releases).
3. Download the .zip file from whatever is the latest release (do not download the ones named "source code").
4. Extract the .zip file.
5. Navigate to your LiveSplit components folder.
6. Drag the extracted files into the LiveSplit/components folder (replace files if asked).
7. Apply the anti-virus fix explained [here](https://soulsspeedruns.com/livesplit/#troubleshooting).
8. Done!

## Extra Tools for LiveSplit
to be added

## Credits
Thanks to XeroGoesFast for authoring the original LiveSplit guide.
Thanks to B3LYP for releasing the initial Sekiro timer plugin for LiveSplit.
Thanks to RefinedHornet for contributions to the old Sekiro timer.
Thanks to CapitaineToinon for contributions to the old Sekiro timer.
Thanks to Wasted for revolutionizing the Sekiro plugin with the SoulSplitter project.',1,2,'2026-03-11 05:45:01.361102');
INSERT INTO "wiki_revisions" VALUES(41,14,'Tutorial Window Jump','## Tutorial Window Jump
Tutorial Window Jump is a jump that lets you exit the Moonview Tower in the tutorial/intro section around 0.5s faster than usual.

Video Tutorial:
[youtube]https://www.youtube.com/watch?v=T9fcivlGr78[/youtube]

This is used in Glitchless. However, for categories allowing glitches, Tutorial Grapple Glitch is a significantly easier alternative for getting out of the Moonview Tower fast.
',3,2,'2026-03-11 19:11:04.208166');
INSERT INTO "wiki_revisions" VALUES(42,14,'Tutorial Window Jump','## Tutorial Window Jump
Tutorial Window Jump is a jump that lets you exit the Moonview Tower in the tutorial/intro section around 0.5s faster than usual.

Video Tutorial:
[youtube]T9fcivlGr78[/youtube]

This is used in Glitchless. However, for categories allowing glitches, Tutorial Grapple Glitch is a significantly easier alternative for getting out of the Moonview Tower fast.

## History
Discovered by Pennek',3,2,'2026-03-12 05:28:10.819388');
INSERT INTO "wiki_revisions" VALUES(43,11,'Delayed Jump','## Delayed Jump
A Delayed Jump is a jump done at the very last moment possible when going off a ledge, in a way that makes you do the jump after having already fallen off the ledge. This type of jump allows the player to gain more distance than a standard jump.

It''s possible to both do a sprinting and a walking speed delayed jump, but usually delayed jump refers to the sprinting variation.

A common misconception is that all delayed jumps have a frame perfect timing window. In reality, each type of ledge will have a different timing and different window of opportunity for a success jump.

## Ledges and Terrain',4,2,'2026-03-14 08:16:30.445558');
INSERT INTO "wiki_revisions" VALUES(44,19,'Gourd Seed','## Gourd Seed

A Gourd Seed is a Key Item that can be given to Emma to upgrade the Healing Gourd. Each Gourd Seed given increases the Healing Gourds number of uses by 1, up to a maximum of 10.

## Acquisition

There are 9 Gourd Seeds in the game. Each one can only be acquired once, so in order to get all 9 and upgrade the Healing Gourd to its maximum of 10 uses, each of them need to be found. On New Game+, if a Gourd Seed has already been acquired, it will be replaced with a different item.

1. In Ashina Outskirts, dropped by General Naomori Kawarada. When Invasion 2 is triggered, if Kawarada was not defeated, he will disappear and his Gourd Seed will become purchasable for 2400 Sen from the Offering Box at Dilapidated Temple.

2. In Ashina Outskirts, after Chained Ogre, in the building above, on the left, the item pick-up will be by two soldier uniforms hanging on a wall.

3. In Ashina Outskirts, after Gyoubu, 1 Gourd Seed can be purchased for 1000 Sen from the Battlefield Memorial Mob.

4. In Ashina Castle, in a chest by the Castle Antechamber Idol.

5. At Dilapidated Temple, after Genichiro is defeated, Fujioka the Info Broker will appear and sell 1 Gourd Seed for 2000 Sen.

6. In Senpou Temple, after the cricket room, the item pick-up will be in front of an immortal monk.

7. In Sunken Valley, after the Serpent''s Shrine, on the way towards Gunfort, take a sidepath on the left. Continue and climb up, the item pick-up will be in a corner in a wall cavity.

8. In Ashina Depths, Mibu Village, the item pick-up will be in the middle at the base of a large lit up tree.

9. In Fountainhead Palace, in a chest near the Palace Grounds Idol.

## Gourd Seed Duplication

It is possible to gain infinite Gourd Seeds by exploiting a glitch with the Reflections of Strength. The Offering Box, where normally up to 1 Gourd Seed can be bought from, exists during Reflections and Gauntlets. In this state, the Offering Box doesn''t have the flags for disabling items that have already been acquired or purchased, letting you purchase all of the items that it can possible sell, even if they have already been acquired.

By entering Demon of Hatred or Sword Saint Reflection, which take place during the Invasion 2 world state, and navigating to Dilapidated Temple, you are able to purchase 1 Gourd Seed from the Offering Box for 2400 Sen. When you exit the Reflection, the Sen will be refunded, but the Gourd Seed will stay in your inventory. Note: it is not possible to upgrade the Healing Gourd above the intended 10 maximum uses.',4,2,'2026-07-15 12:32:09.684254');
INSERT INTO "wiki_revisions" VALUES(45,8,'Bull Skip','## Bull Skip
Bull Skip is a skip that let''s you bypass having to fight Blazing Bull.

Video Tutorial:
[youtube]lAKV66fW4A0[/youtube]

## Patch
**The version of the skip shown above works on all versions of the game.** However, on <date> Fromsoft release patch version 1.03, which fixed the at the time only known way of performing Bull Skip, a way which has since been dubbed right-side Bull Skip.
Video of the right-side version that was patched:
[youtube]BxQvA3Kqh7M[/youtube]

The right side version is useless though, as the left-side version that works on all versions is faster than the right side version anyway.

## History
Bull Skip was discovered on March 28th, 2019, less than a week after release, by MrBundarian.',3,2,'2026-07-15 12:39:03.748400');
INSERT INTO "wiki_revisions" VALUES(46,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Pick the .zip that corresponds to your operating system. The bundled windows version can be used if the regular windows version does not work.

### Import, Load & Replace

Import, load and replace are the main functions of the Save Organizer that you use. Knowing how they work are important to using the program effectively.

Importing means taking your current active save file and storing it in the Organizer.

Loading means replacing your current active save file with whichever save you loaded. Loading a save from the Organizer works like a save state, where each time you load that save, you will be put at the exact state that save was in when it was imported.

Replacing is like importing, but it works for overwriting save files that you want to make changes to. Note that this button will permanently delete the replaced save file, so make sure you think before you click it if any important save files are being used.


### Additional Tips

- It''s important to know that one save file contains ALL your save data, all your saved games and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file into the Save Organizer before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- Save files can only be loaded while you are on the title screen. You cannot load a save while you are on the main menu. However, if you are fast, you can press continue and then tab out of the game and load a save before you get to the main menu.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.
- It''s recommended to create multiple Profiles to sort your save files. One Profile per speedrun category is a good starting point.

### Downloading Save Files
If you want to download and use a save file from another player, you need to do the following steps: (Make sure to backup your own save file first, as this process will completely overwrite your save data).

1. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated. It includes a mod that allows you to load save files tied to other Steam accounts. Simply having LiveSplit and Sekiro open will make the mod take effect.

2. Download the save file(s), usually you will get a zip file that can be extracted out to a folder.

3. Move the downloaded save file into the folder where you keep your Save Organizer save files. If you downloaded a folder full of saves, you can also put that folder there. Each folder under the main one will form a Profile in the Save Organizer.

4. If you moved the files to the right place, they should appear in your Save Organizer after restarting it.

5. Launch the game and get to the title screen. (not the main menu).

6. Load a save file, change the settings to your taste on the main menu then replace the save.

7. Get back to the title screen by any means necessary and repeat step 6 until all save files have been updated.
',1,1,'2026-07-19 00:38:06.245066');
INSERT INTO "wiki_revisions" VALUES(47,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Pick the .zip that corresponds to your operating system. The bundled windows version can be used if the regular windows version does not work.

### Import, Load & Replace

Import, load and replace are the main functions of the Save Organizer that you use. Knowing how they work are important to using the program effectively.

Importing means taking your current active save file and storing it in the Organizer.

Loading means replacing your current active save file with whichever save you loaded. Loading a save from the Organizer works like a save state, where each time you load that save, you will be put at the exact state that save was in when it was imported.

Replacing is like importing, but it works for overwriting save files that you want to make changes to. Note that this button will permanently delete the replaced save file, so make sure you think before you click it if any important save files are being used.


### Additional Tips

- It''s important to know that one save file contains ALL your save data, all your saved games and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file into the Save Organizer before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- Save files can only be loaded while you are on the title screen. You cannot load a save while you are on the main menu. However, if you are fast, you can press continue and then tab out of the game and load a save before you get to the main menu.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.
- It''s recommended to create multiple Profiles to sort your save files. One Profile per speedrun category is a good starting point.

### Downloading Save Files
If you want to download and use a save file from another player, you need to do the following steps: (Make sure to backup your own save file first, as this process will completely overwrite your save data).

1. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated. It includes a mod that allows you to load save files tied to other Steam accounts. Simply having LiveSplit and Sekiro open will make the mod take effect.

2. Download the save file(s), usually you will get a zip file that can be extracted out to a folder.

3. Move the downloaded save file into the folder where you keep your Save Organizer save files. If you downloaded a folder full of saves, you can also put that folder there. Each folder under the main one will form a Profile in the Save Organizer.

4. If you moved the files to the right place, they should appear in your Save Organizer after restarting it.

5. Launch the game and get to the title screen. (not the main menu).

6. Load a save file, change the settings to your taste on the main menu then replace the save.

7. Get back to the title screen by any means necessary and repeat step 6 until all save files have been updated.
a
',1,1,'2026-07-19 00:38:36.125929');
INSERT INTO "wiki_revisions" VALUES(48,2,'Practice Tools','## Practice Tools
Practice tools are used to practice more efficiently. Multiple different tools are available, all of which have different benefits.

Aside from Practice Tools, it is recommended that everyone use the [Save Organizer](https://riyu.pythonanywhere.com/wiki/1). The Save Organizer ends up being the most important tool, so make sure to get that up and running first.

- [SekiroTool by Shilkey & Lecentz](https://github.com/borgCode/SekiroTool/releases)
- [JohnDiSanDonato''s Practice Tool](https://github.com/veeenu/sekiro-practice-tool/releases)
- [Cheat Engine](https://sekiro.ryufps.de/wiki/4)

## Support
Practice tools are made by volunteers from the community and thus may have bugs. Some of the practice tool developers may not be updating their tools anymore. For help and questions it is best to ask in the #support channel on the [Sekiro Speedrunning Discord server](https://discord.gg/A7kWEPkKEq).

## Online Ban
Sekiro does not have a real online mode, therefore you cannot get banned. However, if you use the Sekiro Online mod with cheats from any of the Practice Tools, you will most likely get banned.',1,1,'2026-07-19 00:42:46.583700');
INSERT INTO "wiki_revisions" VALUES(49,2,'Practice Tools','## Practice Tools
Practice tools are used to practice more efficiently. Multiple different tools are available, all of which have different benefits.

Aside from Practice Tools, it is recommended that everyone use the [Save Organizer](https://riyu.pythonanywhere.com/wiki/1). The Save Organizer ends up being the most important tool, so make sure to get that up and running first.

- [SekiroTool by Shilkey & Lecentz](https://github.com/borgCode/SekiroTool/releases)
- [JohnDiSanDonato''s Practice Tool](https://github.com/veeenu/sekiro-practice-tool/releases)
- [Cheat Engine](https://sekirospeedrun.com/wiki/4)

## Support
Practice tools are made by volunteers from the community and thus may have bugs. Some of the practice tool developers may not be updating their tools anymore. For help and questions it is best to ask in the #support channel on the [Sekiro Speedrunning Discord server](https://discord.gg/A7kWEPkKEq).

## Online Ban
Sekiro does not have a real online mode, therefore you cannot get banned. However, if you use the Sekiro Online mod with cheats from any of the Practice Tools, you will most likely get banned.',1,1,'2026-07-19 00:44:18.934449');
INSERT INTO "wiki_revisions" VALUES(50,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Pick the .zip that corresponds to your operating system. The bundled windows version can be used if the regular windows version does not work.

### Import, Load & Replace

Import, load and replace are the main functions of the Save Organizer that you use. Knowing how they work are important to using the program effectively.

Importing means taking your current active save file and storing it in the Organizer.

Loading means replacing your current active save file with whichever save you loaded. Loading a save from the Organizer works like a save state, where each time you load that save, you will be put at the exact state that save was in when it was imported.

Replacing is like importing, but it works for overwriting save files that you want to make changes to. Note that this button will permanently delete the replaced save file, so make sure you think before you click it if any important save files are being used.


### Additional Tips

- It''s important to know that one save file contains ALL your save data, all your saved games and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file into the Save Organizer before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- Save files can only be loaded while you are on the title screen. You cannot load a save while you are on the main menu. However, if you are fast, you can press continue and then tab out of the game and load a save before you get to the main menu.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.
- It''s recommended to create multiple Profiles to sort your save files. One Profile per speedrun category is a good starting point.

### Downloading Save Files
If you want to download and use a save file from another player, you need to do the following steps: (Make sure to backup your own save file first, as this process will completely overwrite your save data).

1. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated. It includes a mod that allows you to load save files tied to other Steam accounts. Simply having LiveSplit and Sekiro open will make the mod take effect.

2. Download the save file(s), usually you will get a zip file that can be extracted out to a folder.

3. Move the downloaded save file into the folder where you keep your Save Organizer save files. If you downloaded a folder full of saves, you can also put that folder there. Each folder under the main one will form a Profile in the Save Organizer.

4. If you moved the files to the right place, they should appear in your Save Organizer after restarting it.

5. Launch the game and get to the title screen. (not the main menu).

6. Load a save file, change the settings to your taste on the main menu then replace the save.

7. Get back to the title screen by any means necessary and repeat step 6 until all save files have been updated.

',1,1,'2026-07-19 00:55:30.334834');
INSERT INTO "wiki_revisions" VALUES(51,1,'Save File Organizer','# Save File Organizer by Kahmul

The Save Organizer by Kahmul is the primary tool for creating save files, also sometimes called save states.

### Usage tutorial:
[youtube]-m1PwqIZLyo[/youtube]

Download Kahmul''s Save Organizer [here](https://github.com/Kahmul/SoulsSpeedruns-Save-Organizer/releases).

Pick the .zip that corresponds to your operating system. The bundled windows version can be used if the regular windows version does not work.

### Import, Load & Replace

Import, load and replace are the main functions of the Save Organizer that you use. Knowing how they work are important to using the program effectively.

Importing means taking your current active save file and storing it in the Organizer.

Loading means replacing your current active save file with whichever save you loaded. Loading a save from the Organizer works like a save state, where each time you load that save, you will be put at the exact state that save was in when it was imported.

Replacing is like importing, but it works for overwriting save files that you want to make changes to. Note that this button will permanently delete the replaced save file, so make sure you think before you click it if any important save files are being used.


### Additional Tips

- It''s important to know that one save file contains ALL your save data, all your saved games and settings. It is not currently possible to import a saved game from one save file onto another. You should import your own main save file into the Save Organizer before starting to play around with save files, in order to make sure that it''s saved. It is also recommended to make a copy of that file and store it somewhere safe.
- When trying to import your save into the save organizer, you generally need to quit out before pressing import to make sure it has successfully saved your progress first.
- When quitting out to make a save, make sure you are on stable ground and not in combat. Otherwise, your position won''t be saved as you intend.
- Save files can only be loaded while you are on the title screen. You cannot load a save while you are on the main menu. However, if you are fast, you can press continue and then tab out of the game and load a save before you get to the main menu.
- It''s recommended to add numbers to the names of the saves, so that your list will have the same order as it will be in the run. e.g, 01. Ogre, 02. Canyon, 03. Gyoubu, etc.
- It''s recommended to create multiple Profiles to sort your save files. One Profile per speedrun category is a good starting point.

### Downloading Save Files
If you want to download and use a save file from another player, you need to do the following steps: (Make sure to backup your own save file first, as this process will completely overwrite your save data).

1. Download and setup LiveSplit with the Sekiro plugin "SoulSplitter" activated. It includes a mod that allows you to load save files tied to other Steam accounts. Simply having LiveSplit and Sekiro open will make the mod take effect.

2. Download the save file(s), usually you will get a zip file that can be extracted out to a folder.

3. Move the downloaded save file into the folder where you keep your Save Organizer save files. If you downloaded a folder full of saves, you can also put that folder there. Each folder under the main one will form a Profile in the Save Organizer.

4. If you moved the files to the right place, they should appear in your Save Organizer after restarting it.

5. Launch the game and get to the title screen. (not the main menu).

6. Load a save file, change the settings to your taste on the main menu then replace the save.

7. Get back to the title screen by any means necessary and repeat step 6 until all save files have been updated.

# WIKI LINK TEST
[Attack Power 1 Bull](/wiki/attack-power-1-bull)
',1,1,'2026-07-19 00:56:45.588960');
INSERT INTO "wiki_revisions" VALUES(52,6,'Gyoubu Skip','## Gyoubu Skip
Gyoubu Skip, also known as Horse Skip, is a skip with multiple variations that involves circumventing needing to fight Gyoubu Oniwa.

## Tower Jump Variation

Using a delayed jump the top of the tower near the Ashina Castle Gate, you can reach the top of the wall with a ledgegrab.

## Mist Raven Variation

Using Mist Raven together with Contact Medicine let''s you do On-Demand Mist Raven, which can give an upwards teleport if used while standing still on the ground. Normally, you cannot wall jump afterwards, but by blocking to cancel the recovery of the Mist Raven teleport, you can wall jump up high enough to reach the roof with ledgegrab. This gives slightly more height overall than a normal jump into walljump. However the distance/height gained with Mist Raven is not consistent. Only sometimes will you get the maximum distance, which is usually required. The mechanics behind this inconsistency is not known.

This is used in Mortal Journey Gauntlet Restricted, and in any other category where you have the necessary items and need to kill Gyoubu and immediately interact with the Ashina Castle Gate Sculptor''s Idol.

## In Glitchless

Gyoubu Skip is not allowed in glitchless speedruns. However, the tower jump is allowed if Gyoubu is dead. When used in glitchless, this is usually referred to as "Tower Jump". This can be used to skip having to open the gate and would usually be done as part of the AP1 Bull strat.

## History

Gyoubu Skip was theorized to be possible for a while before a reliable method was developed. Eventually, the Tower Jump method',3,2,'2026-07-19 01:08:23.360740');
INSERT INTO "wiki_revisions" VALUES(53,24,'Shura Glitchless','## Shura Glitchless

## Full Run Tutorials
Mitchriz has created a great beginner guide for Shura Glitchless. It''s a few years old now, but still has good information.
[youtube]https://www.youtube.com/watch?v=vgBAo5tqd5A[/youtube]',5,2,'2026-07-19 01:45:45.659835');
INSERT INTO "wiki_revisions" VALUES(54,24,'Shura Glitchless','## Shura Glitchless

## Shura Glitchless Guides
[Mitchriz](https://sekirospeedrun.com/wiki/mitchriz) has created a great beginner guide for Shura Glitchless. It''s a few years old now, but still has good information.
[youtube]https://www.youtube.com/watch?v=vgBAo5tqd5A[/youtube]',5,2,'2026-07-19 01:46:57.069791');
INSERT INTO "wiki_revisions" VALUES(55,14,'Tutorial Window Jump','## Tutorial Window Jump
Tutorial Window Jump is a jump that lets you exit the Moonview Tower in the tutorial/intro section around 0.5s faster than usual.

Video Tutorial:
[youtube]T9fcivlGr78[/youtube]

This is used in Glitchless. However, for categories allowing glitches, [Tutorial Grapple Glitch](https://sekiro.ryufps.de/wiki/15) is a significantly easier alternative for getting out of the Moonview Tower fast.

## History
Discovered by Pennek',3,2,'2026-07-19 02:06:06.085223');
INSERT INTO "wiki_revisions" VALUES(56,14,'Tutorial Window Jump','## Tutorial Window Jump
Tutorial Window Jump is a jump that lets you exit the Moonview Tower in the tutorial/intro section around 0.5s faster than usual.

Video Tutorial:
[youtube]T9fcivlGr78[/youtube]

This is used in Glitchless. However, for categories allowing glitches, [Tutorial Grapple Glitch](/wiki/tutorial-grapple-glitch) is a significantly better alternative for getting out of the Moonview Tower fast.

## History
Discovered by Pennek',3,2,'2026-07-19 02:09:46.165649');
INSERT INTO "wiki_revisions" VALUES(57,10,'LiveSplit','## LiveSplit
LiveSplit is a timer program for speedrunners that is both easy to use and full of features.

You can download the latest version of LiveSplit [here](https://livesplit.org/). The downloaded file will have to be extracted and the folder placed somewhere you will remember.

Right clicking the LiveSplit window and going to settings allows you to edit various settings. it''s highly recommended to enable Global Hotkeys, as this allows you to split, reset, undo split and skip split while in-game. You can also change the keybinds while you''re here.
![image](https://i.imgur.com/RezD2Uy.png)

Note: The numpad buttons won''t work while shift is pressed. This is good to know if you play with keyboard and mouse and use shift to sprint, as you won''t be able to manual split/reset/undo/skip while holding shift. But that should be fine thought, since most players will use autosplitting.

## SoulSplitter
SoulSplitter is a LiveSplit plugin developed by [Wasted](https://sekiro.ryufps.de/wiki/5) that is designed to provide autosplitting and timekeeping across all the FromSoftware games available on PC. It is also the official leaderboard timer for Sekiro speedruns and includes various fixes that the community has agreed upon. Enabling it and using it is required for PC speedrun leaderboard submissions.

SoulSplitter''s included mods and fixes:
* Auto start and stop

* No intro movies mod

* IGT fix by B3LYP

* Cutscene blackscreen removal by Wasted

* Autosplitting by Wasted

* Event Flag logger and tracker by Wasted

* Improved tutorial pop-up removal by Wasted

* SteamID check bypass for save files by Uberhalit

**Note: Do not use other versions of these mods for leaderboard submissions. Only use them as provided automatically through LiveSplit**.

### How to Setup LiveSplit for Speedrunning (SoulSplitter Setup)
Read section above about LiveSplit and LiveSplit installation first.
1. Open LiveSplit, right-click it and select Edit Splits.
2. Find Sekiro in the Game Name Field.
![image](https://i.imgur.com/amQ9HMr.png)
3. Activate the integrated game time component.
![image](https://i.imgur.com/R1d3TTL.png)
4. Right-click LiveSplit and select Compare Against --> Game Time.
![image](https://i.imgur.com/J6yByQy.png)
5. Done!

## In-Game Time (IGT)
Sekiro has a built in timer, usually referred to as IGT (In-Game Time or In-Game Timer). However, the default behavior of it is not ideal. Its biggest problem is that there''s an issue with the way the time is incremented, which makes the timer count at a rate that is both slower than real time is supposed to run and hardware dependent in an unfair way.

The community has solved this on PC with the IGT Fix by B3LYP. The fixed version of IGT is usually referred to as modified In-Game Time, or mIGT for short. It has also been referred to as wIGT, or Wasted IGT, after Wasted took over maintaining and developing the Sekiro plugin, under the SoulSplitter project. Importantly, modified IGT is designed to run 1:1 with real time, assuming no game slowdowns due to lag or loading screens. Each second of actual gameplay equates to 1 second on the timer.

For the leaderboards, PC runs use modified IGT through LiveSplit, while console runs use the default IGT.

## Autosplitting
With SoulSplitter activated in the Edit Splits menu, you can make custom autosplits. The autosplitter gives the user freedom to setup autosplit triggers for almost anything in the game, allowing you to customize them to how you see fit. Most beginners will want to download a pre-configured .lss split file that has everything already set up and running. Below is a section on where to download splits of other players.

### How to Create Autosplits
to be added

### How to Find Event Flags (Event Flag Logger)
to be added

### What Makes a Good Autosplit?
Generally speaking, you should make a split where ever you feel like it. However, there are some considerations you should make to get the most out of LiveSplit. LiveSplit is supposed to enhance your progress as a player. It''s not supposed to be an obstacle you have to wrestle with.

* Consider splitting in the same places as others, so that you can compare with them more easily to better tell where you could save time. Below is a section that explains how to download the splits that other players use.
* Always test newly added autosplits before doing a run.
* Place autosplits at bottlenecks and be careful of autosplit points that can vary. An example is splitting on Gyoubu kill. If Gyoubu is killed close to where you need to go, then the next split will be shorter, and if he is killed far from where you need to go, then the next split will be longer. This is why most people choose to split on opening the gate after killing Gyoubu in glitchless, instead of splitting directly on kill. The door is a bottleneck that you have to go through (unless you''re doing [AP1 Bull](https://sekiro.ryufps.de/wiki/7)).
* Consider the precision of the autosplit you have made. The autosplitter itself is precise and accurate, but some in-game things aren''t. This is an extension of the point above, but applies more to how you choose to implement the split rather than where you place it. You can never have a precise split on Gyoubu kill, but it''s possible to have an imprecise autosplit on a spot that should otherwise be a good point to split at. Such as if you have a position split with a way too large size, or a size so small that you may run by it and miss it entirely. Test the autosplit to make sure it always triggers at the same point/time.

## Downloading Splits
Some premade .lss split files with autosplits can be downloaded [here](https://www.speedrun.com/sekiro/resources).

You can also use the website [therun.gg](https://therun.gg/games/Sekiro%3A%20Shadows%20Die%20Twice) to view and download the splits of other runners.

When you download someone else''s splits, it can be a good idea to go to Edit Splits --> Other and then Clear History and Clear Times. This will reset all the stats and times from the splits.

## Recording LiveSplit in Videos
The most popular program for recording and livestreaming is [Open Broadcaster Software (OBS)](https://obsproject.com/). It allows adding multiple layers to your scene, where you would usually use a Game Capture for Sekiro with a Window Capture for LiveSplit put on top of it.

To make a Game Capture Source in OBS:

1. Press the + in the Sources box and choose Game Capture Source. Shown below:
![image](https://www.speedrun.com/static/blob/rz2x1ke0.png)

Game Capture will only show the game, therefore we need to add a separate Source for LiveSplit itself. For capturing LiveSplit, we use a Window Capture Source.

2. Add the Window Capture in the same way you added the Game Capture in the step above (make sure that LiveSplit is open while doing this).

3. After naming it, the following window will appear. Select LiveSplit as the window.
![image](https://www.speedrun.com/static/blob/qzp2mle3.png)

I recommend setting the **"Window Match Priority"** to **"Match title, otherwise find window of same executable"**. This ensures that the Source will exclusively look for the LiveSplit window to capture.

4. Done!

### Making LiveSplit Transparent
The usual way that people make LiveSplit transparent is through a filter in OBS, which will only make it look transparent in the recording and NOT for you. Alternatively, you can use the Transparent LiveSplit fork, which makes LiveSplit''s own background transparent, instead of filtering it out in the recording.

Follow the tutorial below to make LiveSplit transparent in the recording (not needed if using the Transparent LiveSplit fork).
1. **You want to use a black background on LiveSplit. Do not use a color like green, blue or anything like that**, as this will mess with the other elements. Using the default black/dark grey background works as well.
![image](https://www.speedrun.com/static/blob/rz2x18e0.png)

The background color can be changed in layout settings.
![image](https://www.speedrun.com/static/blob/yzrrgjz4.png)

2. Right click the Window Capture you created for LiveSplit (mine is called Splits) and press Filters.
![image](https://www.speedrun.com/static/blob/5e1kpvn0.png)

3. Add a **Color Key** (not a Chroma Key). Set the type to Custom Colour and choose black. Then finally, adjust the Similarity slider until the background disappears. You will get the best looking result with a solid black LiveSplit background.
![image](https://www.speedrun.com/static/blob/xz0og0zl.png)

4. Done!

## Troubleshooting
If you have issues with the timer not automatically starting or not correctly showing the game time, triple check you are comparing against Game Time. Otherwise try restarting LiveSplit, running LiveSplit as Administrator or restarting your PC. If you need help feel free to ask in the #support channel on the [Sekiro Speedrunning Discord server](https://discord.gg/A7kWEPkKEq).

### LiveSplit Error: "The Auto Splitter could not be activated"
The most common cause of this error is that anti-virus will sometimes falsely flag SoulSplitter as an unwatend program and can quarantine the files without giving you a notification. [Here is the guide on how to create an anti-virus exclusion](https://soulsspeedruns.com/livesplit/#troubleshooting).

### LiveSplit Error: "Incomplete installation. Missing files"
Sometimes, the anti-virus fix isn''t enough. If you get an error about missing files, then you need to manually download the SoulSplitter component files from Github via the following steps:
1. Close LiveSplit.
2. Go to the [SoulSplitter Github downloads page](https://github.com/FrankvdStam/SoulSplitter/releases).
3. Download the .zip file from whatever is the latest release (do not download the ones named "source code").
4. Extract the .zip file.
5. Navigate to your LiveSplit components folder.
6. Drag the extracted files into the LiveSplit/components folder (replace files if asked).
7. Apply the anti-virus fix explained [here](https://soulsspeedruns.com/livesplit/#troubleshooting).
8. Done!

## Extra Tools for LiveSplit
to be added

## Credits
Thanks to XeroGoesFast for authoring the original LiveSplit guide.
Thanks to B3LYP for releasing the initial Sekiro timer plugin for LiveSplit.
Thanks to RefinedHornet for contributions to the old Sekiro timer.
Thanks to CapitaineToinon for contributions to the old Sekiro timer.
Thanks to Wasted for revolutionizing the Sekiro plugin with the SoulSplitter project.',1,2,'2026-07-19 02:53:22.944888');
INSERT INTO "wiki_revisions" VALUES(58,15,'Tutorial Grapple Glitch','## Tutorial Grapple Glitch
Tutorial Grapple Glitch allows you to use the grappling hook during the tutorial/intro section when hanging from a ledge specifically. Using the grapple at all during the tutorial/intro section is normally impossible because Wolf has not had his arm cut off nor the prosthetic arm attached yet in the story.

While ledge hanging, if you press crouch, jump or deflect on the same frame as you press grapple, Wolf is able to grapple in the tutorial.

This is used to exit the Moonview Tower around 0.5s faster in glitched speedruns. This is not allowed in glitchless speedruns. For glitchless, there is an alternative method called [Tutorial Window Jump](https://sekiro.ryufps.de/wiki/14). Note: [TeamHitless](https://www.teamhitless.com/) allows the Tutorial Grapple Glitch in their otherwise mostly glitchless no-hit runs.

Video Tutorial:
[youtube]zFL1mjWWVfA[/youtube]

## History
Discovered by accident by Mommyemma77',3,2,'2026-07-19 03:01:37.832047');
INSERT INTO "wiki_revisions" VALUES(59,24,'Shura Glitchless','## Shura Glitchless

## Shura Glitchless Guides
[Mitchriz](https://sekirospeedrun.com/wiki/mitchriz) has created a great beginner guide for Shura Glitchless. It''s a few years old now, but still has good information.
[youtube]vgBAo5tqd5A[/youtube]',5,2,'2026-07-19 03:08:01.875014');
INSERT INTO "wiki_revisions" VALUES(60,24,'Shura Glitchless','## Shura Glitchless

## Shura Glitchless Guides
[Mitchriz](https://sekirospeedrun.com/wiki/mitchriz) has created a great beginner guide for Shura Glitchless. It''s a few years old now, but still has good information.
[youtube]vgBAo5tqd5A[/youtube]

## Shura Glitchless Route

### Tutorial Section
After speaking to Kuro, you can use [Tutorial Window Jump](/wiki/tutorial-window-jump) to exit the window 0.5s faster.

### Ashina Outskirts

### Chained Ogre

### Canyon

### Gyoubu Oniwa

### Blazing Bull

### Genichiro

### Armored Warrior

### Folding Screen Monkeys

### Gunfort

### Centipede Giraffe

### Snake Eyes

### Mibu Village

### Corrupted Monk

### Guardian Ape

### Emma

### Isshin',5,2,'2026-07-19 03:38:30.432773');
INSERT INTO "wiki_revisions" VALUES(61,6,'Gyoubu Skip','## Gyoubu Skip
Gyoubu Skip, also known as Horse Skip, is a skip with multiple variations that involves circumventing needing to fight Gyoubu Oniwa.

## Tower Jump Variation

Using a delayed jump the top of the tower near the Ashina Castle Gate, you can reach the top of the wall with a ledgegrab.

## Mist Raven Variation

Using Mist Raven together with Contact Medicine let''s you do On-Demand Mist Raven, which can give an upwards teleport if used while standing still on the ground. Normally, you cannot wall jump afterwards, but by blocking to cancel the recovery of the Mist Raven teleport, you can wall jump up high enough to reach the roof with ledgegrab. This gives slightly more height overall than a normal jump into walljump. However the distance/height gained with Mist Raven is not consistent. Only sometimes will you get the maximum distance, which is usually required. The mechanics behind this inconsistency is not known.

This is used in Mortal Journey Gauntlet Restricted, and in any other category where you have the necessary items and need to kill Gyoubu and immediately interact with the Ashina Castle Gate Sculptor''s Idol.

## In Glitchless

Gyoubu Skip is not allowed in glitchless speedruns. However, the tower jump is allowed if Gyoubu is dead. When used in glitchless, this is usually referred to as "Tower Jump". This can be used to skip having to open the gate and would usually be done as part of the AP1 Bull strat.

## History

Gyoubu Skip was theorized to be possible for a while before a reliable method was developed. Eventually, the Tower Jump method was found by Distortion2.',3,2,'2026-09-16 07:50:35.587046');
INSERT INTO "wiki_revisions" VALUES(62,21,'WormdogBS','## WormdogBS
Wormdog is a Sekiro Speedrunner, who has the record for the holding the most Sekiro Speedrun World Records simultaneously, at 9.',2,2,'2026-09-16 18:55:48.699657');
INSERT INTO "wiki_revisions" VALUES(63,9,'Monkey Skip','## Monkey Skip
Monkey Skip is a skip that allows skipping the Folding Screen Monkeys boss. It is performed via a Delayed Jump from a tree branch outside of Senpou Temple Hall and lets you enter directly into the Inner Sanctum without fighting the Folding Screen Monkeys.

Video Tutorial:
[youtube]56g7lWP0utY[/youtube]

## In Any%
Monkey Skip is most famously used in the Any% speedrun, which has since been split up into Shura Restricted and Shura Unrestricted. It has been in use in both categories ever since it was made viable in summer 2020.

## In Immortal Severance
Monkey Skip is also used in Immortal Severance Restricted, also sometimes called Immortal Severance Any%".

## In Other Categories
**Monkey Skip is not allowed in Glitchless.** It also cannot be used in categories that require you to gather all Memories or kill all bosses. It generally sees limited use in glitched categories as doing Monkey Skip makes you miss getting the Attack Power upgrade from the Memory they drop, which overall ends up being slower for Shura No Airswim and Immortal Severance No Airswim. In both No Airswim categories, the Monkeys Grapple Launch is used instead.

## History
Monkey Skip was theorized to be possible by Marky around April 20th, 2019. However, [he did not manage to get it to work](https://streamable.com/3low9). It was first shown to be possible when [Distortion2 managed to land it during a testing livestream](https://www.twitch.tv/distortion2/clip/FaintAliveVelociraptorSpicyBoy) on April 24th, 2019. It proved to be insanely precise, and was thus not used in runs until Mitchriz, on May 27th, 2020, discovered a consistent setup. After which he used it break LilAggy''s Any% World Record of 21:19 with a time of 21:09 on June 1st, 2020, stopping LilAggy''s nearly 1 year long reign as the WR holder. The day after, on June 2nd, he posted the tutorial linked above, which enabled other runners to be able to do the skip. On June 7th, LilAggy reclaimed the WR with a time of 21:02, and then beat his own record the day after on June 8th with the first sub 21-minute completion of the game with a time of 20:39. Monkey Skip has been a key part of the Any% speedrun since then.',3,2,'2026-09-16 19:02:31.661109');
INSERT INTO "wiki_revisions" VALUES(64,17,'Sculptor''s Idol','## Sculptor''s Idol
Sculptor''s Idols serve as checkpoints and allow the player a variety of options including to rest.

## List of Idols

## Last Idol IDs
Internally, the game has IDs for the location of your last Idol.

The game has many more functioning IDs than it has IDs that are actually used when playing normally. A list is provided containing only the IDs that are used during regular gameplay, and a separate full list of all possible IDs is listed below that.

### In-use List


### Full list
1002949 - Hirata Map Default Location
1002950 - Dragonspring - Hirata Estate
1002951 - Estate Path
1002952 - Bamboo Thicket Slope
1002953 - Hirata Estate - Main Hall
1002954 - Hirata Estate - Hidden Temple
1002955 - Hirata Audience Chamber
1002956 - Hirata Map Default Location
1002957 - Hirata Map Default Location
1002959 - Hitara Map Default Location

1102949 - Ashina Outskirts Map Default Location
1102950 - Dilapidated Temple
1102951 - Outskirts Wall - Gate Path
1102952 - Outskirts Wall - Stairway
1102953 - Underbridge Valley
1102954 - Ashina Castle Gate Fortress
1102955 - Ashina Castle Gate
1102956 - Ashina Outskirts 
1102957 - Flames of Hatred
1102958 - Ashina Outskirts Broken Bridge
1102959 - Ashina Outskirts After Chained Ogre
1102960 - Ashina Castle Gate
1102961 - Ashina Outskirts Map Default Location
1102962 - Ashina Outskirts Map Default Location
1102963 - Ashina Outskirts Map Default Location
1102964 - Ashina Outskirts Map Default Location

1112949 - Ashina Castle Map Default Location
1112950 - Ashina Castle
1112951 - Upper Tower - Antechamber
1112952 - Castle Tower Lookout
1112953 - Upper Tower - Kuro’s Room
1112954 - Great Serpent Shrine
1112955 - Abandoned Dungeon Entrance
1112956 - Old Grave
1112957 - Upper Tower - Ashina Dojo
1112958 - Ashina Castle Map Default Location
1112959 - Ashina Castle Map Default Location

1122949 - Game Start Location
1122950 - Near Secret Passage
1122951 - Ashina Reservoir
1122952 - Game Start Location
1122953 - Game Start Location
1122954 - Game Start Location

1302948 - Abandoned Dungeon Map Default Location
1302949 - Abandoned Dungeon Map Default Location
1302950 - Underground Waterway
1302951 - Bottomless Hole
1302952 - Abandoned Dungeon Map Default Location
1302953 - Abandoned Dungeon Map Default Location
1302954 - Abandoned Dungeon Map Default Location	

1502949 - Ashina Depths Map Default Location
1502950 - Hidden Forest
1502951 - Mibu Village
1502952 - Water Mill
1502953 - Wedding Cave
1502954 - Ashina Depths Map Default Location
1502955 - Ashina Depths Map Default Location

1702948 - Sunken Valley Default Location
1702949 - Sunken Valley Default Location
1702950 - Sunken Valley
1702951 - Gun Fort
1702952 - Riven Cave
1702953 - Guardian Ape’s Watering Hole
1702954 - Poison Pool
1702955 - Ashina Depths
1702956 - Guardian Ape’s Burrow
1702957 - Under-Shrine Valley
1702958 - Bodhisattva Valley
1702959 - Sunken Valley Default Location
1702960 - Sunken Valley Default Location

2002948 - Senpou Map Default Location
2002949 - Senpou Map Default Location
2002950 - Senpou Temple, Mt. Kongo
2002951 - Shugendo
2002952 - Temple Grounds
2002953 - Main Hall
2002954 - Inner Sanctum
2002955 - Sunken Valley Cavern
2002956 - Bell Demon’s Temple
2002957 - Inner Sanctum Post-Monkeys Location
2002958 - Monkeys Arena
2002959 - Senpou Map Default Location
2002960 - Senpou Map Default Location

2502948 - Fountainhead Palace Map Default Location
2502949 - Fountainhead Palace Map Default Location
2502950 - Fountainhead Palace
2502951 - Vermilion Bridge
2502952 - Flower Viewing Stage
2502953 - Great Sakura
2502954 - Palace Grounds
2502955 - Sanctuary
2502956 - Mibu Manor
2502957 - Feeding Grounds
2502958 - Near Pot Noble
2502959 - Fountainhead Palace Map Default Location
2502960 - Fountainhead Palace Map Default Location',4,2,'2026-09-16 19:34:09.080526');
INSERT INTO "wiki_revisions" VALUES(65,6,'Gyoubu Skip','## Gyoubu Skip
Gyoubu Skip, also known as Horse Skip, is a skip with multiple variations that involves circumventing needing to fight Gyoubu Oniwa.

## Tower Jump Variation

Using a delayed jump the top of the tower near the Ashina Castle Gate, you can reach the top of the wall with a ledgegrab.

## Mist Raven Variation

Using Mist Raven together with Contact Medicine let''s you do On-Demand Mist Raven, which can give a vertical teleport if used while standing still on the ground. Normally, you cannot wall jump after using Mist Raven. But if you block mid air after getting the vertical teleport, you regain the ability to wall jump. This requires the Mid-air Deflection Skill. After the vertical teleport, you can wall jump up high enough to reach the roof with a ledgegrab.
Video Example:

On version 1.04 and below, you can also add in a ledge grab to regain the ability to jump even faster, which makes it easier to reach the top.
Video Example:

Note: The height gained from a vertical Mist Raven teleport is inconsistent, sometimes you will get a low teleport for seemingly no reason. This has not been figured out yet, but is theorized to be impacted by framerate.

This is used in Mortal Journey Gauntlet Restricted, and in any other category where you have the necessary items and need to kill Gyoubu and immediately interact with the Ashina Castle Gate Sculptor''s Idol.

## In Glitchless

Gyoubu Skip is not allowed in glitchless speedruns. However, the tower jump is allowed if Gyoubu is dead. When used in glitchless, this is usually referred to as "Tower Jump". This can be used to skip having to open the gate and would usually be done as part of the AP1 Bull strat.

## History

Gyoubu Skip was theorized to be possible for a while before a reliable method was developed. Eventually, the Tower Jump method was found by Distortion2.',3,2,'2026-09-17 13:59:30.202676');
INSERT INTO "wiki_revisions" VALUES(66,6,'Gyoubu Skip','## Gyoubu Skip
Gyoubu Skip, also known as Horse Skip, is a skip with multiple variations that involves circumventing needing to fight Gyoubu Oniwa.

## Tower Jump Variation

Using a delayed jump the top of the tower near the Ashina Castle Gate, you can reach the top of the wall with a ledgegrab.

## Mist Raven Variation

Using Mist Raven together with Contact Medicine let''s you do On-Demand Mist Raven, which can give a vertical teleport if used while standing still on the ground. Normally, you cannot wall jump after using Mist Raven. But if you block mid air after getting the vertical teleport, you regain the ability to wall jump. This requires the Mid-air Deflection Skill. After the vertical teleport, you can wall jump up high enough to reach the roof with a ledgegrab.
Video Example:
[youtube]eIv7gEKePEQ[/youtube]

On version 1.04 and below, you can also add in a ledge grab to regain the ability to jump even faster, which makes it easier to reach the top.
Video Example:
[youtube]Y9IxrDVZtNk [/youtube]

Note: The height gained from a vertical Mist Raven teleport is inconsistent, sometimes you will get a low teleport for seemingly no reason. This has not been figured out yet, but is theorized to be impacted by framerate.

This has been used in Mortal Journey Gauntlet Restricted, and in any other category where you have the necessary items and need to kill Gyoubu and immediately interact with the Ashina Castle Gate Sculptor''s Idol, where going to the tower would be a detour. However, it is not popular due to its inconsistency.

## In Glitchless

Gyoubu Skip is not allowed in glitchless speedruns. However, the tower jump is allowed if Gyoubu is dead. When used in glitchless, this is usually referred to as "Tower Jump". This can be used to skip having to open the gate and would usually be done as part of the AP1 Bull strat.

## History

Gyoubu Skip was theorized to be possible for a while before a reliable method was developed. Eventually, the Tower Jump method was found by Distortion2.',3,8,'2026-09-17 16:54:21.479815');
INSERT INTO "wiki_revisions" VALUES(67,6,'Gyoubu Skip','## Gyoubu Skip
Gyoubu Skip, also known as Horse Skip, is a skip with multiple variations that involves circumventing needing to fight Gyoubu Oniwa.

## Tower Jump Variation

Using a [Delayed Jump](https://sekirospeedrun.com/wiki/delayed-jump) the top of the tower near the Ashina Castle Gate, you can reach the top of the wall with a ledgegrab.

## Mist Raven Variation

Using Mist Raven together with Contact Medicine let''s you do On-Demand Mist Raven, which can give a vertical teleport if used while standing still on the ground. Normally, you cannot wall jump after using Mist Raven. But if you block mid air after getting the vertical teleport, you regain the ability to wall jump. This requires the Mid-air Deflection Skill. After the vertical teleport, you can wall jump up high enough to reach the roof with a ledgegrab.
Video Example:
[youtube]eIv7gEKePEQ[/youtube]

On version 1.04 and below, you can also add in a ledge grab to regain the ability to jump even faster, which makes it easier to reach the top.
Video Example:
[youtube]Y9IxrDVZtNk [/youtube]

Note: The height gained from a vertical Mist Raven teleport is inconsistent, sometimes you will get a low teleport for seemingly no reason. This has not been figured out yet, but is theorized to be impacted by framerate.

This has been used in Mortal Journey Gauntlet Restricted, and in any other category where you have the necessary items and need to kill Gyoubu and immediately interact with the Ashina Castle Gate Sculptor''s Idol, where going to the tower would be a detour. However, it is not popular due to its inconsistency.

## In Glitchless

Gyoubu Skip is not allowed in glitchless speedruns. However, the tower jump is allowed if Gyoubu is dead. When used in glitchless, this is usually referred to as "Tower Jump". This can be used to skip having to open the gate and would usually be done as part of the AP1 Bull strat.

## History

Gyoubu Skip was theorized to be possible for a while before a reliable method was developed. Eventually, the Tower Jump method was found by Distortion2.',3,2,'2026-09-17 16:59:13.739128');
INSERT INTO "wiki_revisions" VALUES(68,5,'Wasted','## Wasted

Wasted is a community member famous for developing the autosplitter for Sekiro, SoulSplitter.',2,2,'2026-09-17 17:10:17.357119');
INSERT INTO "wiki_revisions" VALUES(69,53,'Airswim','## Airswim
Airswim is a major glitch that allows the player to fly in the air while the game thinks the player is swimming in water.

## Execution
Airswim is performed by entering a body of water while Out of Bounds and diving (requires Mibu Breathing Technique). This allows the player to swim everywhere as if submerged in water. It''s caused by the game transitioning between the out-of-water and swimming states only when crossing a water surface.

## Common Use Cases
Airswim is used in the majority of the Glitched categories (excluding No Airswim subcategories) and is the foundation of Any% Speedruns. It''s most commonly used to skip most of Senpou Temple and Sunken Valley and is a core part of Ape Skip. It''s also used to enter boss fights, as cutscenes also bring the player out of the swimming state.',3,2,'2026-09-17 17:17:47.106639');
INSERT INTO "wiki_revisions" VALUES(70,22,'B3LYP','## B3LYP
B3LYP, also known as just B3, is a Fromsoft game mod maker, who discovered that In-Game Time in certain Fromsoft games, including Sekiro, has an FPS-dependent clockdrift that makes the timer run in a hardware dependent and inaccurate way. B3LYP created the IGT fix that solves the issue and forms the basis of the timing method that Sekiro PC Speedruns uses called Modified In-Game Time.',2,8,'2026-09-19 05:37:00.315824');
INSERT INTO "wiki_revisions" VALUES(71,9,'Monkey Skip','## Monkey Skip
Monkey Skip is a skip that allows skipping the Folding Screen Monkeys boss. It is performed via a Delayed Jump from a tree branch outside of Senpou Temple Hall and lets you enter directly into the Inner Sanctum without fighting the Folding Screen Monkeys.

Video Tutorial:
[youtube]56g7lWP0utY[/youtube]

## In Any%
Monkey Skip is most famously used in the Any% speedrun, which has since been split up into Shura Restricted and Shura Unrestricted. It has been in use in both categories ever since it was made viable in summer 2020.

## In Immortal Severance
Monkey Skip is also used in Immortal Severance Restricted, also sometimes called Immortal Severance Any%".

## In Other Categories
**Monkey Skip is not allowed in Glitchless.** It also cannot be used in categories that require you to kill the Folding Screen Monkeys (such as in All Memories Restricted). It generally sees limited use in glitched categories, outside of short any% style runs, as doing Monkey Skip makes you miss getting the Attack Power upgrade from the Memory they drop, which overall ends up being slower for Shura No Airswim and Immortal Severance No Airswim. In both No Airswim categories, the Monkeys Grapple Launch is used instead.

## History
Monkey Skip was theorized to be possible by Marky around April 20th, 2019. However, [he did not manage to get it to work](https://streamable.com/3low9). It was first shown to be possible when [Distortion2 managed to land it during a testing livestream](https://www.twitch.tv/distortion2/clip/FaintAliveVelociraptorSpicyBoy) on April 24th, 2019. It proved to be insanely precise, and was thus not used in runs until Mitchriz, on May 27th, 2020, discovered a consistent setup. Mitchriz used it break LilAggy''s Any% World Record of 21:19 with a time of 21:09 on June 1st, 2020, stopping LilAggy''s nearly 1 year long reign as the WR holder. The day after, on June 2nd, he posted the tutorial linked above, which enabled other runners to be able to do the skip. On June 7th, LilAggy reclaimed the WR with a time of 21:02, and then beat his own record the day after on June 8th with the first sub 21-minute completion of the game with a time of 20:39. Monkey Skip has been a key part of the Any% speedrun since then.',3,2,'2026-09-19 06:43:12.529252');
INSERT INTO "wiki_revisions" VALUES(72,19,'Gourd Seed','## Gourd Seed

A Gourd Seed is a Key Item that can be given to Emma to upgrade the Healing Gourd. Each Gourd Seed given increases the Healing Gourd''s number of uses by 1, up to a maximum of 10.

## Acquisition

There are 9 Gourd Seeds in the game. Each one can only be acquired once, so in order to upgrade the Healing Gourd to its maximum of 10 uses, all 9 of them need to be found. All 9 can be acquired in one New Game cycle and are not missable, except when going for Shura ending. In which case, the 9th Gourd Seed, located in Fountainhead Palace, is not obtainable. Any Gourd Seeds not collected can be collected on New Game+. On New Game+, if a Gourd Seed has already been acquired, it will be replaced with a different item.

1. In Ashina Outskirts, dropped by General Naomori Kawarada. When Invasion 2 is triggered, if Kawarada was not defeated, he will disappear and his Gourd Seed will become purchasable for 2400 Sen from the Offering Box at Dilapidated Temple.

2. In Ashina Outskirts, after Chained Ogre, in the building above, on the left, the item pick-up will be by two soldier uniforms hanging on a wall.

3. In Ashina Outskirts, after Gyoubu, 1 Gourd Seed can be purchased for 1000 Sen from the Battlefield Memorial Mob.

4. In Ashina Castle, in a chest by the Castle Antechamber Idol.

5. At Dilapidated Temple, after Genichiro is defeated, Fujioka the Info Broker will appear and sell 1 Gourd Seed for 2000 Sen.

6. In Senpou Temple, after the cricket room, the item pick-up will be in front of an immortal monk.

7. In Sunken Valley, after the Serpent''s Shrine, on the way towards Gunfort, take a sidepath on the left. Continue and climb up, the item pick-up will be in a corner in a wall cavity.

8. In Ashina Depths, Mibu Village, the item pick-up will be in the middle at the base of a large lit up tree.

9. In Fountainhead Palace, in a chest near the Palace Grounds Idol.

## Gourd Seed Duplication

It is possible to gain infinite Gourd Seeds by exploiting a glitch with the Reflections of Strength. The Offering Box, where normally up to 1 Gourd Seed can be bought from, exists during Reflections and Gauntlets. In this state, the Offering Box doesn''t have the flags for disabling items that have already been acquired or purchased, letting you purchase all of the items that it can possible sell, even if they have already been acquired.

By entering Demon of Hatred or Sword Saint Reflection, which take place during the Invasion 2 world state, and navigating to Dilapidated Temple, you are able to purchase 1 Gourd Seed from the Offering Box for 2400 Sen. When you exit the Reflection, the Sen will be refunded, but the Gourd Seed will stay in your inventory. Note: it is not possible to upgrade the Healing Gourd above the intended 10 maximum uses.',4,2,'2026-09-19 06:54:08.634985');
INSERT INTO "wiki_revisions" VALUES(73,33,'Yashariku''s Sugar','## Yashariku''s Sugar
Yashariku''s Sugar, also known as just Yash, is a Consumable Quick Item that buffs the player''s vitality damage by 25% and posture damage by 50% for 30s. If the player has the Devotion skill, the duration will be 45s instead.

Only one Sugar buff can be active at a time. If a new Sugar is used while Yash is already active, it will remove the Yash''s buff and apply the new Sugar''s buff.',4,2,'2026-09-20 06:32:19.749471');
INSERT INTO "wiki_revisions" VALUES(74,63,'Dojo Skip','## Frontside Dojo Skip
Frontdojo Skip refers to a trick that skips going inside Ashina Castle and allows early access to the roof. This is most commonly used in glitchless categories before Genichiro. Note that it can also be performed to reach the roof faster after the first invasion, but the time save there is much smaller.

Pennek has made 2 tutorials on the skip.
[youtube]Fb3tdwepZnE[/youtube]
[youtube]vjTOwn6XHaU[/youtube]',3,7,'2026-09-30 17:10:44.630744');
INSERT INTO "wiki_revisions" VALUES(75,50,'Corrupted Monk Cheese','## Corrupted Monk Cheese
Corrupted Monk Cheese refers to performing a stealth deathblow on Corrupted Monk (illusion) after stunning him with enough Snap Seeds and Fistfuls of Ash. It is not considered a glitch in either Speedruns or Hitless Runs.

## 4 Ash Corrupted Monk Cheese
This is the fastest and the hardest way to perform this strat, as the window in which you need to start using your consumables is very precise. It consists of using 3 Snap Seeds and 4 Fistfuls of Ash to make Corrupted Monk backstep just far enough to get a stealth deathblow. There is a tutorial for this cheese by ponetchmas:
[youtube]3IMBc2EcGiQ[/youtube]

## 5/6 Ash Variations
You can make the timing window for this strat more forgiving by using more Fistfuls of Ash. Beginners will use 5 or 6 of them to make the cheese consistent for them.',3,7,'2026-09-30 17:11:04.369716');
INSERT INTO "wiki_revisions" VALUES(76,50,'Corrupted Monk Cheese','## Corrupted Monk Cheese
Corrupted Monk Cheese refers to performing a stealth deathblow on Corrupted Monk (illusion) after stunning her with enough Snap Seeds and Fistfuls of Ash. It is not considered a glitch in either Speedruns or Hitless Runs.

## 4 Ash Corrupted Monk Cheese
This is the fastest and the hardest way to perform this strat, as the window in which you need to start using your consumables is very precise. It consists of using 3 Snap Seeds and 4 Fistfuls of Ash to make Corrupted Monk backstep just far enough to get a stealth deathblow. There is a tutorial for this cheese by ponetchmas:
[youtube]3IMBc2EcGiQ[/youtube]

## 5/6 Ash Variations
You can make the timing window for this strat more forgiving by using more Fistfuls of Ash. Beginners will use 5 or 6 of them to make the cheese consistent for them.',3,2,'2026-09-30 18:20:07.054376');
INSERT INTO "wiki_revisions" VALUES(77,10,'LiveSplit','## LiveSplit
LiveSplit is a timer program for speedrunners that is both easy to use and full of features.

You can download the latest version of LiveSplit [here](https://livesplit.org/). The downloaded file will have to be extracted and the folder placed somewhere you will remember.

Right clicking the LiveSplit window and going to settings allows you to edit various settings. it''s highly recommended to enable Global Hotkeys, as this allows you to split, reset, undo split and skip split while in-game. You can also change the keybinds while you''re here.
![image](https://i.imgur.com/RezD2Uy.png)

Note: The numpad buttons won''t work while shift is pressed. This is good to know if you play with keyboard and mouse and use shift to sprint, as you won''t be able to manual split/reset/undo/skip while holding shift. But that should be fine thought, since most players will use autosplitting.

## SoulSplitter
SoulSplitter is a LiveSplit plugin developed by [Wasted](/wiki/wasted) that is designed to provide autosplitting and timekeeping across all the FromSoftware games available on PC. It is also the official leaderboard timer for Sekiro speedruns and includes various fixes that the community has agreed upon. Enabling it and using it is required for PC speedrun leaderboard submissions.

SoulSplitter''s included mods and fixes:
* Auto start and stop

* No intro movies mod

* IGT fix by B3LYP

* Cutscene blackscreen removal by Wasted

* Autosplitting by Wasted

* Event Flag logger and tracker by Wasted

* Improved tutorial pop-up removal by Wasted

* SteamID check bypass for save files by Uberhalit

**Note: Do not use other versions of these mods for leaderboard submissions. Only use them as provided automatically through LiveSplit**.

### How to Setup LiveSplit for Speedrunning (SoulSplitter Setup)
Read section above about LiveSplit and LiveSplit installation first.
1. Open LiveSplit, right-click it and select Edit Splits.
2. Find Sekiro in the Game Name Field.
![image](https://i.imgur.com/amQ9HMr.png)
3. Activate the integrated game time component.
![image](https://i.imgur.com/R1d3TTL.png)
4. Right-click LiveSplit and select Compare Against --> Game Time.
![image](https://i.imgur.com/J6yByQy.png)
5. Done!

## In-Game Time (IGT)
Sekiro has a built in timer, usually referred to as IGT (In-Game Time or In-Game Timer). However, the default behavior of it is not ideal. Its biggest problem is that there''s an issue with the way the time is incremented, which makes the timer count at a rate that is both slower than real time is supposed to run and hardware dependent in an unfair way.

The community has solved this on PC with the IGT Fix by B3LYP. The fixed version of IGT is usually referred to as modified In-Game Time, or mIGT for short. It has also been referred to as wIGT, or Wasted IGT, after Wasted took over maintaining and developing the Sekiro plugin, under the SoulSplitter project. Importantly, modified IGT is designed to run 1:1 with real time, assuming no game slowdowns due to lag or loading screens. Each second of actual gameplay equates to 1 second on the timer.

For the leaderboards, PC runs use modified IGT through LiveSplit, while console runs use the default IGT.

## Autosplitting
With SoulSplitter activated in the Edit Splits menu, you can make custom autosplits. The autosplitter gives the user freedom to setup autosplit triggers for almost anything in the game, allowing you to customize them to how you see fit. Most beginners will want to download a pre-configured .lss split file that has everything already set up and running. Below is a section on where to download splits of other players.

### How to Create Autosplits
to be added

### How to Find Event Flags (Event Flag Logger)
to be added

### What Makes a Good Autosplit?
Generally speaking, you should make a split where ever you feel like it. However, there are some considerations you should make to get the most out of LiveSplit. LiveSplit is supposed to enhance your progress as a player. It''s not supposed to be an obstacle you have to wrestle with.

* Consider splitting in the same places as others, so that you can compare with them more easily to better tell where you could save time. Below is a section that explains how to download the splits that other players use.
* Always test newly added autosplits before doing a run.
* Place autosplits at bottlenecks and be careful of autosplit points that can vary. An example is splitting on Gyoubu kill. If Gyoubu is killed close to where you need to go, then the next split will be shorter, and if he is killed far from where you need to go, then the next split will be longer. This is why most people choose to split on opening the gate after killing Gyoubu in glitchless, instead of splitting directly on kill. The door is a bottleneck that you have to go through (unless you''re doing [AP1 Bull](/wiki/attack-power-1-bull).
* Consider the precision of the autosplit you have made. The autosplitter itself is precise and accurate, but some in-game things aren''t. This is an extension of the point above, but applies more to how you choose to implement the split rather than where you place it. You can never have a precise split on Gyoubu kill, but it''s possible to have an imprecise autosplit on a spot that should otherwise be a good point to split at. Such as if you have a position split with a way too large size, or a size so small that you may run by it and miss it entirely. Test the autosplit to make sure it always triggers at the same point/time.

## Downloading Splits
Some premade .lss split files with autosplits can be downloaded [here](https://www.speedrun.com/sekiro/resources).

You can also use the website [therun.gg](https://therun.gg/games/Sekiro%3A%20Shadows%20Die%20Twice) to view and download the splits of other runners.

When you download someone else''s splits, it can be a good idea to go to Edit Splits --> Other and then Clear History and Clear Times. This will reset all the stats and times from the splits.

## Recording LiveSplit in Videos
The most popular program for recording and livestreaming is [Open Broadcaster Software (OBS)](https://obsproject.com/). It allows adding multiple layers to your scene, where you would usually use a Game Capture for Sekiro with a Window Capture for LiveSplit put on top of it.

To make a Game Capture Source in OBS:

1. Press the + in the Sources box and choose Game Capture Source. Shown below:
![image](https://www.speedrun.com/static/blob/rz2x1ke0.png)

Game Capture will only show the game, therefore we need to add a separate Source for LiveSplit itself. For capturing LiveSplit, we use a Window Capture Source.

2. Add the Window Capture in the same way you added the Game Capture in the step above (make sure that LiveSplit is open while doing this).

3. After naming it, the following window will appear. Select LiveSplit as the window.
![image](https://www.speedrun.com/static/blob/qzp2mle3.png)

I recommend setting the **"Window Match Priority"** to **"Match title, otherwise find window of same executable"**. This ensures that the Source will exclusively look for the LiveSplit window to capture.

4. Done!

### Making LiveSplit Transparent
The usual way that people make LiveSplit transparent is through a filter in OBS, which will only make it look transparent in the recording and NOT for you. Alternatively, you can use the Transparent LiveSplit fork, which makes LiveSplit''s own background transparent, instead of filtering it out in the recording.

Follow the tutorial below to make LiveSplit transparent in the recording (not needed if using the Transparent LiveSplit fork).
1. **You want to use a black background on LiveSplit. Do not use a color like green, blue or anything like that**, as this will mess with the other elements. Using the default black/dark grey background works as well.
![image](https://www.speedrun.com/static/blob/rz2x18e0.png)

The background color can be changed in layout settings.
![image](https://www.speedrun.com/static/blob/yzrrgjz4.png)

2. Right click the Window Capture you created for LiveSplit (mine is called Splits) and press Filters.
![image](https://www.speedrun.com/static/blob/5e1kpvn0.png)

3. Add a **Color Key** (not a Chroma Key). Set the type to Custom Colour and choose black. Then finally, adjust the Similarity slider until the background disappears. You will get the best looking result with a solid black LiveSplit background.
![image](https://www.speedrun.com/static/blob/xz0og0zl.png)

4. Done!

## Troubleshooting
If you have issues with the timer not automatically starting or not correctly showing the game time, triple check you are comparing against Game Time. Otherwise try restarting LiveSplit, running LiveSplit as Administrator or restarting your PC. If you need help feel free to ask in the #support channel on the [Sekiro Speedrunning Discord server](https://discord.gg/A7kWEPkKEq).

### LiveSplit Error: "The Auto Splitter could not be activated"
The most common cause of this error is that anti-virus will sometimes falsely flag SoulSplitter as an unwatend program and can quarantine the files without giving you a notification. [Here is the guide on how to create an anti-virus exclusion](https://soulsspeedruns.com/livesplit/#troubleshooting).

### LiveSplit Error: "Incomplete installation. Missing files"
Sometimes, the anti-virus fix isn''t enough. If you get an error about missing files, then you need to manually download the SoulSplitter component files from Github via the following steps:
1. Close LiveSplit.
2. Go to the [SoulSplitter Github downloads page](https://github.com/FrankvdStam/SoulSplitter/releases).
3. Download the .zip file from whatever is the latest release (do not download the ones named "source code").
4. Extract the .zip file.
5. Navigate to your LiveSplit components folder.
6. Drag the extracted files into the LiveSplit/components folder (replace files if asked).
7. Apply the anti-virus fix explained [here](https://soulsspeedruns.com/livesplit/#troubleshooting).
8. Done!

## Extra Tools for LiveSplit
to be added

## Credits
Thanks to XeroGoesFast for authoring the original LiveSplit guide.
Thanks to B3LYP for releasing the initial Sekiro timer plugin for LiveSplit.
Thanks to RefinedHornet for contributions to the old Sekiro timer.
Thanks to CapitaineToinon for contributions to the old Sekiro timer.
Thanks to Wasted for revolutionizing the Sekiro plugin with the SoulSplitter project.',1,2,'2026-09-30 20:30:34.991043');
INSERT INTO "wiki_revisions" VALUES(78,23,'Pennek','## Pennek
Pennek is a Sekiro Speedrunner.',2,2,'2026-09-30 21:19:48.456274');
CREATE UNIQUE INDEX ix_categories_slug ON categories (slug);
CREATE UNIQUE INDEX ix_wiki_pages_slug ON wiki_pages (slug);
COMMIT;
