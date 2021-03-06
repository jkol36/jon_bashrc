export BASH_CONF="bashrc"
export CLICOLOR=1
ulimit -n 1000000 unlimited
# some more ls aliases

sendMessage() {
    #sends an imessage to a user'
    cd ~/development; cd tasks; python tasks.py Message "$@"
}
startHustling(){
	#starts a new programming sprint
	cd ~/development; cd programming_sprint; python main.py startSprint
}


hackernews() {
  # Set the default limit to 90 (3 lines * 30 articles) lines or use 3 times
  # the given value.
  if [ "$limit" = "" ]
  then
    limit=90
  else
    limit=$((3 * $limit))
  fi

  # GNU sed uses -r for expanded regular expressions but OS X does not use GNU
  # sed. Instead it relies on -E argument.
  sed_attributes="-re"
  if [ "`uname`" = "Darwin" ]
  then
    sed_attributes="-Ee"
  fi

  attributes="title|link"
  curl -s "https://news.ycombinator.com/rss" |
    grep -Eio "<item>.*</item>" |
    grep -Eio "<($attributes)>[^<>]*</($attributes)>" |
    sed $sed_attributes "s/<title>([^<>]*)<\/title>/$highlight_title\1/" \
        -e "s/<link>([^<>]*)<\/link>/$highlight_link\1★/" \
        -e "s/&#x2F;/\//g" \
        -e "s/&#x27;/'/g" |
    tr "★" "\n" |
    head -n $limit
  printf "\033[0m"
}


alias startSprint=startSprint
alias lyrics=showLyrics
alias sendMessage=sendMessage
alias globalNpmModules='cd /usr/local/lib/node_modules/'
alias sendMessage=sendMessage
alias ll='ls -alh'
alias la='ls -A'
alias l='ls -CFlh'
alias woo='fortune'
alias lsd="ls -alF | grep /$"
alias newReactProject="git clone https://github.com/kriasoft/react-starter-kit.git MyApp"

# This is GOLD for finding out what is taking so much space on your drives!
alias diskspace="du -S | sort -n -r |more"

# Command line mplayer movie watching for the win.
alias mp="mplayer -fs"

# Show me the size (sorted) of only the folders in this directory
alias folders="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"

# This will keep you sane when you're about to smash the keyboard again.
alias frak="fortune"

# This is where you put your hand rolled scripts (remember to chmod them)
PATH="$HOME/bin:$PATH"

!/usr/bin/env bash

# Copyright (c) 2012--2016 Harish Narayanan <mail@harishnarayanan.org>
#
# Contains numerous helpful contributions from Jorge Colindres, Thomas
# Pritchard, iLan Epstein, Gabriele Bonetti, Sean Heller and Eric
# Martin.

# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:

# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
# BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
# ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# showHelp () {
#     echo "Usage:";
#     echo;
#     echo "  `basename $0` <command>";
#     echo;
#     echo "Commands:";
#     echo;
#     echo "  play                         # Resumes playback where Spotify last left off.";
#     echo "  play <song name>             # Finds a song by name and plays it.";
#     echo "  play album <album name>      # Finds an album by name and plays it.";
#     echo "  play artist <artist name>    # Finds an artist by name and plays it.";
#     echo "  play list <playlist name>    # Finds a playlist by name and plays it.";
#     echo "  play uri <uri>               # Play songs from specific uri.";
#     echo;
#     echo "  next                         # Skips to the next song in a playlist.";
#     echo "  prev                         # Returns to the previous song in a playlist.";
#     echo "  replay                       # Replays the current track from the begining.";
#     echo "  pos <time>                   # Jumps to a time (in secs) in the current song.";
#     echo "  pause                        # Pauses Spotify playback.";
#     echo "  quit                         # Stops playback and quits Spotify.";
#     echo;
#     echo "  vol up                       # Increases the volume by 10%.";
#     echo "  vol down                     # Decreases the volume by 10%.";
#     echo "  vol <amount>                 # Sets the volume to an amount between 0 and 100.";
#     echo "  vol [show]                   # Shows the current Spotify volume.";
#     echo;
#     echo "  status                       # Shows the current player status.";
#     echo;
#     echo "  share                        # Displays the current song's Spotify URL and URI."
#     echo "  share url                    # Displays the current song's Spotify URL and copies it to the clipboard."
#     echo "  share uri                    # Displays the current song's Spotify URI and copies it to the clipboard."
#     echo;
#     echo "  toggle shuffle               # Toggles shuffle playback mode.";
#     echo "  toggle repeat                # Toggles repeat playback mode.";
# }

