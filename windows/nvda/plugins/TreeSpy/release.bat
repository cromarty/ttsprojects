@echo off

del TreeSpy*.nvda-addon

7z a -tzip -mx=9 TreeSpy-1.0.nvda-addon globalPlugins\TreeSpy.py manifest.ini license.txt

