# -*- zsh -*-
#
# $Id: .zshrc,v 1.20 2010/04/22 07:02:58 rnc Exp $
#
# .zshrc is sourced in interactive shells.  It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#

### Configuration file may contain
#
# Prefix where useful things are stored in the users file system
# PREFIX=xxx
# e.g. brew-koji zsh completion code. For example set it to $HOME/Work/Miscellaneous
# PREFIX is added to the fpath and used to source zsh-git-prompt.
#
# Any other functions etc can also be put in here.
[[ -f $HOME/.shell-configuration ]] && source $HOME/.shell-configuration

# Source ZSH functions.
fpath=($PREFIX/brew-koji/zsh $PREFIX/zsh-completions/src $fpath)

####################################
#### Set various options. ##########
####################################

setopt \
ALL_EXPORT \
ALWAYS_TO_END \
ALWAYS_LAST_PROMPT \
APPEND_HISTORY \
AUTO_CD \
NO_AUTO_LIST \
AUTO_MENU \
AUTO_NAME_DIRS \
NO_AUTO_PARAM_KEYS \
AUTO_PARAM_SLASH \
AUTO_PUSHD \
AUTO_REMOVE_SLASH \
NO_AUTO_RESUME \
BAD_PATTERN \
BANG_HIST \
BARE_GLOB_QUAL \
BASH_AUTO_LIST \
NO_BEEP \
NO_BG_NICE \
NO_BRACE_CCL \
NO_BSD_ECHO \
NO_CDABLE_VARS \
CHASE_DOTS \
NO_CHASE_LINKS \
CHECK_JOBS \
NO_CLOBBER \
NO_COMPLETE_ALIASES \
COMPLETE_IN_WORD \
CORRECT \
CORRECT_ALL \
NO_CSH_JUNKIE_HISTORY \
NO_CSH_JUNKIE_LOOPS \
NO_CSH_JUNKIE_QUOTES \
NO_CSH_NULLCMD \
NO_DVORAK \
EQUALS \
NO_ERR_EXIT \
EXEC \
EXTENDED_GLOB \
NO_EXTENDED_HISTORY \
FLOW_CONTROL \
FUNCTION_ARGZERO \
GLOB \
GLOBAL_EXPORT \
NO_GLOBAL_RCS \
GLOB_COMPLETE \
GLOB_DOTS \
NO_GLOB_SUBST \
HASH_CMDS \
HASH_DIRS \
HASH_LIST_ALL \
NO_HIST_ALLOW_CLOBBER \
NO_HIST_BEEP \
HIST_EXPIRE_DUPS_FIRST \
HIST_FIND_NO_DUPS \
HIST_IGNORE_ALL_DUPS \
HIST_IGNORE_DUPS \
HIST_IGNORE_SPACE \
NO_HIST_NO_FUNCTIONS \
NO_HIST_NO_STORE \
HIST_REDUCE_BLANKS \
HIST_SAVE_NO_DUPS \
NO_HIST_VERIFY \
NO_HUP \
NO_IGNORE_BRACES \
IGNORE_EOF \
INC_APPEND_HISTORY \
INTERACTIVE_COMMENTS \
NO_KSH_ARRAYS \
NO_KSH_AUTOLOAD \
NO_KSH_GLOB \
NO_KSH_OPTION_PRINT \
LIST_AMBIGUOUS \
NO_LIST_BEEP \
NO_LIST_PACKED \
LIST_ROWS_FIRST \
LIST_TYPES \
LONG_LIST_JOBS \
MAGIC_EQUAL_SUBST \
NO_MAIL_WARNING \
MARK_DIRS \
NO_MENU_COMPLETE \
MONITOR \
MULTIOS \
NO_NOMATCH \
NOTIFY \
NO_NULL_GLOB \
NO_NUMERIC_GLOB_SORT \
NO_OCTAL_ZEROES \
NO_OVERSTRIKE \
NO_PATH_DIRS \
NO_PRINT_EIGHT_BIT \
NO_PRINT_EXIT_VALUE \
NO_PRIVILEGED \
NO_PROMPT_BANG \
PROMPT_CR \
PROMPT_PERCENT \
PROMPT_SUBST \
PUSHD_IGNORE_DUPS \
NO_PUSHD_MINUS \
NO_PUSHD_SILENT \
PUSHD_TO_HOME \
NO_RC_EXPAND_PARAM \
NO_RC_QUOTES \
RCS \
NO_REC_EXACT \
NO_RESTRICTED \
NO_RM_STAR_SILENT \
NO_RM_STAR_WAIT \
SHARE_HISTORY \
NO_SH_FILE_EXPANSION \
NO_SH_GLOB \
NO_SHIN_STDIN \
NO_SH_NULLCMD \
NO_SH_OPTION_LETTERS \
NO_SHORT_LOOPS \
NO_SH_WORD_SPLIT \
NO_SINGLE_COMMAND \
NO_SINGLE_LINE_ZLE \
NO_SUN_KEYBOARD_HACK \
UNSET \
NO_VERBOSE \
NO_XTRACE


