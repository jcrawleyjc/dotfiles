date=`date`

init: verify
restore: brew-cleanup force-restore
update: brew-dump push-changes

verify:
	if [ ! -d ".private" ]; then \
			echo ".private does not exist!"; \
			exit 1; \
	fi

install-homebrew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$$(/opt/homebrew/bin/brew shellenv)"' > "$$HOME/.zprofile"
	eval "$$(/opt/homebrew/bin/brew shellenv)"

force-restore:
	git fetch
	echo "" > .Brewfile
	brew bundle cleanup --force --global
	git reset --hard origin/master
	make restore

git-init:
	rm -rf ./.git
	rm -rf ./.gitconfig
	git init
	git remote add origin git@github.com:jcrawleyjc/dotfiles.git

push-changes:
	git add -A
	git commit -m "dotfiles update on ${date}"
	git push origin master

pull-changes:
	git pull origin master
	git submodule update --recursive --remote

brew-bundle:
	brew bundle --verbose --global

brew-dump:
	brew bundle dump --force --global

brew-cleanup:
	brew bundle cleanup --force --global
