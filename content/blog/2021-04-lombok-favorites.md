My favorite lombok annotations are:

# For POJOs

```
import lombok.Value;
import lombok.extern.jackson.Jacksonized;
import lombok.Builder;

@Value
@Jacksonized
@Builder(toBuilder = true)
public class Pojo {
    // ...
}
```

Why?

* `Value` creates an immutable Pojo. In a multi-threading world, we should all
  favor immutable objects.
* `Jacksonized` adds methods to make the immutable interoprate with Jackson serialization.
* `Builder` allows for a fluent API for POJO creation, and adding the `toBuilder` flag
  makes it possible to convet your POJO back into a builder if you need to change just a few fields of the POJO.

# For Logging

```
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class Service {
    // ...
}
```

This makes logging so much easier, since that gives you an implicit `log` field.

# For Exception Handling

```
lombok.SneakyThrows;

public class Impl implements Iface {
    @Override
    @SneakyThrows
    public void method() {
        throw new Exception();
    }
}
```

Sometimes you are implementing a `java.util.function.*` interface and yet you need to throw an exception,
so what do you do? Simply add the `@SneakyThrows` annotation... although it seems to create controversy
for those that like their typed exceptions. Unfortunately, the real world is sometimes cruel and such hacks
are necessary.

Note that you can also create wrappers around some of these `@FunctionalInterface`s to deal with this
problem. For example, if you need a `BiConsumer` that can throw exceptions:

```
import java.util.function.BiConsumer;
import lombok.Lombok;

@FunctionalInterface
interface ThrowingBiConsumer<T, V> extends BiConsumer<T, V> {
    @Override
    default void accept(final T t, final V v) {
        try {
            acceptThrows(t, v);
        } catch (Throwable ex) {
            Lombok.sneakyThrow(ex);
        }
    }

    void acceptThrows(T t, V v) throws Throwable;
}
```