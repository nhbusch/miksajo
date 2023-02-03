Miksajo
------------
A .NET 5 test project.

The project uses a common binary output directory.

## Building
To build the project for a specific build configuration, run
```
build.cmd -configuration <configuration>
```

To test the project, run
```
build.cmd -test
```

Alternatively, run the test project directly via
```
dotnet test src/factorial.test/factorial.test.csproj
```

In both cases, the project will be automatically rebuilt and dependencies restored, if necessary.

## License
Miksajo is licensed under the [MIT License][license].
See [LICENSE](LICENSE) for details.

<!-- Links -->
[license]: https://opensource.org/licenses/MIT