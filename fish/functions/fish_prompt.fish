set fish_git_dirty_color red
set fish_git_not_dirty_color green

function parse_git_branch
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  set -l git_diff (git diff)

  if test -n "$git_diff"
    echo (set_color $fish_git_dirty_color)$branch(set_color normal)
  else
    echo (set_color $fish_git_not_dirty_color)$branch(set_color normal)
  end
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
    printf '\n%s%s%s on %s\n%s ' (set_color $fish_color_cwd) (pwd) (set_color normal) (parse_git_branch) (funcy_status $last_command_status)
  else
    printf '\n%s%s%s\n%s ' (set_color $fish_color_cwd) (pwd) (set_color normal) (funcy_status $last_command_status)
  end
end

