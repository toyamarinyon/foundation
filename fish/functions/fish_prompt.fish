
function parse_cwd_git
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  # set -l uncommitted (git diff --quiet --ignore-submodules --cached)
  set -l unstaged (git diff-files --quiet --ignore-submodules --)
  set -l untracked (test -n (git ls-files --others --exclude-standard))
  set -l stashed (git rev-parse --verify refs/stash 2>/dev/null)

  set -l cwd_git_status

  set_color cyan
  echo -n $branch

  if test -z (git diff --quiet --ignore-submodules --cached; and echo "not-uncommited")
    set cwd_git_status $cwd_git_status '+'
  end

  if test -z (git diff-files --quiet --ignore-submodules --;and echo "not-unstaged")
    set cwd_git_status $cwd_git_status '!'
  end

  if test (count (git ls-files --others --exclude-standard)) -gt 0
    set cwd_git_status $cwd_git_status '?'
  end

  if git rev-parse --verify refs/stash 2>/dev/null
    set cwd_git_status $cwd_git_status '\$'
  end

  if test (count $cwd_git_status) -gt 0
    echo -n [
    for s in $cwd_git_status
      echo -n $s
    end
    echo -n ]
  end


  #
  # if $untracked
  #   set -l status $status?
  # end
  #
  # if $stashed
  #   set -l status $status\$
  # end
  #
  # set -l git_diff (git diff)
  #
  # if test -n "$git_diff"
  #   echo (set_color $fish_git_dirty_color)$branch(set_color normal)
  # else
  #   echo (set_color $fish_git_not_dirty_color)$branch(set_color normal)
  # end

  # echo $branch[$status]
  set_color normal
end

function funcy_status
  if test (count $argv) -gt 0 -a $argv[1] -ne 0
    echo (set_color red)"(*;-;) < "(set_color normal)
  else
    echo (set_color normal)"(*'-') < "
  end
end

function fish_prompt
  set last_command_status $status
  if test -d .git
    printf '\n%s%s%s: %s%s%s on %s\n%s ' (set_color green) (who | awk '{print $1}') (set_color normal) (set_color brown) (pwd) (set_color normal) (parse_cwd_git) (funcy_status $last_command_status)
  else
    printf '\n%s%s%s: %s%s ' (set_color green) (who | awk '{print $1}') (set_color normal) (set_color brown) (pwd) (set_color normal) (funcy_status $last_command_status)
  end
end