# cecho(){
#     bold=$(tput bold);
#     green=$(tput setaf 2);
#     reset=$(tput sgr0);
#     echo $bold$green"$1"$reset;
# }

# showStatus () {
#     state=`osascript -e 'tell application "Spotify" to player state as string'`;
#     cecho "Spotify is currently $state.";
#     artist=`osascript -e 'tell application "Spotify" to artist of current track as string'`;
#     album=`osascript -e 'tell application "Spotify" to album of current track as string'`;
#     track=`osascript -e 'tell application "Spotify" to name of current track as string'`;
#     duration=`osascript -e 'tell application "Spotify"
#             set durSec to (duration of current track / 1000) as text
#             set tM to (round (durSec / 60) rounding down) as text
#             if length of ((durSec mod 60 div 1) as text) is greater than 1 then
#                 set tS to (durSec mod 60 div 1) as text
#             else
#                 set tS to ("0" & (durSec mod 60 div 1)) as text
#             end if
#             set myTime to tM as text & ":" & tS as text
#             end tell
#             return myTime'`;
#     position=`osascript -e 'tell application "Spotify"
#             set pos to player position
#             set nM to (round (pos / 60) rounding down) as text
#             if length of ((round (pos mod 60) rounding down) as text) is greater than 1 then
#                 set nS to (round (pos mod 60) rounding down) as text
#             else
#                 set nS to ("0" & (round (pos mod 60) rounding down)) as text
#             end if
#             set nowAt to nM as text & ":" & nS as text
#             end tell
#             return nowAt'`;

#     echo -e $reset"Artist: $artist\nAlbum: $album\nTrack: $track \nPosition: $position / $duration";
# }

# spotify(){
# 	if [ $# = 0 ]; then
#     showHelp;
# 	else
# 	    if [ $(osascript -e 'application "Spotify" is running') = "false" ]; then
# 	        osascript -e 'tell application "Spotify" to activate'
# 	        sleep 2
# 	    fi
# 	fi
# 	while [ $# -gt 0 ]; do
# 	    arg=$1;

# 	    case $arg in
# 	        "play"    )
# 	            if [ $# != 1 ]; then
# 	                # There are additional arguments, so find out how many
# 	                array=( $@ );
# 	                len=${#array[@]};
# 	                SPOTIFY_SEARCH_API="https://api.spotify.com/v1/search"
# 	                SPOTIFY_PLAY_URI="";

# 	                searchAndPlay() {
# 	                    type="$1"
# 	                    Q="$2"

# 	                    cecho "Searching ${type}s for: $Q";

# 	                    SPOTIFY_PLAY_URI=$( \
# 	                        curl -s -G $SPOTIFY_SEARCH_API --data-urlencode "q=$Q" -d "type=$type&limit=1&offset=0" -H "Accept: application/json" \
# 	                        | grep -E -o "spotify:$type:[a-zA-Z0-9]+" -m 1
# 	                    )
# 	                }

# 	                case $2 in
# 	                    "list"  )
# 	                        _args=${array[@]:2:$len};
# 	                        Q=$_args;

# 	                        cecho "Searching playlists for: $Q";

# 	                        results=$( \
# 	                            curl -s -G $SPOTIFY_SEARCH_API --data-urlencode "q=$Q" -d "type=playlist&limit=10&offset=0" -H "Accept: application/json" \
# 	                            | grep -E -o "spotify:user:[a-zA-Z0-9_]+:playlist:[a-zA-Z0-9]+" -m 10 \
# 	                        )

# 	                        count=$( \
# 	                            echo "$results" | grep -c "spotify:user" \
# 	                        )

# 	                        if [ "$count" -gt 0 ]; then
# 	                            random=$(( $RANDOM % $count));

