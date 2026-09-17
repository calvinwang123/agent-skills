#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf '%s\n' 'Usage: sync-skills.sh --source DIR --target DIR --mode symlink|copy [--skill NAME ...] [--only]' >&2
  exit 2
}

source_dir=''
target_dir=''
mode=''
skills=(caveman unslop harness-skill-backup)

while (($#)); do
  case "$1" in
    --source) (($# >= 2)) || usage; source_dir=$2; shift 2 ;;
    --target) (($# >= 2)) || usage; target_dir=$2; shift 2 ;;
    --mode) (($# >= 2)) || usage; mode=$2; shift 2 ;;
    --skill) (($# >= 2)) || usage; skills+=("$2"); shift 2 ;;
    --only) skills=(); shift ;;
    --help|-h) usage ;;
    *) usage ;;
  esac
done

[[ -n "$source_dir" && -n "$target_dir" && -n "$mode" ]] || usage
[[ "$mode" == symlink || "$mode" == copy ]] || usage
[[ -d "$source_dir/skills" ]] || { printf 'Source has no skills directory: %s\n' "$source_dir" >&2; exit 1; }
mkdir -p "$target_dir"

for skill in "${skills[@]}"; do
  [[ "$skill" != */* && "$skill" != .* ]] || { printf 'Refusing unsafe skill name: %s\n' "$skill" >&2; exit 1; }
  source="$source_dir/skills/$skill"
  target="$target_dir/$skill"
  [[ -d "$source" ]] || { printf 'Missing allowlisted source skill: %s\n' "$source" >&2; exit 1; }

  if [[ "$mode" == symlink ]]; then
    if [[ -e "$target" && ! -L "$target" ]]; then
      printf 'Conflict, target is not a symlink: %s\n' "$target" >&2
      exit 1
    fi
    [[ -L "$target" ]] && [[ "$(readlink "$target")" == "$source" ]] && continue
    [[ -L "$target" ]] && rm "$target"
    ln -s "$source" "$target"
  else
    if [[ -L "$target" ]]; then
      rm "$target"
    fi
    mkdir -p "$target"
    cp -a "$source/." "$target/"
  fi
  printf 'Synced %s (%s)\n' "$skill" "$mode"
done
