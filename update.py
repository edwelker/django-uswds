import feedparser
import re
from git import Repo
# import subprocess

url = "https://github.com/18F/web-design-standards/releases.atom"
feed = feedparser.parse(url)

external_versions = [x.title for x in feed.entries]

# makes sure that pull requests don't make it into the version lists
pattern = re.compile("\d+.\d+.\d+")

filtered_external_versions = [x for x in external_versions if pattern.match(x)]

repo = Repo(".")
local_versions = [x.name for x in repo.tags]

local = set(local_versions)
ext = set(filtered_external_versions)

todo = ext.difference(local)

with open('versions.txt', 'w') as file:
    [file.write(x + "\n") for x in todo]

# This doesn't work for some dumb reason, and I don't feel like figuring it out
# Why permission errors?
# for t in todo:
#     subprocess.call(["VERSION={}".format(t), 'make', '-C', '..', 'upload'])
