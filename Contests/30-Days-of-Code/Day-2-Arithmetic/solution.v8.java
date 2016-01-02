import java.util.*;

public class Arithmetic {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);
        double mainPrice = sc.nextDouble();
        int tipPercentage = sc.nextInt();
        int taxPercentage = sc.nextInt();

        int total = (int) Math.round(
            mainPrice
            + (mainPrice * tipPercentage)/100
            + (mainPrice * taxPercentage)/100
        );

        System.out.println("The final price of the meal is $" + total + ".");

    }
}
