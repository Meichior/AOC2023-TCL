proc get_input_data {filename} {
    set fp [open $filename]
    set input_data [read $fp]
    close $fp

    return [split $input_data \n]
}

proc sum_color {colors} {

    if {[llength $colors] == 0} {return 0}
    set sum 0    

    foreach amount $colors {
        set sum [expr {$sum + $amount}]
    }

    return $sum
}

proc get_gameID {line} {

    set id [regexp -inline {(\d+):}  $line]

    return [lindex $id 1]
}


proc is_legit {reds greens blues} {
   
    foreach red   $reds   { if {$red > 12}   {return 0} }
    foreach green $greens { if {$green > 13} {return 0} }
    foreach blue  $blues  { if {$blue > 14}  {return 0} }

    return 1
}


proc validate_game {line} {
    #\d+(?= r) -> look behind " r" for 1 or more digits
    set reds   [regexp -all -inline {\d+(?= r)} $line]
    set greens [regexp -all -inline {\d+(?= g)} $line]
    set blues  [regexp -all -inline {\d+(?= b)} $line]

    if { [is_legit $reds $greens $blues]} {
        return [get_gameID $line]
    }

    return 0
}


set input [get_input_data day2]
set sum 0
foreach line $input {
    set sum [expr { $sum + [validate_game $line] }]
}

puts $sum