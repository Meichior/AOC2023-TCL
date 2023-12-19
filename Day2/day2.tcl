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
   
    foreach red   $reds   { if {$red   > 12}  {return 0} }
    foreach green $greens { if {$green > 13}  {return 0} }
    foreach blue  $blues  { if {$blue  > 14}  {return 0} }

    return 1
}


proc validate_game {line} {
    #\d+(?= r) -> look behind " r" for 1 or more digits
    set reds   [regexp -all -inline {\d+(?= r)} $line]
    set greens [regexp -all -inline {\d+(?= g)} $line]
    set blues  [regexp -all -inline {\d+(?= b)} $line]

    if { [is_legit $reds $greens $blues]} {
        set id [get_gameID $line]
    } else {
        set id 0
    }

    if {[llength $reds] != 0} {
         set big_r  [lindex [lsort -integer -decreasing $reds] 0]
    } else {
        set big_r 1
    }
    
    if {[llength $greens] != 0} {
        set big_g  [lindex [lsort -integer -decreasing $greens] 0]
    } else {
        set big_g 1
    }

    if {[llength $blues] != 0} {
        set big_b  [lindex [lsort -integer -decreasing $blues]  0]
    } else {
        set big_b 1
    }

    set power [expr {$big_r * $big_g * $big_b}]
    puts $power
    return [list $id $power]
}


set input [get_input_data "day2"]
set sumID 0
set sum_power 0
foreach line $input {
    set game_result [validate_game $line] 
    set sumID     [expr { $sumID     + [lindex $game_result 0]}]
    set sum_power [expr { $sum_power + [lindex $game_result 1]}]
}

puts $sumID
puts $sum_power
