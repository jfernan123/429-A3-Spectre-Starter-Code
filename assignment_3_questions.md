# Assignment 3 – Spectre (Questions)
---

## Background

### Generate a Log File

The first task will be to generate a log file that shows the passage of instructions through the pipeline.

1. Use the following command as tested above, then hit **Ctrl-C** after the first two letters print. Record the tick number that the simulator ended at (e.g., `13062347000`).

   ```bash
   nice -n 19 gem5 configs/learning_gem5/part1/two_level.py spectre
   ```

2. Run gem5 with the debug flag **O3PipeView** enabled.

> **Warning** Make sure the `--debug-start` tick matches the tick from step 1.

```bash
nice -n 19 gem5 --debug-flags=O3PipeView \
  --debug-file=pipeview.txt \
  --debug-start=13062347000 \
  configs/learning_gem5/part1/two_level.py spectre
```

3. Watch the output and stop execution with **Ctrl-C** after **two more letters** appeared than in step 1. This will create at least two instances of speculative side effects we can observe.

4. Run the pipeline viewer with the generated trace file.

> **Tip** The `-w` option specifies the width of the output file, so depending on the size of your terminal you may wish to choose a larger or smaller value.

```bash
$GEM_PATH/util/o3-pipeview.py --store_completions m5out/pipeview.txt --color -w 100
```

5. View the generated file showing the instructions moving through the pipeline:

   ```bash
   less -r o3-pipeview.out
   ```

> **Note** The **timeline** section shows time moving from left to right and shows instructions going through the stages of the pipeline with letters indicating the time they entered each stage and dots for each cycle they remain in that stage. For example `f....dn.p....ic..r` would represent **f**etch, wait 4 cycles, **d**ecode, re**n**ame, wait 1, dis**p**atch, wait 4, **i**ssue, **c**ommit, wait 2, and **r**etire. `l` and `s` denote **l**oad finishing and **s**tore finishing respectively.
>
> The **tick** column shows the simulator tick. The **pc.upc** column shows the instructions along with their addresses. The **disasm** column shows the assembly instructions being executed.
>
> Time will wrap around if an instruction runs out of room in the timeline column. For example, in the following timeline it appears as though issuing, committing and retiring came before fetch, decode and renaming, but this is due to the wraparound:
>
> ```text
> [.......i c..............................................r...s..........................fdn.p.........]
> ```

### Match Vulnerable Instructions

Now that the log file is created we want to match up the instructions executed to the vulnerable section of `spectre.c` code. This will be the next task:

1. Examine the disassembly to find the instruction addresses where speculation is used to leak victim secrets.
2. Once the section of code has been located, write down the address of the relevant instructions. An address looks like `400c12:`
3. With this address, search the log file that was generated earlier to find the part of the log where leaking occurred.

> **Using the **less** command** When in `less`, you can use Vim-style searching. If you want to search for the example address, type `/400c12` and press **Enter**. This will search the log file for the string `400c12`.
>
> If you are in the correct section of the log, you should see many instructions that contain lines like:
>
> ```text
> [================f==================dn========i c===]
> ```
>
> This means that the instruction was squashed due to a misprediction.

4. Attach with your report:

   * The disassembly of the vulnerable code `victim_function` taken from `spectreX86.s`, called `vuln.s`.
   * The section from `o3-pipeview.out` corresponding to addresses in `vuln.s` that shows the squashed instructions in the vulnerable section, called `pipeview-spec.out`.

---

## Questions

### CPU Configuration

1. **(1.5 points)** What is the associativity, cache line size, and capacity for the L1 Data cache used by `two_level.py`? *Tip:* You will need to find the default values used by gem5 when running the script.
2. **(1.5 points)** What are the number of bits for the tag, index, and offset respectively for the L1 Data cache assuming 32-bit addressing?
3. **(1 point)** Why is it necessary to change from the `TimingSimpleCPU` for the attack to be successful?
4. **(3 points)** What change(s) can you make to the parameters of the caches in `configs/learning_gem5/part1/caches.py` that will result in the attack failing? Explain why your changes mitigated the attack.

   *Note:* The attack fails if instead of discovering a letter the program outputs `Unclear`. For example:

   ```text
   Reading at malicious_x = 0xffffffffffdfebb8... Unclear
   ```

### The `spectre.c` File

