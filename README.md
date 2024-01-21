# YouTube.htm
Backup github page providing a fallback for the SuperMemo YouTube script

Uses youtube.supermemo.org by default and falls back to GitHub if it is down.

## Instructions

SM 18/19:

- Replace YouTube.htm in <SuperMemo_install_folder>/bin with YouTube.htm from this repo.

Want to host your own?:  

- Fork this repo. Run patch_and_dl.ps1 to generate files locally, commit and publish to github pages. Change sBaseBackupUrl to host your own.

## Troubleshooting/Sec warnings

If you get annoying Security warnings every time, change in SuperMemo/bin/YouTube.htm the varable titled "HEADER TIMEOUT" value to 1. This will always use GitHub pages and not load from the supermemo server.

## Looking for more? 

Memleak fix, offline video archival and transcript viewer in SuperMemo 

[Supermemo.js](https://github.com/pattontim/supermemo.js)