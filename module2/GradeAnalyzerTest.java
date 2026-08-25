import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;
import java.util.ArrayList;
import java.util.Arrays;

public class GradeAnalyzerTest {

    @Test
    public void testAverageNormalScores() {
        ArrayList<Integer> scores =
                new ArrayList<>(Arrays.asList(90, 80, 70, 60, 50));

        assertEquals(70.0, GradeAnalyzer.calculateAverage(scores), 0.001);
    }

    @Test
    public void testAverageEmptyList() {
        ArrayList<Integer> scores = new ArrayList<>();

        assertEquals(0.0, GradeAnalyzer.calculateAverage(scores), 0.001);
    }

    @Test
    public void testAverageSingleScore() {
        ArrayList<Integer> scores =
                new ArrayList<>(Arrays.asList(95));

        assertEquals(95.0, GradeAnalyzer.calculateAverage(scores), 0.001);
    }

    @Test
    public void testAverageDecimalResult() {
        ArrayList<Integer> scores =
                new ArrayList<>(Arrays.asList(80, 81));

        assertEquals(80.5, GradeAnalyzer.calculateAverage(scores), 0.001);
    }

    @Test
    public void testAverageTenScores() {
        ArrayList<Integer> scores =
                new ArrayList<>(Arrays.asList(
                        100, 90, 80, 70, 60,
                        50, 40, 30, 20, 10));

        assertEquals(55.0, GradeAnalyzer.calculateAverage(scores), 0.001);
    }
}