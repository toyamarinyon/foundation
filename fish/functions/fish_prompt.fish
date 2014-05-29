
function parse_cwd_git
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')

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

  if git rev-parse --verify refs/stash > /dev/null ^&1

    set cwd_git_status $cwd_git_status '$'
  end

  if test (count $cwd_git_status) -gt 0
    echo -n [
    for s in $cwd_git_status
      echo -n $s
    end
    echo -n ]
  end

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

