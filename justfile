code := "code-insiders"
Code := "Code - Insiders"

syncfrom target:
    rsync -avP {{ target }}:~/codes/nvim/ ~/.config/nvim/ --delete
    rsync -avP {{ target }}:~/.local/share/nvim/ ~/.local/share/nvim/ --delete
    rsync -avP {{ target }}:~/.local/share/bob/ ~/.local/share/bob/ --delete
    rsync -avP {{ target }}:~/.cache/nvim/ ~/.cache/nvim/ --delete
    rsync -avP {{ target }}:~/codes/nvim-plugins/ ~/codes/nvim-plugins/ --delete
    git apply jk.patch

syncto target:
    -rsync -avP ~/codes/nvim/ {{ target }}:~/.config/nvim/ --delete
    -rsync -avP ~/.local/share/nvim/ {{ target }}:~/.local/share/nvim/ --delete --exclude mason
    # -rsync -avPL ~/.local/share/nvim/mason/ {{ target }}:~/.local/share/nvim/mason/ --delete
    -rsync -avP ~/.local/share/bob/ {{ target }}:~/.local/share/bob/ --delete
    -rsync -avP ~/.cache/nvim/ {{ target }}:~/.cache/nvim/ --delete
    -rsync -avP ~/codes/nvim-plugins/ {{ target }}:~/codes/nvim-plugins/ --delete

pager:
    ln -sf ~/.config/nvim ~/.config/nvimpager
    ln -sf ~/.local/share/nvim ~/.local/share/nvimpager

install-arch:
    yay -S ttf-maple-beta-nf-cn

setup: && export-ext
    for f in $(ls -d vscode/*.json); do ln -sf "$(realpath "$f")" "$HOME/.config/{{ Code }}/User/$(basename $f)"; done

export-ext:
    # ${{ code }} --list-extensions | jq -R '[inputs] | {"recommendations": .}' > .vscode/extensions.json
    {{ code }} --list-extensions > vscode/extensions-list.txt

import-ext:
    xargs -L1 {{ code }} --install-extension < vscode/extensions-list.txt
