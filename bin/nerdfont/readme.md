
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

        commit ae179415ec9d61063c4ec0074763def226f06e24
        Author: Fini Jastrow <ulf.fini.jastrow@desy.de>
        Date:   Wed Jan 15 16:10:00 2025 +0100
        
            font-patcher: Allow absolute paths on Windows
            
            [why]
            On Windows an absolute path can start with the drive letter followed by
            a colon. When we sanitize the pathname the colon is replaced by an
            underscore.
            
            [how]
            Add special handling on Windows.
            
            Signed-off-by: Fini Jastrow <ulf.fini.jastrow@desy.de>
