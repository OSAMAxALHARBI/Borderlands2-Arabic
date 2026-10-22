# تعريب Borderlands 2 | Borderlands 2 Arabic Translation

<div dir="rtl">

تعريب كامل للعبة Borderlands 2 على Steam: اللعبة الأساسية وكل الإضافات (DLC) المثبّتة.

**يشمل:** القوائم، المهمات، الحوارات والترجمة المصاحبة، شاشات التحميل، الأسلحة والأعداء والمهارات والتحديات.

## التحميل
حمّل الملف `Borderlands2-Arabic-1.0.zip` من صفحة [Releases](../../releases/latest).

## التثبيت
1. فك الضغط عن الملف في أي مكان، مثلًا داخل مجلد اللعبة.
2. اضغط بزر الفأرة الأيمن على `Install.ps1` واختر **Run with PowerShell**.
3. شغّل اللعبة واترك لغتها على الإنجليزية.

إذا حدّثت Steam اللعبة: شغّل `Install.ps1` مرة أخرى.

## الإزالة
اضغط بزر الفأرة الأيمن على `Uninstall.ps1` واختر **Run with PowerShell**. يرجع كل ملف إلى أصله.
يحفظ المثبّت نسخة من كل ملف يغيّره في مجلد `BL2-Arabic-backup` داخل مجلد اللعبة.

## يبقى بالإنجليزية
أسماء المناطق التي تظهر عند دخولها (مكتوبة داخل خرائط اللعبة)، الأسماء التجارية، وقائمة المطورين.

</div>

---

## English

Arabic translation of Borderlands 2 (Steam): the base game and every installed DLC: menus, missions, dialogue and
subtitles, loading screens, weapons, enemies, skills and challenges.

**Download:** `Borderlands2-Arabic-1.0.zip` from [Releases](../../releases/latest).

**Install**
1. Extract the zip anywhere, for example inside the game folder.
2. Right-click `Install.ps1` and choose **Run with PowerShell**.
3. Start the game with the language set to English.

If Steam updates the game, run `Install.ps1` again.

**Uninstall:** right-click `Uninstall.ps1` and choose **Run with PowerShell**. Every original file is put back.
The installer keeps a copy of every file it changes in `BL2-Arabic-backup` inside the game folder.

**Still in English:** area names shown when you enter an area (they are written inside the game's maps), brand
names, and the credits.

Works with the Steam version (build 9218157).

### How it works
No `.exe` is included. The game checks two of its packages against hashes stored in `Borderlands2.exe`;
`Install.ps1` finds those two entries in your own copy of the exe, checks that they hold the original values, backs
the exe up and writes the new values. The other files (two font packages and the text files) are copied in after
the originals are backed up. The scripts in this repository are the same ones that are inside the zip.

### Credits
- Translation: Osama (iOsamai)
- Arabic font: IBM Plex Sans Arabic, SIL Open Font License 1.1 (`licenses/OFL-IBMPlexSansArabic.txt`)
- Borderlands 2 © Gearbox Software / 2K. This is an unofficial fan translation. You need your own copy of the game.
