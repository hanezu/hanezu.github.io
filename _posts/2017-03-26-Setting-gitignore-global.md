---
layout: post
title: "Setting gitignore global"
categories: journal
tags: [config, gitignore]
---

1. TOC
{:toc}

# ~/.gitignore\_global

## create it

Setting the global ignore file for git can solve the problem of having to git rm all the files that we don't want. These files normally can be detected by their file type.

If you don't have a `.gitignore\_global` file yet, create it from `~/` first, and write the files you don't want just as if you are configuring a local gitignore file.

## write the files you dislike

I copy the config from [here:](http://stackoverflow.com/questions/107701/how-can-i-remove-ds-store-files-from-a-git-repository)

*~/.gitignore\_global*


```

# Compiled source #
###################
*.com
*.class
*.dll
*.exe
*.o
*.so

# Packages #
############
# it's better to unpack these files and commit the raw source
# git has its own built in compression methods
*.7z
*.dmg
*.gz
*.iso
*.jar
*.rar
*.tar
*.zip

# Logs and databases #
######################
*.log
*.sql
*.sqlite

# OS generated files #
######################
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
thumbs.db
Thumbs.db
```

## Add more custom choice

I often write using vim and sometimes write the file without closing it. So `.swp` files will remain, which is annoying. So I added

```

# Vim swap files
*.swp

```

## Add to global git config

In the end, add this file to your global git config:

`git config --global core.excludesfile ~/.gitignore_global`



