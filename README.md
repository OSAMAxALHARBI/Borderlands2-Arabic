# تعريب Borderlands 2 | Borderlands 2 Arabic Translation

<div dir="rtl">

تعريب كامل للعبة Borderlands 2 على Steam: اللعبة الأساسية وكل الإضافات (DLC) المثبّتة.

**يشمل:** القوائم، المهمات، الحوارات والترجمة المصاحبة، شاشات التحميل، الأسلحة والأعداء والمهارات والتحديات.

🌐 **صفحة التعريب على موقعي:** [iosamai.com/borderlands-2](https://iosamai.com/borderlands-2/) · كل تعريباتي: [iosamai.com](https://iosamai.com/)

## التحميل
حمّل الملف `Borderlands2-Arabic-1.0.zip` من صفحة [Releases](../../releases/latest).

## التثبيت
1. سكّر اللعبة، وفك ضغط الملف في أي مكان.
2. افتح `BL2Arabic.exe`. إذا طلعت رسالة "Windows protected your PC" اضغط More info ثم Run anyway (البرنامج مو موقّع رقميًا).
3. اختر مجلد اللعبة (البرنامج يلقاه بنفسه غالبًا) واضغط «ثبّت التعريب».
4. شغّل اللعبة واترك لغتها على الإنجليزية.

إذا حدّثت Steam اللعبة: افتح `BL2Arabic.exe` وثبّت التعريب مرة ثانية.

## الإزالة
افتح `BL2Arabic.exe` واضغط «أزل التعريب». يرجع كل ملف إلى أصله.
يحفظ البرنامج نسخة من كل ملف يغيّره في مجلد `BL2-Arabic-backup` داخل مجلد اللعبة.
إذا برنامج الحماية منع `BL2Arabic.exe`: ملفات `Install.ps1` و `Uninstall.ps1` تسوي نفس الشي (كليك يمين ← Properties ← Unblock، وبعدين كليك يمين ← Run with PowerShell).

## يبقى بالإنجليزية
أسماء المناطق التي تظهر عند دخولها (مكتوبة داخل خرائط اللعبة)، الأسماء التجارية، وقائمة المطورين.

</div>

---

## English

Arabic translation of Borderlands 2 (Steam): the base game and every installed DLC: menus, missions, dialogue and
subtitles, loading screens, weapons, enemies, skills and challenges.

🌐 **Translation page:** [iosamai.com/en/borderlands-2](https://iosamai.com/en/borderlands-2/) · all my translations: [iosamai.com/en](https://iosamai.com/en/)

**Download:** `Borderlands2-Arabic-1.0.zip` from [Releases](../../releases/latest).

**Install**
1. Close the game and extract the zip anywhere.
2. Open `BL2Arabic.exe`. If "Windows protected your PC" appears, click More info, then Run anyway (the program is not
   digitally signed).
3. Choose the game folder (the program usually finds it) and click "Install".
4. Start the game with the language set to English.

If Steam updates the game, open `BL2Arabic.exe` and install the translation again.

**Uninstall:** open `BL2Arabic.exe` and click "Uninstall". Every original file is put back.
The program keeps a copy of every file it changes in `BL2-Arabic-backup` inside the game folder.
If your antivirus blocks `BL2Arabic.exe`: `Install.ps1` and `Uninstall.ps1` do the same (right-click > Properties >
Unblock, then right-click > Run with PowerShell).

**Still in English:** area names shown when you enter an area (they are written inside the game's maps), brand
names, and the credits.

Works with the Steam version (build 9218157).

### How it works
The game checks two of its packages against hashes stored in `Borderlands2.exe`; the installer
(`BL2Arabic.exe`, source in [`app`](app); or `Install.ps1`) finds those two entries in your own copy of the exe, checks that they hold the original values, backs
the exe up and writes the new values. The other files (two font packages and the text files) are copied in after
the originals are backed up. The scripts and the program's source in this repository are the same ones that are inside the zip.

### Credits
- Translation: Osama (iOsamai)
- Arabic font: IBM Plex Sans Arabic, SIL Open Font License 1.1 (`licenses/OFL-IBMPlexSansArabic.txt`)
- Borderlands 2 © Gearbox Software / 2K. This is an unofficial fan translation. You need your own copy of the game.
