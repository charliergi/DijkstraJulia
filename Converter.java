

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

/**
 * Created by Sami on 01/12/2016.
 */
public class Converter {
    public static float[][] matrix;

    public static void readFile(String f) {
        try {
            BufferedReader br = new BufferedReader(new FileReader(f));
            br.readLine();
            String s = br.readLine();
            if (s.contains("graph")) {
                br.readLine();
                int nodes = 0;
                while (!(s = br.readLine()).contains("]")) {
                    if (s.contains("node")) {
                        br.readLine();
                        while (!(s = br.readLine()).contains("]"));
                        nodes += 1;
                    } else if (s.contains("edge")){
                        if (matrix == null) {
                            matrix = new float[nodes][nodes];
                            for (int i = 0; i < nodes; i++) {
                                for (int j = 0; j < nodes; j++) {
                                    matrix[i][j] = 0;
                                }
                            }
                        }
                        br.readLine();
                        int source = 0, target = 0;
                        float weight = 1;
                        while (!(s = br.readLine()).contains("]")) {
                            if (s.contains("source")) {
                                String[] split = s.split(" ");
                                source = Integer.parseInt(split[5]);
                            } else if (s.contains("target")) {
                                String[] split = s.split(" ");
                                target = Integer.parseInt(split[5]);
                            } else if (s.contains("value")) {
                                System.out.println(s);
                                String[] split = s.split(" ");
                                weight = Float.parseFloat(split[5]);
                            }
                        }
                        matrix[source][target] = weight;
                        matrix[target][source] = weight;
                    }
                }
            }
            br.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);
        readFile(s.nextLine());
        System.out.print("[");
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                System.out.print(matrix[i][j] + " ");
            }
            System.out.println(";");
        }
        System.out.print("]");
        s.close();
    }
}