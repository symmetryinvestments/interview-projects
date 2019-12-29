import std.range.primitives: isInputRange, ElementType;
import std.traits: Unqual;


double median(R)(R numbers)
    if(isInputRange!R && is(Unqual!(ElementType!R) == int))
{
    import std.array: empty, front, array;
    import std.algorithm: sort;

    if(numbers.empty)
        throw new Exception("No median for empty range");

    auto arr = numbers.array;
    sort(arr);

    const bool isOdd = arr.length % 2;

    return isOdd
        ? arr[arr.length / 2]
        : (arr[arr.length / 2 - 1] + arr[arr.length / 2]) / 2.0;
}
