
# Nerd Fonts

This is font-patcher python script (and required source files) from a Nerd Fonts release.

## Running

* To execute run: `fontforge --script ./font-patcher --complete <YOUR FONT FILE>`
* For more CLI options and help: `fontforge --script ./font-patcher --help`

## Further info

For more information see:
* https://github.com/ryanoasis/nerd-fonts/
* https://github.com/ryanoasis/nerd-fonts/releases/latest/

## Version
This archive is created from

        commit 6c7910e5384637473913df084327c556ac507928
        Author: Fini Jastrow <ulf.fini.jastrow@desy.de>
        Date:   Sun Aug 3 13:33:44 2025 +0200
        
            font-patcher: Link to icon sources in patched fonts
            
            [why]
            Some icon sets require mentioning of the original author, and we do this
            on the website. But there is no indication that we have that list.
            
            [how]
            Remove the comment about the changelog (usually you look at the
            changelog at the repo before you install a new font) and substitute it
            for a link to the icon repo list.
            
            Related: #1908
            
            Signed-off-by: Fini Jastrow <ulf.fini.jastrow@desy.de>