# 	                            SPOTIFY_PLAY_URI=$( \
# 	                                echo "$results" | awk -v random="$random" '/spotify:user:[a-zA-Z0-9]+:playlist:[a-zA-Z0-9]+/{i++}i==random{print; exit}' \
# 	                            )
# 	                        fi;;

# 	                    "album" | "artist" | "track"    )
# 	                        _args=${array[@]:2:$len};
# 	                        searchAndPlay $2 "$_args";;

# 	                    "uri"  )
# 	                        SPOTIFY_PLAY_URI=${array[@]:2:$len};;

# 	                    *   )
# 	                        _args=${array[@]:1:$len};
# 	                        searchAndPlay track "$_args";;
# 	                esac

# 	                if [ "$SPOTIFY_PLAY_URI" != "" ]; then
# 	                    if [ "$2" = "uri" ]; then
# 	                        cecho "Playing Spotify URI: $SPOTIFY_PLAY_URI";
# 	                    else
# 	                        cecho "Playing ($Q Search) -> Spotify URI: $SPOTIFY_PLAY_URI";
# 	                    fi

# 	                    osascript -e "tell application \"Spotify\" to play track \"$SPOTIFY_PLAY_URI\"";

# 	                else
# 	                    cecho "No results when searching for $Q";
# 	                fi

# 	            else

# 	                # play is the only param
# 	                cecho "Playing Spotify.";
# 	                osascript -e 'tell application "Spotify" to play';
# 	            fi
# 	            break ;;

# 	        "pause"    )
# 	            state=`osascript -e 'tell application "Spotify" to player state as string'`;
# 	            if [ $state = "playing" ]; then
# 	              cecho "Pausing Spotify.";
# 	            else
# 	              cecho "Playing Spotify.";
# 	            fi

# 	            osascript -e 'tell application "Spotify" to playpause';
# 	            break ;;

# 	        "quit"    ) cecho "Quitting Spotify.";
# 	            osascript -e 'tell application "Spotify" to quit';
# 	            exit 1 ;;

# 	        "next"    ) cecho "Going to next track." ;
# 	            osascript -e 'tell application "Spotify" to next track';
# 	            showStatus;
# 	            break ;;

# 	        "prev"    ) cecho "Going to previous track.";
# 	            osascript -e '
# 	            tell application "Spotify"
# 	                set player position to 0
# 	                previous track
# 	            end tell';
# 	            showStatus;
# 	            break ;;

# 	        "replay"  ) cecho "Replaying current track.";
# 	            osascript -e 'tell application "Spotify" to set player position to 0'
# 	            break ;;

# 	        "vol"    )
# 	            vol=`osascript -e 'tell application "Spotify" to sound volume as integer'`;
# 	            if [[ $2 = "" || $2 = "show" ]]; then
# 	                cecho "Current Spotify volume level is $vol.";
# 	                break ;
# 	            elif [ "$2" = "up" ]; then
# 	                if [ $vol -le 90 ]; then
# 	                    newvol=$(( vol+10 ));
# 	                    cecho "Increasing Spotify volume to $newvol.";
# 	                else
# 	                    newvol=100;
# 	                    cecho "Spotify volume level is at max.";
# 	                fi
# 	            elif [ "$2" = "down" ]; then
# 	                if [ $vol -ge 10 ]; then
# 	                    newvol=$(( vol-10 ));
# 	                    cecho "Reducing Spotify volume to $newvol.";
# 	                else
# 	                    newvol=0;
# 	                    cecho "Spotify volume level is at min.";
# 	                fi
# 	            elif [[ $2 =~ ^[0-9]+$ ]] && [[ $2 -ge 0 && $2 -le 100 ]]; then
# 	                newvol=$2;
# 	                cecho "Setting Spotify volume level to $newvol";
# 	            else
# 	                echo "Improper use of 'vol' command"
# 	                echo "The 'vol' command should be used as follows:"
# 	                echo "  vol up                       # Increases the volume by 10%.";
# 	                echo "  vol down                     # Decreases the volume by 10%.";
# 	                echo "  vol [amount]                 # Sets the volume to an amount between 0 and 100.";
# 	                echo "  vol                          # Shows the current Spotify volume.";
# 	                break
# 	            fi

