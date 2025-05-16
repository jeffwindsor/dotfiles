def header  [text] { show $" == ($text) == " cyan_reverse }
def section [text] { show $"== ($text) ==" cyan }
def info [text] { show $text blue }
def success [text] { show $text green }
def fail    [text] { show $text red }
def warning [text] { show $text yellow }
def dimmed  [text] { show $text dark_gray }
def normal  [text] { show $text reset }
def show [text, color] { print $"(ansi $color)($text)(ansi reset)" }
