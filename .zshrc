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
HIST_IGNORE_DUPS \
NO_HIST_ALLOW_CLOBBER \
NO_HIST_BEEP \
HIST_EXPIRE_DUPS_FIRST \
HIST_FIND_NO_DUPS \
HIST_IGNORE_ALL_DUPS \
HIST_IGNORE_DUPS \
NO_HIST_IGNORE_SPACE \
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

# ZSH-Syntax-Highlighting
if [ -d $PREFIX/zsh-syntax-highlighting ]
then
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    source $PREFIX/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    ZSH_HIGHLIGHT_STYLES[path]='fg=251'
    ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=251'
    ZSH_HIGHLIGHT_STYLES[path_approx]='fg=251'
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=045'
fi

if [ "$TERM" = "xterm" ] || [ "$TERM" = "linux" ] || [ "$TERM" = "aixterm" ] || [ "$TERM" = "rxvt" ] || [ "$TERM" = "xterm-256color" ]
then
    # Using https://github.com/rnc/zsh-git-prompt / Fork branch
    if [ -d $PREFIX/zsh-git-prompt ]
    then
        export ZSH_THEME_GIT_PROMPT_STASHED_ACTIVE=1
        export __GIT_PROMPT_DIR=$PREFIX/zsh-git-prompt
        source $PREFIX/zsh-git-prompt/zshrc.sh

        # This prompt uses the above GIT system.
        PROMPT='%m$(git_super_status)$PROMPT_JAVA $ '
    else
        echo "$PREFIX/zsh-git-prompt does not exist."

        PROMPT='%m$PROMPT_JAVA $ '
    fi

    RPROMPT='%T'
fi

########################################
#### Key Bindings ######################
########################################

#
# Remember - try doing ctrl-v [key we wish to get esc sequence e.g. ctrl-h]
#

#bindkey "" list-choices
#bindkey "\C- " set-mark-command
#bindkey "\C-w" kill-region
#bindkey '^H'   delete-char
#bindkey -e
bindkey "^Z" undo
bindkey '\xfd' backward-delete-word
bindkey '\xff' history-beginning-search-backward
bindkey '\xfe' history-beginning-search-forward

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

# Instead of using chpwd just use zsh built in which is executed
# just before prompt is drawn. chpwd can clash with functions.
precmd () {
    title
}

# From http://zshwiki.org/home/examples/hardstatus
# Used by preexec to print '<pwd> : <cmd>'
title () {
    # The hardcoded limit is because KDE konsole only appears to support 74
    # characters for a title. See
    # http://www.debian-administration.org/articles/548
    #
    # Previously was just using %~ but named directory expansion means
    # that just printed JACORB_DIR which is not very helpful.
    [[ -n "$SSH_CONNECTION" ]] && local rhs="$HOST:"
    if (( $# > 0 ))
    then
        print -nR $'\033]0;'$rhs`print -Pn "%74<..<${PWD/$HOME/~} : "``echo $*`$'\a'
    else
        local cwd=`print -Pn "%74<..<${PWD/$HOME/~}"`
        print -nR $'\033]0;'$rhs$cwd$'\a'
    fi
}

preexec() {
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
showoptions() {
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
[[ -f $HOME/.corbashell ]] && source $HOME/.corbashell


#################
### Autoloads ###
#################

autoload -U compinit && compinit
autoload -U zmv

alias cpz='noglob zmv -W -C'
alias mvz='noglob zmv -W'


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
