#!/usr/bin/zsh

function scd {
  local directory_to_find="$1"

  if [[ -z "$directory_to_find" ]]; then
    echo "Error: Please provide a directory name to find."
    return 1
  fi

  local results=$(fdfind --type directory $directory_to_find)
  if [[ -z "$results" ]]; then
    echo "Error: No directories found."
    return
  fi

  # Check if there's only one result (avoid fzf prompt)
  if [[ $(echo "$results" | wc -l) -eq 1 ]]; then
    local dir=$(echo "$results")
  else
    local dir=$(echo "$results" | fzf --delimiter=" " --tac)
  fi

  if [[ -d "$dir" ]]; then
    cd "$dir"
    pwd  # Print the current working directory after successful cd
  else
    echo "Error: '$dir' is not a directory."
  fi
}
