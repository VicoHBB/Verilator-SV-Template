# Quartus Assignments

These are `global_assignment` that you can set on `mod_main.qsf` file


> [!IMPORTANT]
> The information provided in this document is property of Intel Corporation and is a summary of
> the content found at [Advanced Synthesis Settings][1].


- `NUM_PARALLEL_PROCESSORS`: Specifies the maximum number of processors allocated for parallel


- `NUM_PARALLEL_PROCESSORS`: Specifies the maximum number of processors allocated for parallel
compilation on a single machine. For parallel compilation you can use all available processors on
your machine, or specify the number of processors you want to use. For example, if you have a
`quad-core` processor machine and want to leave one processor free for other tasks, you specify '3'
as the setting of this option. A setting of '1' disables parallel compilation.
    - `ALL`: Use all available processors.
    - `NUM`: Number of processor that will be used.

- `ALLOW_ANY_SHIFT_REGISTER_SIZE_FOR_RECOGNITION`: Allows the Compiler to infer shift registers of
smaller size than the built-in threshold that synthesis uses.
    - `ON`
    - `OFF`

## References
* [Advanced Synthesis Settings][1]

<!--### References-->
[1]: https://www.intel.com/content/www/us/en/docs/programmable/683236/21-4/advanced-synthesis-settings.html "Advanced Synthesis Settings"
