import java.io.*;
import java.util.ArrayList;

public class GradeAnalyzer {

    public static void main(String[] args) {
        ArrayList<Integer> scores = readScores("scores.txt");

        if (scores.isEmpty()) {
            System.out.println("No valid scores found.");
            return;
        }

        double avg = calculateAverage(scores);

        int high = Integer.MIN_VALUE;
        int low = Integer.MAX_VALUE;

        int countA = 0;
        int countB = 0;
        int countC = 0;
        int countD = 0;
        int countF = 0;

        for (int score : scores) {
            if (score > high) {
                high = score;
            }

            if (score < low) {
                low = score;
            }

            if (score >= 90) {
                countA++;
            } else if (score >= 80) {
                countB++;
            } else if (score >= 70) {
                countC++;
            } else if (score >= 60) {
                countD++;
            } else {
                countF++;
            }
        }

        writeReport(scores, avg, high, low,
                countA, countB, countC, countD, countF,
                "report.txt");
    }

    public static ArrayList<Integer> readScores(String filename) {
        ArrayList<Integer> scores = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            String line;

            while ((line = reader.readLine()) != null) {
                line = line.trim();

                if (line.isEmpty()) {
                    continue;
                }

                try {
                    int score = Integer.parseInt(line);
                    scores.add(score);
                } catch (NumberFormatException e) {
                    System.out.println("Warning: invalid score skipped: " + line);
                }
            }

        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
        }

        return scores;
    }

    public static double calculateAverage(ArrayList<Integer> scores) {
        if (scores.isEmpty()) {
            return 0.0;
        }

        double total = 0;

        for (int score : scores) {
            total += score;
        }

        return total / scores.size();
    }

    public static void writeReport(
            ArrayList<Integer> scores,
            double avg,
            int high,
            int low,
            int countA,
            int countB,
            int countC,
            int countD,
            int countF,
            String outputFile) {

        String report = String.format(
                "=== Grade Analysis Report ===%n" +
                "Total scores processed: %d%n%n" +
                "Average score: %.2f%n" +
                "Highest score: %d%n" +
                "Lowest score: %d%n%n" +
                "Grade distribution:%n" +
                "  A (90-100): %d%n" +
                "  B (80-89):  %d%n" +
                "  C (70-79):  %d%n" +
                "  D (60-69):  %d%n" +
                "  F (below 60): %d%n",
                scores.size(), avg, high, low,
                countA, countB, countC, countD, countF);

        System.out.print(report);

        try (BufferedWriter writer =
                     new BufferedWriter(new FileWriter(outputFile))) {
            writer.write(report);
        } catch (IOException e) {
            System.out.println("Error writing report: " + e.getMessage());
        }
    }
}