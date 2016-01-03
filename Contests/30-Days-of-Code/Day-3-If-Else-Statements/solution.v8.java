import java.util.*;

public class Solution {

    public static void main(String[] args) {

        int n = (new Scanner(System.in)).nextInt();

        String ans = "Not Weird";

        if (n % 2 == 1 || (n >= 6 && n <= 20)) {
            ans = "Weird";
        }

        System.out.println(ans);
    }
}
