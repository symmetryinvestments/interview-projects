int main() {
    try {
        run;
        return 0;
    } catch(Exception _) {
        return 1;
    }
}


void run() {
    import median: median;
    import std.random: Random, uniform;
    import std.array: array;
    import std.range: repeat, takeExactly;
    import std.datetime.stopwatch: StopWatch, AutoStart;
    import std.datetime: Duration;
    import std.algorithm: minElement;
    import std.stdio;

    auto vectors = [
        [0],
        [1],
        [2, 3, 1],
        [1, 2, 3, 5, 8, 13, 21, 34],
        42.repeat.takeExactly(1000).array,
    ];

    auto rnd = Random(1337);

    enum numRandomVectors = 100_000;

    foreach(i; 0 .. numRandomVectors) {
        const len = uniform(1, 1000, rnd);
        ++vectors.length;
        foreach(j; 0 .. len) {
            vectors[$-1] ~= uniform(1, 1000, rnd);
        }
    }

    double[] results;
    results.length = vectors.length;

    enum numIterations = 10;
    Duration[numIterations] times;

    foreach(i; 0 .. numIterations) {
        auto sw = StopWatch(AutoStart.yes);
        int j;
        foreach(numbers; vectors) {
            results[j++] = median(numbers);
        }

        sw.stop;
        times[i] = cast(Duration) sw.peek;
    }

    const min = minElement(times[]);
    writeln("Time: ", min);
}
