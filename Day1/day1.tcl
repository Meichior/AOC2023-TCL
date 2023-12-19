proc get_input_data {filename} {
    set fp [open $filename]
    set input_data [read $fp]
    close $fp

    return [split $input_data \n]
}


proc first_last_digits {line} {

    set result ""
    foreach c [split $line ""] { 

        if {[string is digit $c]} {
            set result $result$c
        }
    }
    return [string index $result 0][string index $result end]
}


proc un_spell {line} {
    set li [list one two three four five six seven eight nine]
    set count 1

    foreach num $li {
        set p [string index $num 0]
        set s [string index $num end]
        set line [regsub -all "$num" $line "$p$count$s"]
        incr count
    }
    puts $line
    return $line
}

set input [get_input_data day1]
set sum 0

foreach line $input {
    set line   [un_spell $line]
    set digits [first_last_digits $line]
    set sum    [expr { $sum + $digits }]
}

puts $sum
