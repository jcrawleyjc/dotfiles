date=`date`

init: git-init force-restore
restore: brew-cleanup pull-changes brew-bundle
update: brew-dump push-changes

verify:
	if [ ! -d ".private" ]; then \
			echo ".private does not exist!"; \
			exit 1; \
	fi

install-homebrew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

force-restore:
	git fetch
	echo "" > .Brewfile
	brew bundle cleanup --force --global
	git reset --hard origin/master
	make restore

git-init:
	rm -rf ./.git
	git init
	git remote add origin git@github.com:jcrawleyjc/dotfiles.git
	git checkout master
  git pull origin master

pull-changes:
	git pull origin master
	git submodule update --recursive --remote

brew-bundle:
	brew bundle --verbose --global

brew-dump:
	brew bundle dump --force --global

brew-cleanup:
	brew bundle cleanup --force --global