###########################################
##### autoload functions ##################
#########################'#################

# Autoload all shell functions from all directories in $fpath
autoload $^fpath/*(N.)
autoload -U add-zsh-hook

if [ "$TERM" = "xterm" ] || [ "$TERM" = "linux" ] || [ "$TERM" = "aixterm" ] || [ "$TERM" = "rxvt" ] || [ "$TERM" = "xterm-256color" ] || [ "$TERM" = "screen-256color" ]
then
    # ZSH-Syntax-Highlighting
    if [ -d $PREFIX/fast-syntax-highlighting ]
    then
        fpath=($PREFIX/fast-syntax-highlighting $fpath)
        source $PREFIX/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
    elif [ -d $PREFIX/zsh-syntax-highlighting ]
    then
        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
        source $PREFIX/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

        ZSH_HIGHLIGHT_STYLES[path]='fg=251'
        ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=251'
        ZSH_HIGHLIGHT_STYLES[path_approx]='fg=251'
        ZSH_HIGHLIGHT_STYLES[globbing]='fg=045'
    fi

    : ${PROMPT_SYMBOL:="❯"}

    # Python handling
    [[ -d $PREFIX/zsh-autoswitch-virtualenv ]] && source $PREFIX/zsh-autoswitch-virtualenv/autoswitch_virtualenv.plugin.zsh
    RPROMPT="%{"$'\e[0;35m'"%}$([[ -v VIRTUAL_ENV ]] && basename $VIRTUAL_ENV)%{"$'\e[00m%}'" %T"

    # Different git prompt systems
    #
    # https://github.com/woefe/git-prompt.zsh
    if [ -d $PREFIX/git-prompt.zsh ]
    then
        ZSH_GIT_PROMPT_SHOW_STASH=1
        ZSH_THEME_GIT_PROMPT_UNSTAGED="%F{yellow}✚%f"
        ZSH_THEME_GIT_PROMPT_SUFFIX="]"
        ZSH_THEME_GIT_PROMPT_STASHED="%{"$'\e[0;33;40m'"%}⚑"

        source $PREFIX/git-prompt.zsh/git-prompt.zsh

        # This prompt uses the above GIT system.
        PROMPT='$(gitprompt)$PROMPT_JAVA$PROMPT_EXTRA ${PROMPT_SYMBOL} '
        function prompt_updater ()
        {
            # Prompt turns red if the previous command didn't exit with 0
            PROMPT="$(gitprompt)$PROMPT_JAVA$PROMPT_EXTRA %(?.%B%F{magenta}.%F{red})${PROMPT_SYMBOL}%f%b "
            RPROMPT="%{"$'\e[0;35m'"%}$([[ -v VIRTUAL_ENV ]] && basename $VIRTUAL_ENV)%{"$'\e[00m%}'" %T"
        }
        add-zsh-hook precmd prompt_updater
    # https://github.com/yonchu/zsh-vcs-prompt/
    elif [ -d $PREFIX/zsh-vcs-prompt ]
    then
        autoload -U is-at-least
        if ! is-at-least 5.0.5
        then
            echo "ZSH Version must be at least 5.0.5"
        else
            typeset -g update_prompt_fd
            PROMPT='%m[waiting]$PROMPT_JAVA$PROMPT_EXTRA $ '

            source $PREFIX/zsh-vcs-prompt/zshrc.sh
            ZSH_VCS_PROMPT_ENABLE_CACHING='true'
            ZSH_VCS_PROMPT_UNSTAGED_SIGIL='✚'
            ZSH_VCS_PROMPT_AHEAD_SIGIL='↑'
            ZSH_VCS_PROMPT_BEHIND_SIGIL='↓'
            ZSH_VCS_PROMPT_STAGED_SIGIL='●'
            ZSH_VCS_PROMPT_CONFLICTS_SIGIL='✖'
            ZSH_VCS_PROMPT_UNSTAGED_SIGIL='✚'
            ZSH_VCS_PROMPT_UNTRACKED_SIGIL='…'
            ZSH_VCS_PROMPT_STASHED_SIGIL='⚑'
            ZSH_VCS_PROMPT_CLEAN_SIGIL='✔'
            ZSH_VCS_PROMPT_MERGE_BRANCH=
            ZSH_VCS_PROMPT_USING_PYTHON='false'

            # Code to update in background proposed by Bart Schaefer
            # http://www.zsh.org/mla/users/2014/msg00448.html
            function internal_vcs_super_info()
            {
                _zsh_vcs_prompt_precmd_hook_func
                vcs_super_info
            }

            function update_super_status ()
            {
                PROMPT="%m$(read -rE -u$1)$PROMPT_JAVA$PROMPT_EXTRA $ "  # double quotes, not promptsubst
                RPROMPT="%{"$'\e[0;35m'"%}$([[ -v VIRTUAL_ENV ]] && basename $VIRTUAL_ENV)%{"$'\e[00m%}'" %T"
                update_prompt_fd=0
                zle -F $1           # Remove the handler
                exec {1}>&-         # Close the descriptor
                zle reset-prompt
            }

            function vcs_chpwd ()
            {
                if zle -l update_super_status
                then
                    PROMPT='%m[waiting]$PROMPT_JAVA$PROMPT_EXTRA %(?.%B%F{magenta}.%F{red})${PROMPT_SYMBOL}%f%b '
                fi
            }

            function vcs_precmd ()
            {
                emulate -L zsh

                if zle -l update_super_status
                then
                    (( update_prompt_fd )) && zle -F $update_prompt_fd >/dev/null
                    exec {update_prompt_fd}<<( internal_vcs_super_info )
                    zle -F -w $update_prompt_fd update_super_status
                fi
            }

            zle -N update_super_status

            # Remove hook to use delayed prompt init.
            add-zsh-hook -d precmd _zsh_vcs_prompt_precmd_hook_func
            add-zsh-hook precmd vcs_precmd
            add-zsh-hook chpwd vcs_chpwd
        fi
    # https://github.com/starcraftman/zsh-git-prompt
    elif [ -d $PREFIX/zsh-git-prompt ]
    then
        export ZSH_THEME_GIT_PROMPT_STASHED_ACTIVE=1
        export __GIT_PROMPT_DIR=$PREFIX/zsh-git-prompt
        source $PREFIX/zsh-git-prompt/zshrc.sh

        # This prompt uses the above GIT system.
        PROMPT="%m$(git_super_status)$PROMPT_JAVA$PROMPT_EXTRA %(?.%B%F{magenta}.%F{red})${PROMPT_SYMBOL}%f%b "

        function prompt_updater ()
        {
            PROMPT="%m$(git_super_status)$PROMPT_JAVA$PROMPT_EXTRA %(?.%B%F{magenta}.%F{red})${PROMPT_SYMBOL}%f%b "
            RPROMPT="%{"$'\e[0;35m'"%}$([[ -v VIRTUAL_ENV ]] && basename $VIRTUAL_ENV)%{"$'\e[00m%}'" %T"
        }
        add-zsh-hook precmd prompt_updater
    else
        echo "Resorting to default prompt."

        PROMPT='%m$PROMPT_JAVA$PROMPT_EXTRA %(?.%B%F{magenta}.%F{red})${PROMPT_SYMBOL}%f%b '
    fi
elif [ "$TERM" = "dumb" ]
then
    # Dumb terminal might be e.g. emacs.
    # https://github.com/syl20bnr/spacemacs/issues/3035
    export EDITOR=emacsclient
    unset zle_bracketed_paste
fi

########################################
#### Key Bindings ######################
########################################

#
# Remember - try doing ctrl-v [key we wish to get esc sequence e.g. ctrl-h]
#

bindkey "^Z" undo
bindkey '\xfd' backward-delete-word

# Plain up/down arrow moves between lines or searches history for substring.
autoload up-line-or-beginning-search
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Ctrl-up/down arrow will move through local history while up/down arrow
# will move through shared history
bindkey '^[[1;5A' up-line-or-local-history
bindkey '^[[1;5B' down-line-or-local-history
function up-line-or-local-history()
{
    NUMERIC=1 zle set-local-history
    zle up-line-or-history
    NUMERIC=0 zle set-local-history
}
function down-line-or-local-history()
{
    NUMERIC=1 zle set-local-history
    zle down-line-or-history
    NUMERIC=0 zle set-local-history
}
zle -N up-line-or-local-history
zle -N down-line-or-local-history

# Backward delete appears to be correct as ^H on all platforms

# Foward Delete
if [ "$ARCH" = "i686" ]
then
    bindkey '^[[3~' delete-char
else
   bindkey '^?' backward-delete-char
   bindkey '^[[3~' delete-char
fi

# Complete in the middle of some text ignoring the suffix.
bindkey '^i' expand-or-complete-prefix

# Move to end/beginning of line.
if [ -n "$TMUX" ]
then
    bindkey '^[[1~' beginning-of-line
    bindkey '^[[4~' end-of-line
else
    bindkey '^[[H' beginning-of-line
    bindkey '^[[F' end-of-line
fi

#########################################
#### File system options ################
#########################################

umask 002

#################################
#### remove shell limits ########
#################################

unlimit

#################################
#### history , mail      ########
#################################

HISTFILE=$HOME/.history
HISTSIZE=10000
SAVEHIST=10000

#################
### Functions ###
#################

add-zsh-hook preexec title_preexec
add-zsh-hook precmd title_precmd

# Instead of using chpwd just use zsh built in which is executed
# just before prompt is drawn. chpwd can clash with functions.
function title_precmd ()
{
    title
}

# From http://zshwiki.org/home/examples/hardstatus
# Used by preexec to print '<pwd> : <cmd>'
function title () {
    # The hardcoded limit is because KDE konsole only appears to support 74
    # characters for a title. See
    # http://www.debian-administration.org/articles/548
    #
    # Previously was just using %~ but named directory expansion means
    # that just printed JACORB_DIR which is not very helpful.
    [[ -n "$SSH_CONNECTION" ]] && local rhs="$HOST:"
    if (( $# > 0 ))
    then
        # If we have a command (with args) then take it and truncate it
        # as konsole tabs explode otherwise
        local arg=$(echo $*)
        print -nR $'\033]0;'$rhs${arg[1,54]}...$'\a'
    else
        local cwd="`print -Pn \"%74<..<${PWD/$HOME/~}\"`"
        print -nR $'\033]0;'$rhs$cwd$'\a'
    fi
}

function title_preexec()
{
  emulate -L zsh

  local -a cmd; cmd=(${(z)1})             # Re-parse the command line

  # Construct a command that will output the desired job number.
  case $cmd[1] in
      fg)
        if (( $#cmd == 1 )); then
          # No arguments, must find the current job
          cmd=(builtin jobs -l %+)
        else
          # Replace the command name, ignore extra args.
          cmd=(builtin jobs -l ${(Q)cmd[2]})
        fi;;
       %*) cmd=(builtin jobs -l ${(Q)cmd[1]});; # Same as "else" above
       exec) shift cmd;& # If the command is 'exec', drop that, because
          # we'd rather just see the command that is being
          # exec'd. Note the ;& to fall through.
       *)  title $cmd[1]:t "$cmd[2,-1]"    # Not resuming a job,
          return;;                        # so we're all done
      esac

  local -A jt; jt=(${(kv)jobtexts})       # Copy jobtexts for subshell

  # Run the command, read its output, and look up the jobtext.
  # Could parse $rest here, but $jobtexts (via $jt) is easier.
  $cmd >>(read num rest
          cmd=(${(z)${(e):-\$jt$num}})
          title $cmd[1]:t "$cmd[2,-1]") 2>/dev/null
}

# Show current status of ZSH options (from mailing list).
function showoptions()
{
  local k
  zmodload -i zsh/parameter

  for k in ${(ok)options}; do
    printf "%-20s\t%s\n" $k ${options[$k]}
  done
}

# This is used in conjunction with the git alias tagcommit in gitconfig file.
# This allows the tagcommit alias to use rev-parse completion.
_git-tagcommit () { _git-rev-parse "$@" }


#
# Get common aliases and functions
#
source $HOME/.commonshell
source $HOME/.aliases
[[ -f $HOME/.corbashell ]] && source $HOME/.corbashell

#################
### Autoloads ###
#################

autoload -U compinit && compinit
autoload -U zmv

alias cpz='noglob zmv -W -C'
alias mvz='noglob zmv -W'

rpm -q rhpkg > /dev/null
if [ "$?" = 0 ]
then
    if [ `bc<<<"$(rpm -q --queryformat '%{VERSION}\n' rhpkg)>=1.31"` = "1" ]
    then
        autoload -U +X bashcompinit && bashcompinit
        # This hack removes usage of lower case path variable which conflicts in ZSH.
        tmprhpg=$(mktemp -q)
        cat /etc/bash_completion.d/rhpkg.bash | sed 's/path=/tmppath=/g;s/\$path/\$tmppath/g' >! $tmprhpg
        source $tmprhpg
        rm -f $tmprhpg
    fi
fi
##############
### Styles ###
##############

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zcache

# # Maximum spelling errors allowed
#zstyle ':completion:*' max-errors 2
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Ignore parent directory
# Useful for cd, mv and cp. Ex, cd will never select the parent directory (ie cd ../<TAB>):
zstyle ':completion:*:(cd|mv|cp):*' ignore-parents parent pwd

zstyle ':completion:*' completer _complete _ignored _approximate
#zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
# If you end up using a directory as argument, this will remove the trailing slash (useful in ln):
zstyle ':completion:*' squeeze-slashes true


zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:messages' format $'%{\e[0;31m%}%d%{\e[0m%}'
zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for: %d%{\e[0m%}'
zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
zstyle ':completion:*' group-name ''
#zstyle ':completion:*' format 'Completing %d'
#zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select

# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
# zstyle :compinstall filename '/home/rnc/.zshrc'

zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"

# Make completion lists scrollable so "do you wish to see all n possibilities"
# is no longer displayed.
zstyle ':completion:*' list-prompt '%p'

# End of lines added by compinstall

# http://michael.stapelberg.de/Artikel/zsh_recent_completion
# 'ctrl-x r' will complete the 12 last modified (mtime) files/directories
zle -C newest-files complete-word _generic
bindkey '^Xr' newest-files
zstyle ':completion:newest-files:*' completer _files
zstyle ':completion:newest-files:*' file-patterns '*~.*(omN[1,12])'
zstyle ':completion:newest-files:*' menu select yes
zstyle ':completion:newest-files:*' sort false
zstyle ':completion:newest-files:*' matcher-list 'b:=*' # important


# Delegate the completion
# http://stackoverflow.com/questions/4221239/zsh-use-completions-for-command-x-when-i-type-command-y
#
# For makemead make completion
compdef _make makemead
# For rgit git completion
compdef '_dispatch git git' rgit