1. **(1.5 points)** What does the function `cbo_flush` do? Explain the purpose of the calls to it on lines 66 and 71.

   ```c
   for (int i = 0; i < 256; i++) {
     results[i] = 0;
   }
   for (int tries = 100; tries > 0; tries--) {
     /* Flush array2[256*(0..255)] from cache */
     for (int i = 0; i < 256; i++) {
       cbo_flush(&array2[i * 512]);
     }
     /* 30 loops: 5 training runs (x=training_x) per attack run (x=malicious_x) */
     training_x = tries % array1_size;
     for (int j = 29; j >= 0; j--) {
       cbo_flush(&array1_size);
       for (volatile int z = 0; z < 100; z++) {}
       ...
     }
   }
   ```

2. **(2 points)** Which cache lines are “numbered” to communicate a value? Justify your answer.

3. **(2 points)** Why is `victim_function` called with the sequence of five in-bounds values and then an out-of-bounds value?

4. **(1 point)** Why is `malicious_x` initialized to `(size_t)(secret - (char*)array1)`?

5. **(2 points)** What is the purpose of the loop from lines 86–94? How does it achieve this purpose?

   ```c
   /* Time reads. Order is lightly mixed up to prevent stride prediction */
   for (int i = 0; i < 256; i++) {
     int mix_i = ((i * 167) + 13) & 255;
     addr = &array2[mix_i * 512];
     register uint64_t time1 = rdcycle(); /* READ TIMER */
     junk = *addr;                        /* MEMORY ACCESS TO TIME */
     register uint64_t time2 = rdcycle() - time1; /* READ TIMER & COMPUTE ELAPSED TIME */
     if (time2 <= CACHE_HIT_THRESHOLD && mix_i != array1[tries % array1_size]) {
       results[mix_i]++; /* cache hit - add +1 to score for this value */
     }
   }
   ```

6. **(1.5 points)** is defined and accessed with the constant **512** (e.g., on lines 35, 43, 66, and 88).

   a. Why would the attack fail if that constant was changed from 512 to 2 instead?

   b. Why was the constant 512 chosen by the author of the code?

### Log File and Disassembly

1. **(3 points)** Annotate the instructions in `vuln.s` from the function `victim_function`:

   a. Place the comment `#loads array_size1` on the same line as the relevant instruction.

   b. Place the comment `#loads array1[x]`.

   c. Place the comment `#loads array2[array1[x] * 512]`.

2. **(4 points)** Provide the address taken from `pipeview-spec.out` **and** justification for each:

   a. Which instruction has a cache miss?

   b. Which instruction is mispredicted?

   c. Which instruction in `vuln.s` loads the secret value into a register? Is this instruction squashed?

   d. Which instruction perturbs the cache using the secret value?

### Overview

1. **(2 points)** How would the implementation of `cbo_flush` differ between a direct-mapped cache and a fully associative cache? Explain in high-level terms.

2. **(4 points)** How would you change the design of an out-of-order CPU to fix this vulnerability?

   a. How would your change impact CPU performance?

   b. Explain how your suggested change would fix the issue.

3. **(3 points)** *Side channels: Flush+Reload vs. Prime+Probe.* Prime+Probe detects contention in cache sets by having the receiver prime the sets and then probe for evictions.

   **Assume** Sender and Receiver are transmitting the value **127** through a **4-way** set-associative cache using Prime+Probe:

   1. Sender and Receiver agree on cache-set numbering 0–255.
   2. Receiver reads 4 addresses that map to cache set 0; repeats to fill all 256 sets in turn.
   3. Sender reads 1 address that maps to cache set 127, evicting one of Receiver’s lines in set 127.
   4. Receiver reads all 1024 addresses it originally brought into the cache and notices a miss occurred in set 127.
   5. Receiver gets value 127.

   **Question:** Would Flush+Reload and Prime+Probe both transmit data in a fully associative cache? Justify your answer.

---

## Hand-in Checklist

### &#x20; Hand-in Checklist

**(1 point)** The best time to be critical and to offer constructive suggestions about an assignment is soon after you complete it. Please include in your report the following:

1. A narrative description of any difficulties or misunderstandings that made the assignment unnecessarily difficult, or that led you to waste time.
2. Suggestions of changes that could make this assignment more interesting, more relevant, or more challenging in future editions of this course.

**(1 point)** Make use of proper typesetting and overall style.

**(1 point)** Meeting notes: See the [collaboration](https://cmput429.github.io/429-website/docs/policies/assignments/collab) requirements for what to include.

**(1 point)** Partner Evaluation: Please complete the [confidential partner evaluation](https://docs.google.com/forms/d/e/1FAIpQLScBJDjn2iV35X4DD5Bdua4ZEPAWeMQB9FZ-g3HCT2f_324fCw/viewform?usp=sf_link) for your partner. If you complete the evaluation, you get a point.

---
