#!/bin/bash
set -euo pipefail
cd

backup_dir="Backups/bear/$(date +%Y-%m-%d)"
mkdir -p $backup_dir/
rsync -avzP ~/Library/Containers/net.shinyfrog.bear/Data/Documents/Application\ Data $backup_dir/