# 	            osascript -e "tell application \"Spotify\" to set sound volume to $newvol";
# 	            break ;;

# 	        "toggle"  )
# 	            if [ "$2" = "shuffle" ]; then
# 	                osascript -e 'tell application "Spotify" to set shuffling to not shuffling';
# 	                curr=`osascript -e 'tell application "Spotify" to shuffling'`;
# 	                cecho "Spotify shuffling set to $curr";
# 	            elif [ "$2" = "repeat" ]; then
# 	                osascript -e 'tell application "Spotify" to set repeating to not repeating';
# 	                curr=`osascript -e 'tell application "Spotify" to repeating'`;
# 	                cecho "Spotify repeating set to $curr";
# 	            fi
# 	            break ;;

# 	        "status" )
# 	            showStatus;
# 	            break ;;

# 	        "info" )
# 	            info=`osascript -e 'tell application "Spotify"
# 	                set durSec to (duration of current track / 1000)
# 	                set tM to (round (durSec / 60) rounding down) as text
# 	                if length of ((durSec mod 60 div 1) as text) is greater than 1 then
# 	                    set tS to (durSec mod 60 div 1) as text
# 	                else
# 	                    set tS to ("0" & (durSec mod 60 div 1)) as text
# 	                end if
# 	                set myTime to tM as text & "min " & tS as text & "s"
# 	                set pos to player position
# 	                set nM to (round (pos / 60) rounding down) as text
# 	                if length of ((round (pos mod 60) rounding down) as text) is greater than 1 then
# 	                    set nS to (round (pos mod 60) rounding down) as text
# 	                else
# 	                    set nS to ("0" & (round (pos mod 60) rounding down)) as text
# 	                end if
# 	                set nowAt to nM as text & "min " & nS as text & "s"
# 	                set info to "" & "\nArtist:         " & artist of current track
# 	                set info to info & "\nTrack:          " & name of current track
# 	                set info to info & "\nAlbum Artist:   " & album artist of current track
# 	                set info to info & "\nAlbum:          " & album of current track
# 	                set info to info & "\nSeconds:        " & durSec
# 	                set info to info & "\nSeconds played: " & pos
# 	                set info to info & "\nDuration:       " & mytime
# 	                set info to info & "\nNow at:         " & nowAt
# 	                set info to info & "\nPlayed Count:   " & played count of current track
# 	                set info to info & "\nTrack Number:   " & track number of current track
# 	                set info to info & "\nPopularity:     " & popularity of current track
# 	                set info to info & "\nId:             " & id of current track
# 	                set info to info & "\nSpotify URL:    " & spotify url of current track
# 	                set info to info & "\nArtwork:        " & artwork url of current track
# 	                set info to info & "\nPlayer:         " & player state
# 	                set info to info & "\nVolume:         " & sound volume
# 	                set info to info & "\nShuffle:        " & shuffling
# 	                set info to info & "\nRepeating:      " & repeating
# 	            end tell
# 	            return info'`
# 	            cecho "$info";
# 	            break ;;

# 	        "share"     )
# 	            uri=`osascript -e 'tell application "Spotify" to spotify url of current track'`;
# 	            remove='spotify:track:'
# 	            url=${uri#$remove}
# 	            url="http://open.spotify.com/track/$url"

# 	            if [ "$2" = "" ]; then
# 	                cecho "Spotify URL: $url"
# 	                cecho "Spotify URI: $uri"
# 	                echo "To copy the URL or URI to your clipboard, use:"
# 	                echo "\`spotify share url\` or"
# 	                echo "\`spotify share uri\` respectively."
# 	            elif [ "$2" = "url" ]; then
# 	                cecho "Spotify URL: $url";
# 	                echo -n $url | pbcopy
# 	            elif [ "$2" = "uri" ]; then
# 	                cecho "Spotify URI: $uri";
# 	                echo -n $uri | pbcopy
# 	            fi
# 	            break;;

# 	        "pos"   )
# 	            cecho "Adjusting Spotify play position."
# 	            osascript -e "tell application \"Spotify\" to set player position to $2";
# 	            break;;

# 	        "help" | * )
# 	            showHelp;
# 	            break ;;
# 	    esac
# 	done

# }

