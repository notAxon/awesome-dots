#!/bin/bash

# mocp -i | column -t | grep -E "Artist|SongTitle" | cut -c 15- | sed "s/ \+$//"  | paste -d";" -s
mocp -i | column -t | grep -E "Artist|SongTitle" | cut -c 15- | sed "s/ \+$//"  | paste -d"#" -s | sed "s/#/ - /"
