import unit_threaded;
import median: median;


@("empty")
unittest {
    int[] empty;
    median(empty).shouldThrowWithMessage("No median for empty range");
}


@("one")
unittest {
    median([-1]).should == -1;
    median([0]).should == 0;
    median([1]).should == 1;
    median([42]).should == 42;
}

@("two")
unittest {
    median([1, 2]).should == 1.5;
    median([2, 1]).should == 1.5;
    median([2, 3]).should == 2.5;
    median([3, 2]).should == 2.5;
}


@("three")
unittest {
    import std.random: Random, uniform;

    median([1, 2, 3]).should == 2;
    median([2, 3, 4]).should == 3;
    median([-1, -2, -3]).should == -2;
    median([3, 1, 2]).should == 2;


    auto numbers = [-2000, 0, 2000];
    auto rnd = Random(1337);
    foreach(i; 0 .. 10) {
        numbers[1] = uniform(1, 1000, rnd);
        median(numbers).should == numbers[1];
    }
}


@("more")
unittest {
    median([2, 4, 1, 3]).should == 2.5;
    median([1, 2, 3, 5]).should == 2.5;
    median([1, 3, 4, 2, 6, 5, 8, 7]).should == 4.5;
}


@("shuffle")
unittest {
    import std.random: Random, randomShuffle;
    check!((int[] numbers) {
            if(numbers == []) return true; // ignore empty array
            const expected = median(numbers);
            randomShuffle(numbers);
            return median(numbers) == expected;
        }
    );
}
