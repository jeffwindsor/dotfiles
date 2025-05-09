def header  [text] { show $" == ($text) == " blue true }
def section [text] { show $"== ($text) ==" blue }
def success [text] { show $text green }
def fail    [text] { show $text red }
def warning [text] { show $text yellow }
def dimmed  [text] { show $text dark_gray }
def normal  [text] { show $text reset }
def show [text, color, reverse=false] {
  $"(ansi (if $reverse {$"($color)_reverse"} else {$color}))($text)(ansi reset)"
}
