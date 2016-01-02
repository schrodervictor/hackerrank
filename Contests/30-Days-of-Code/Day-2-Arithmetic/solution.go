package main

import (
    "bufio"
    "fmt"
    "os"
    "strconv"
    "strings"
    "math"
)

func readLineAsFloat(reader *bufio.Reader) float64 {
    valueStr, _ := reader.ReadString('\n')
    value, _ := strconv.ParseFloat(strings.TrimRight(valueStr, "\r\n"), 64)
    return value
}

func main() {
    reader := bufio.NewReader(os.Stdin)

    mealPrice := readLineAsFloat(reader)
    tipPercentage := readLineAsFloat(reader)
    taxPercentage := readLineAsFloat(reader)

    total := mealPrice + (mealPrice*(tipPercentage+taxPercentage))/100

    fmt.Printf("The final price of the meal is $%.0f.", math.Floor(total + .5))
}
