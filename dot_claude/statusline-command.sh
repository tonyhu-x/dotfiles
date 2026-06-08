#!/bin/sh
# Claude Code statusLine — based on Oh My Zsh avit theme

input=$(cat)

cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // ""')
model=$(echo "$input" | jq -r '.model.display_name // ""')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Show last 3 path components (like avit's %3~), replacing $HOME with ~
home="$HOME"
short_path="${cwd/#$home/~}"
# Keep only last 3 components
short_path=$(echo "$short_path" | awk -F'/' '{
  n=NF
  if (n<=3) print $0
  else {
    out=""
    for(i=n-2; i<=n; i++) out=(out=="" ? "" : out "/") $i
    # prefix with ... to indicate truncation
    print ".../" out
  }
}')

# Git branch (skip optional locks)
branch=$(git -C "$cwd" -c core.fsmonitor=false branch --show-current 2>/dev/null)

# Build output
parts=""

# Directory in bold blue (ANSI)
dir_part=$(printf '\033[1;34m%s\033[0m' "$short_path")
parts="$dir_part"

# Git branch in green
if [ -n "$branch" ]; then
  git_part=$(printf '\033[0;32m%s\033[0m' "$branch")
  parts="$parts  $git_part"
fi

# Model name
if [ -n "$model" ]; then
  model_part=$(printf '\033[0;36m%s\033[0m' "$model")
  parts="$parts  $model_part"
fi

# Context usage percentage
if [ -n "$used" ]; then
  used_int=$(printf '%.0f' "$used")
  ctx_part=$(printf '\033[0;33mctx:%s%%\033[0m' "$used_int")
  parts="$parts  $ctx_part"

  COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
  COST_FMT=$(printf '$%.2f' "$COST")
  parts="$parts  $COST_FMT"
fi

printf '%s' "$parts"
