---
title: Michael Abrash's Graphics Programming Black Book, Special Edition
author: Michael Abrash
date: '1997-07-01'
isbn: '1576101746'
publisher: The Coriolis Group
category: 'Web and Software Development: Game Development,Web and Software Development:
  Graphics and Multimedia Development'
chapter: '0'
pages: '0'
---

Michael Abrash's Graphics Programming Black Book Special Edition
----------------------------------------------------------------

1.  [Introduction](intro.html)
2.  [Foreword](about.html)
3.  [About the Author](about_author.html)
4.  [Part I](01-01.html)
    1.  [Chapter 1—The Best Optimizer Is between Your
        Ears](01-01.html#Heading1)
        -   [The Human Element of Code
            Optimization](01-01.html#Heading2)
        -   [Understanding High Performance](01-01.html#Heading3)
            -   [When Fast Isn't Fast](01-01.html#Heading4)
        -   [Rules for Building High-Performance
            Code](01-02.html#Heading5)
            -   [Know Where You're Going](01-02.html#Heading6)
            -   [Make a Big Map](01-02.html#Heading7)
            -   [Make Lots of Little Maps](01-02.html#Heading8)
            -   [Know the Territory](01-03.html#Heading9)
            -   [Know When It Matters](01-04.html#Heading10)
            -   [Always Consider the Alternatives](01-04.html#Heading11)
            -   [Know How to Turn On the Juice](01-05.html#Heading12)
        -   [Where We've Been, What We've Seen](01-06.html#Heading13)
            -   [Where We're Going](01-06.html#Heading14)

    2.  [Chapter 2—A World Apart](02-01.html#Heading1)
        -   [The Unique Nature of Assembly Language
            Optimization](02-01.html#Heading2)
        -   [Instructions: The Individual versus the
            Collective](02-01.html#Heading3)
        -   [Assembly Is Fundamentally Different](02-01.html#Heading4)
            -   [Transformation Inefficiencies](02-02.html#Heading5)
            -   [Self-Reliance](02-02.html#Heading6)
            -   [Knowledge](02-02.html#Heading7)
        -   [The Flexible Mind](02-03.html#Heading8)
            -   [Where to Begin?](02-03.html#Heading9)

    3.  [Chapter 3—Assume Nothing](03-01.html#Heading1)
        -   [Understanding and Using the Zen Timer](03-01.html#Heading2)
        -   [The Costs of Ignorance](03-01.html#Heading3)
        -   [The Zen Timer](03-01.html#Heading4)
            -   [The Zen Timer Is a Means, Not an
                End](03-03.html#Heading5)
            -   [Starting the Zen Timer](03-03.html#Heading6)
        -   [Time and the PC](03-03.html#Heading7)
        -   [Stopping the Zen Timer](03-04.html#Heading8)
        -   [Reporting Timing Results](03-04.html#Heading9)
        -   [Notes on the Zen Timer](03-05.html#Heading10)
        -   [A Sample Use of the Zen Timer](03-05.html#Heading11)
        -   [The Long-Period Zen Timer](03-06.html#Heading12)
            -   [Stopping the Clock](03-07.html#Heading13)
        -   [Example Use of the Long-Period Zen
            Timer](03-08.html#Heading14)
        -   [Using the Zen Timer from C](03-09.html#Heading15)
            -   [Watch Out for Optimizing
                Assemblers!](03-10.html#Heading16)
            -   [Further Reading](03-10.html#Heading17)
            -   [Armed with the Zen Timer, Onward and
                Upward](03-10.html#Heading18)

    4.  [Chapter 4—In the Lair of the Cycle-Eaters](04-01.html#Heading1)
        -   [How the PC Hardware Devours Code
            Performance](04-01.html#Heading2)
        -   [Cycle-Eaters](04-01.html#Heading3)
        -   [The Nature of Cycle-Eaters](04-01.html#Heading4)
            -   [The 8088's Ancestral Cycle-Eaters](04-01.html#Heading5)
        -   [The 8-Bit Bus Cycle-Eater](04-01.html#Heading6)
            -   [The Impact of the 8-Bit Bus
                Cycle-Eater](04-02.html#Heading7)
            -   [What to Do about the 8-Bit Bus
                Cycle-Eater?](04-02.html#Heading8)
        -   [The Prefetch Queue Cycle-Eater](04-03.html#Heading9)
            -   [Official Execution Times Are Only Part of the
                Story](04-04.html#Heading10)
            -   [There Is No Such Beast as a True Instruction Execution
                Time](04-04.html#Heading11)
            -   [Approximating Overall Execution
                Times](04-05.html#Heading12)
            -   [What to Do about the Prefetch Queue
                Cycle-Eater?](04-05.html#Heading13)
            -   [Holding Up the 8088](04-06.html#Heading14)
        -   [Dynamic RAM Refresh: The Invisible
            Hand](04-06.html#Heading15)
            -   [How DRAM Refresh Works in the PC](04-06.html#Heading16)
            -   [The Impact of DRAM Refresh](04-07.html#Heading17)
            -   [What to Do About the DRAM Refresh
                Cycle-Eater?](04-07.html#Heading18)
        -   [Wait States](04-07.html#Heading19)
        -   [The Display Adapter Cycle-Eater](04-08.html#Heading20)
            -   [The Impact of the Display Adapter
                Cycle-Eater](04-09.html#Heading21)
            -   [What to Do about the Display Adapter
                Cycle-Eater?](04-10.html#Heading22)
            -   [Cycle-Eaters: A Summary](04-10.html#Heading23)
            -   [What Does It All Mean?](04-10.html#Heading24)

    5.  [Chapter 5—Crossing the Border](05-01.html#Heading1)
        -   [Searching Files with Restartable
            Blocks](05-01.html#Heading2)
            -   [Searching for Text](05-01.html#Heading3)
        -   [Avoiding the String Trap](05-01.html#Heading4)
        -   [Brute-Force Techniques](05-02.html#Heading5)
        -   [Using memchr()](05-02.html#Heading6)
            -   [Making a Search Restartable](05-02.html#Heading7)
        -   [Interpreting Where the Cycles Go](05-04.html#Heading8)
            -   [Knowing When Assembly Is
                Pointless](05-04.html#Heading9)
        -   [Always Look Where Execution Is Going](05-05.html#Heading10)

    6.  [Chapter 6—Looking Past Face Value](06-01.html#Heading1)
        -   [How Machine Instructions May Do More Than You
            Think](06-01.html#Heading2)
            -   [Memory Addressing and Arithmetic](06-01.html#Heading3)
        -   [Math via Memory Addressing](06-02.html#Heading4)
            -   [The Wonders of LEA on the 386](06-02.html#Heading5)
        -   [Multiplication with LEA Using Non-Powers of
            Two](06-02.html#Heading6)

    7.  [Chapter 7—Local Optimization](07-01.html#Heading1)
        -   [Optimizing Halfway between Algorithms and Cycle
            Counting](07-01.html#Heading2)
            -   [When LOOP Is a Bad Idea](07-01.html#Heading3)
        -   [The Lessons of LOOP and JCXZ](07-02.html#Heading4)
            -   [Avoiding LOOPS of Any Stripe](07-02.html#Heading5)
        -   [Local Optimization](07-02.html#Heading6)
        -   [Unrolling Loops](07-03.html#Heading7)
            -   [Rotating and Shifting with Tables](07-05.html#Heading8)
            -   [NOT Flips Bits—Not Flags](07-05.html#Heading9)
            -   [Incrementing with and without
                Carry](07-05.html#Heading10)

    8.  [Chapter 8—Speeding Up C with Assembly
        Language](08-01.html#Heading1)
        -   [Jumping Languages When You Know It'll
            Help](08-01.html#Heading2)
            -   [Billy, Don't Be a Compiler](08-01.html#Heading3)
        -   [Don't Call Your Functions on Me, Baby](08-01.html#Heading4)
        -   [Stack Frames Slow So Much](08-02.html#Heading5)
        -   [Torn Between Two Segments](08-02.html#Heading6)
            -   [Why Speeding Up Is Hard to Do](08-02.html#Heading7)
        -   [Taking It to the Limit](08-02.html#Heading8)
            -   [A C-to-Assembly Case Study](08-02.html#Heading9)

    9.  [Chapter 9—Hints My Readers Gave Me](09-01.html#Heading1)
        -   [Optimization Odds and Ends from the
            Field](09-01.html#Heading2)
            -   [Another Look at LEA](09-01.html#Heading3)
            -   [The Kennedy Portfolio](09-01.html#Heading4)
            -   [Speeding Up Multiplication](09-02.html#Heading5)
            -   [Optimizing Optimized Searching](09-02.html#Heading6)
            -   [Short Sorts](09-05.html#Heading7)
            -   [Full 32-Bit Division](09-05.html#Heading8)
            -   [Sweet Spot Revisited](09-06.html#Heading9)
            -   [Hard-Core Cycle Counting](09-07.html#Heading10)
            -   [Hardwired Far Jumps](09-07.html#Heading11)
            -   [Setting 32-Bit Registers: Time versus
                Space](09-07.html#Heading12)

    10. [Chapter 10—Patient Coding, Faster Code](10-01.html#Heading1)
        -   [How Working Quickly Can Bring Execution to a
            Crawl](10-01.html#Heading2)
            -   [The Case for Delayed
                Gratification](10-01.html#Heading3)
        -   [The Brute-Force Syndrome](10-01.html#Heading4)
            -   [Wasted Breakthroughs](10-02.html#Heading5)
        -   [Recursion](10-03.html#Heading6)
            -   [Patient Optimization](10-03.html#Heading7)

    11. [Chapter 11—Pushing the 286 and 386](11-01.html#Heading1)
        -   [New Registers, New Instructions, New Timings, New
            Complications](11-01.html#Heading2)
            -   [Family Matters](11-01.html#Heading3)
            -   [Crossing the Gulf to the 286 and the
                386](11-01.html#Heading4)
            -   [In the Lair of the Cycle-Eaters, Part
                II](11-01.html#Heading5)
                -   [System Wait States](11-02.html#Heading6)
                -   [Data Alignment](11-03.html#Heading7)
            -   [Code Alignment](11-03.html#Heading8)
                -   [Alignment and the 386](11-04.html#Heading9)
                -   [Alignment and the Stack](11-04.html#Heading10)
                -   [The DRAM Refresh Cycle-Eater: Still an Act of
                    God](11-04.html#Heading11)
                -   [The Display Adapter
                    Cycle-Eater](11-04.html#Heading12)
            -   [New Instructions and Features: The
                286](11-05.html#Heading13)
            -   [New Instructions and Features: The
                386](11-05.html#Heading14)
                -   [Optimization Rules: The More Things
                    Change...](11-06.html#Heading15)
                -   [Detailed Optimization](11-06.html#Heading16)
            -   [POPF and the 286](11-07.html#Heading17)

    12. [Chapter 12—Pushing the 486](12-01.html#Heading1)
        -   [It's Not Just a Bigger 386](12-01.html#Heading2)
            -   [Enter the 486](12-01.html#Heading3)
        -   [Rules to Optimize By](12-01.html#Heading4)
            -   [The Hazards of Indexed Addressing](12-01.html#Heading5)
            -   [Calculate Memory Pointers Ahead of
                Time](12-02.html#Heading6)
        -   [Caveat Programmor](12-02.html#Heading7)
            -   [Stack Addressing and Address
                Pipelining](12-03.html#Heading8)
            -   [Problems with Byte Registers](12-03.html#Heading9)
            -   [More Fun with Byte Registers](12-04.html#Heading10)
            -   [Timing Your Own 486 Code](12-04.html#Heading11)
        -   [The Story Continues](12-04.html#Heading12)

    13. [Chapter 13—Aiming the 486](13-01.html#Heading1)
        -   [Pipelines and Other Hazards of the High
            End](13-01.html#Heading2)
            -   [486 Pipeline Optimization](13-01.html#Heading3)
        -   [BSWAP: More Useful Than You Might
            Think](13-02.html#Heading4)
        -   [Pushing and Popping Memory](13-03.html#Heading5)
        -   [Optimal 1-Bit Shifts and Rotates](13-03.html#Heading6)
        -   [32-Bit Addressing Modes](13-04.html#Heading7)

    14. [Chapter 14—Boyer-Moore String Searching](14-01.html#Heading1)
        -   [Optimizing a Pretty Optimum Search
            Algorithm](14-01.html#Heading2)
        -   [String Searching Refresher](14-01.html#Heading3)
        -   [The Boyer-Moore Algorithm](14-02.html#Heading4)
        -   [Boyer-Moore: The Good and the Bad](14-02.html#Heading5)
        -   [Further Optimization of Boyer-Moore](14-06.html#Heading6)
        -   [Know What You Know](14-06.html#Heading7)

    15. [Chapter 15—Linked Lists and plain Unintended
        Challenges](15-01.html#Heading1)
        -   [Unfamiliar Problems with Familiar Data
            Structures](15-01.html#Heading2)
        -   [Linked Lists](15-01.html#Heading3)
        -   [Dummies and Sentinels](15-02.html#Heading4)
        -   [Circular Lists](15-03.html#Heading5)
        -   [Hi/Lo in 24 Bytes](15-04.html#Heading6)

    16. [Chapter 16—There Ain't No Such Thing as the Fastest
        Code](16-01.html#Heading1)
        -   [Lessons Learned in the Pursuit of the Ultimate Word
            Counter](16-01.html#Heading2)
        -   [Counting Words in a Hurry](16-01.html#Heading3)
            -   [Which Way to Go from Here?](16-02.html#Heading4)
        -   [Challenges and Hazards](16-03.html#Heading5)
            -   [Blinding Yourself to a Better
                Approach](16-04.html#Heading6)
            -   [Watch Out for Luggable
                Assumptions!](16-04.html#Heading7)
        -   [The Astonishment of Right-Brain
            Optimization](16-04.html#Heading8)
        -   [Levels of Optimization](16-06.html#Heading9)
            -   [Optimization Level 1: Good Code](16-06.html#Heading10)
        -   [Level 2: A New Perspective](16-07.html#Heading11)
            -   [Level 3: Breakthrough](16-08.html#Heading12)
            -   [Enough Word Counting Already!](16-08.html#Heading13)

    17. [Chapter 17—The Game of Life](17-01.html#Heading1)
        -   [The Triumph of Algorithmic Optimization in a Cellular
            Automata Game](17-01.html#Heading2)
        -   [Conway's Game](17-01.html#Heading3)
            -   [The Rules of the Game](17-01.html#Heading4)
        -   [Where Does the Time Go?](17-03.html#Heading5)
        -   [The Hazards and Advantages of
            Abstraction](17-03.html#Heading6)
        -   [Heavy-Duty C++ Optimization](17-05.html#Heading7)
        -   [Bringing In the Right Brain](17-06.html#Heading8)
            -   [Re-Examining the Task](17-06.html#Heading9)
            -   [Acting on What We Know](17-06.html#Heading10)
            -   [The Challenge That Ate My Life](17-08.html#Heading11)

    18. [Chapter 18—It's a plain Wonderful Life](18-01.html#Heading1)
        -   [Optimization beyond the Pale](18-01.html#Heading2)
        -   [Breaking the Rules](18-01.html#Heading3)
        -   [Table-Driven Magic](18-02.html#Heading4)
        -   [Keeping Track of Change with a Change
            List](18-04.html#Heading5)
            -   [A Layperson's Overview of QLIFE](18-05.html#Heading6)

    19. [Chapter 19—Pentium: Not the Same Old Song](19-01.html#Heading1)
        -   [Learning a Whole Different Set of Optimization
            Rules](19-01.html#Heading2)
        -   [The Return of Optimization as Art](19-01.html#Heading3)
        -   [The Pentium: An Overview](19-01.html#Heading4)
            -   [Crossing Cache Lines](19-02.html#Heading5)
            -   [Cache Organization](19-02.html#Heading6)
        -   [Faster Addressing and More](19-03.html#Heading7)
        -   [Branch Prediction](19-04.html#Heading8)
        -   [Miscellaneous Pentium Topics](19-04.html#Heading9)
            -   [486 versus Pentium Optimization](19-04.html#Heading10)
            -   [Going Superscalar](19-04.html#Heading11)

    20. [Chapter 20—Pentium Rules](20-01.html#Heading1)
        -   [How Your Carbon-Based Optimizer Can Put the "Super" in
            Superscalar](20-01.html#Heading2)
        -   [An Instruction in Every Pipe](20-01.html#Heading3)
        -   [V-Pipe-Capable Instructions](20-02.html#Heading4)
        -   [Lockstep Execution](20-03.html#Heading5)
        -   [Superscalar Notes](20-04.html#Heading6)
            -   [Register Starvation](20-04.html#Heading7)

    21. [Chapter 21—Unleashing the Pentium's
        V-Pipe](21-01.html#Heading1)
        -   [Focusing on Keeping Both Pentium Pipes
            Full](21-01.html#Heading2)
        -   [Address Generation Interlocks](21-01.html#Heading3)
        -   [Register Contention](21-02.html#Heading4)
            -   [Exceptions to Register Contention](21-02.html#Heading5)
        -   [Who's in First?](21-02.html#Heading6)
        -   [Pentium Optimization in Action](21-03.html#Heading7)
            -   [A Quick Note on the 386 and 486](21-05.html#Heading8)

    22. [Chapter 22—Zenning and the Flexible Mind](22-01.html#Heading1)
        -   [Taking a Spin through What You've
            Learned](22-01.html#Heading2)
        -   [Zenning](22-01.html#Heading3)

5.  [Part II](23-01.html)
    23. [Chapter 23—Bones and Sinew](23-01.html#Heading1)
        -   [At the Very Heart of Standard PC
            Graphics](23-01.html#Heading2)
        -   [The VGA](23-01.html#Heading3)
        -   [An Introduction to VGA Programming](23-01.html#Heading4)
        -   [At the Core](23-02.html#Heading5)
            -   [Linear Planes and True VGA Modes](23-03.html#Heading6)
            -   [Smooth Panning](23-04.html#Heading7)
            -   [Color Plane Manipulation](23-05.html#Heading8)
            -   [Page Flipping](23-05.html#Heading9)
        -   [The Hazards of VGA Clones](23-06.html#Heading10)
        -   [Just the Beginning](23-06.html#Heading11)
        -   [The Macro Assembler](23-06.html#Heading12)

    24. [Chapter 24—Parallel Processing with the
        VGA](24-01.html#Heading1)
        -   [Taking on Graphics Memory Four Bytes at a
            Time](24-01.html#Heading2)
        -   [VGA Programming: ALUs and Latches](24-01.html#Heading3)
        -   [Notes on the ALU/Latch Demo Program](24-03.html#Heading4)

    25. [Chapter 25—VGA Data Machinery](25-01.html#Heading1)
        -   [The Barrel Shifter, Bit Mask, and Set/Reset
            Mechanisms](25-01.html#Heading2)
        -   [VGA Data Rotation](25-01.html#Heading3)
        -   [The Bit Mask](25-01.html#Heading4)
        -   [The VGA's Set/Reset Circuitry](25-03.html#Heading5)
            -   [Setting All Planes to a Single
                Color](25-04.html#Heading6)
            -   [Manipulating Planes Individually](25-05.html#Heading7)
        -   [Notes on Set/Reset](25-06.html#Heading8)
        -   [A Brief Note on Word OUTs](25-06.html#Heading9)

    26. [Chapter 26—VGA Write Mode 3](26-01.html#Heading1)
        -   [The Write Mode That Grows on You](26-01.html#Heading2)
        -   [A Mode Born in Strangeness](26-01.html#Heading3)
        -   [A Note on Preserving Register Bits](26-03.html#Heading4)

    27. [Chapter 27—Yet Another VGA Write Mode](27-01.html#Heading1)
        -   [Write Mode 2, Chunky Bitmaps,and Text-Graphics
            Coexistence](27-01.html#Heading2)
        -   [Write Mode 2 and Set/Reset](27-01.html#Heading3)
            -   [A Byte's Progress in Write Mode 2](27-01.html#Heading4)
            -   [Copying Chunky Bitmaps to VGA Memory Using Write Mode
                2](27-02.html#Heading5)
            -   [Drawing Color-Patterned Lines Using Write Mode
                2](27-03.html#Heading6)
        -   [When to Use Write Mode 2 and When to Use
            Set/Reset](27-04.html#Heading7)
        -   [Mode 13H—320x200 with 256 Colors](27-04.html#Heading8)
        -   [Flipping Pages from Text to Graphics and
            Back](27-04.html#Heading9)

    28. [Chapter 28—Reading VGA Memory](28-01.html#Heading1)
        -   [Read Modes 0 and 1, and the Color Don't Care
            Register](28-01.html#Heading2)
        -   [Read Mode 0](28-01.html#Heading3)
        -   [Read Mode 1](28-03.html#Heading4)
        -   [When all Planes "Don't Care"](28-04.html#Heading5)

    29. [Chapter 29—Saving Screens and Other VGA
        Mysteries](29-01.html#Heading1)
        -   [Useful Nuggets from the VGA Zen File](29-01.html#Heading2)
        -   [Saving and Restoring EGA and VGA
            Screens](29-01.html#Heading3)
        -   [16 Colors out of 64](29-03.html#Heading4)
        -   [Overscan](29-05.html#Heading5)
        -   [A Bonus Blanker](29-05.html#Heading6)
        -   [Modifying VGA Registers](29-06.html#Heading7)

    30. [Chapter 30—Video Est Omnis Divisa](30-01.html#Heading1)
        -   [The Joys and Galling Problems of Using Split Screens on the
            EGA and VGA](30-01.html#Heading2)
        -   [How the Split Screen Works](30-01.html#Heading3)
            -   [The Split Screen in Action](30-01.html#Heading4)
            -   [VGA and EGA Split-Screen Operation Don't
                Mix](30-03.html#Heading5)
        -   [Setting the Split-Screen-Related
            Registers](30-03.html#Heading6)
        -   [The Problem with the EGA Split Screen](30-03.html#Heading7)
        -   [Split Screen and Panning](30-04.html#Heading8)
            -   [The Split Screen and Horizontal Panning: An
                Example](30-04.html#Heading9)
        -   [Notes on Setting and Reading
            Registers](30-06.html#Heading10)
        -   [Split Screens in Other Modes](30-07.html#Heading11)
        -   [How Safe?](30-07.html#Heading12)

    31. [Chapter 31—Higher 256-Color Resolution on the
        VGA](31-01.html#Heading1)
        -   [When Is 320x200 Really 320x400?](31-01.html#Heading2)
        -   [Why 320x200? Only IBM Knows for Sure](31-01.html#Heading3)
        -   [320x400 256-Color Mode](31-01.html#Heading4)
            -   [Display Memory Organization in 320x400
                Mode](31-01.html#Heading5)
            -   [Reading and Writing Pixels](31-02.html#Heading6)
        -   [Two 256-Color Pages](31-04.html#Heading7)
        -   [Something to Think About](31-05.html#Heading8)

    32. [Chapter 32—Be It Resolved: 360x480](32-01.html#Heading1)
        -   [Taking 256-Color Modes About as Far as the Standard VGA Can
            Take Them](32-01.html#Heading2)
        -   [Extended 256-Color Modes: What's Not to
            Like?](32-01.html#Heading3)
        -   [360x480 256-Color Mode](32-01.html#Heading4)
        -   [How 360x480 256-Color Mode Works](32-04.html#Heading5)
            -   [480 Scan Lines per Screen: A Little Slower, But No Big
                Deal](32-04.html#Heading6)
            -   [360 Pixels per Scan Line: No Mean
                Feat](32-04.html#Heading7)
            -   [Accessing Display Memory in 360x480 256-Color
                Mode](32-05.html#Heading8)

    33. [Chapter 33—Yogi Bear and Eurythmics Confront VGA
        Colors](33-01.html#Heading1)
        -   [The Basics of VGA Color Generation](33-01.html#Heading2)
        -   [VGA Color Basics](33-01.html#Heading3)
            -   [The Palette RAM](33-01.html#Heading4)
            -   [The DAC](33-01.html#Heading5)
            -   [Color Paging with the Color Select
                Register](33-02.html#Heading6)
            -   [256-Color Mode](33-02.html#Heading7)
            -   [Setting the Palette RAM](33-02.html#Heading8)
            -   [Setting the DAC](33-03.html#Heading9)
        -   [If You Can't Call the BIOS, Who Ya Gonna
            Call?](33-03.html#Heading10)
        -   [An Example of Setting the DAC](33-03.html#Heading11)

    34. [Chapter 34—Changing Colors without Writing
        Pixels](34-01.html#Heading1)
        -   [Special Effects through Realtime Manipulation of DAC
            Colors](34-01.html#Heading2)
        -   [Color Cycling](34-01.html#Heading3)
        -   [The Heart of the Problem](34-01.html#Heading4)
            -   [Loading the DAC via the BIOS](34-02.html#Heading5)
            -   [Loading the DAC Directly](34-02.html#Heading6)
        -   [A Test Program for Color Cycling](34-03.html#Heading7)
        -   [Color Cycling Approaches that Work](34-04.html#Heading8)
        -   [Odds and Ends](34-05.html#Heading9)
            -   [The DAC Mask](34-05.html#Heading10)
            -   [Reading the DAC](34-05.html#Heading11)
            -   [Cycling Down](34-05.html#Heading12)

    35. [Chapter 35—Bresenham Is Fast, and Fast Is
        Good](35-01.html#Heading1)
        -   [Implementing and Optimizing Bresenham's Line-Drawing
            Algorithm](35-01.html#Heading2)
        -   [The Task at Hand](35-01.html#Heading3)
        -   [Bresenham's Line-Drawing Algorithm](35-01.html#Heading4)
            -   [Strengths and Weaknesses](35-02.html#Heading5)
        -   [An Implementation in C](35-03.html#Heading6)
            -   [Looking at EVGALine](35-04.html#Heading7)
            -   [Drawing Each Line](35-05.html#Heading8)
            -   [Drawing Each Pixel](35-05.html#Heading9)
        -   [Comments on the C Implementation](35-06.html#Heading10)
        -   [Bresenham's Algorithm in Assembly](35-06.html#Heading11)

    36. [Chapter 36—The Good, the Bad, and the
        Run-Sliced](36-01.html#Heading1)
        -   [Faster Bresenham Lines with Run-Length Slice Line
            Drawing](36-01.html#Heading2)
        -   [Run-Length Slice Fundamentals](36-01.html#Heading3)
        -   [Run-Length Slice Implementation](36-02.html#Heading4)
        -   [Run-Length Slice Details](36-03.html#Heading5)

    37. [Chapter 37—Dead Cats and Lightning Lines](37-01.html#Heading1)
        -   [Optimizing Run-Length Slice Line Drawing in a Major
            Way](37-01.html#Heading2)
        -   [Fast Run-Length Slice Line Drawing](37-01.html#Heading3)
            -   [How Fast Is Fast?](37-02.html#Heading4)
            -   [Further Optimizations](37-02.html#Heading5)

    38. [Chapter 38—The Polygon Primeval](38-01.html#Heading1)
        -   [Drawing Polygons Efficiently and
            Quickly](38-01.html#Heading2)
        -   [Filled Polygons](38-01.html#Heading3)
            -   [Which Side Is Inside?](38-01.html#Heading4)
            -   [How Do You Fit Polygons Together?](38-02.html#Heading5)
        -   [Filling Non-Overlapping Convex
            Polygons](38-02.html#Heading6)
        -   [Oddball Cases](38-04.html#Heading7)

    39. [Chapter 39—Fast Convex Polygons](39-01.html#Heading1)
        -   [Filling Polygons in a Hurry](39-01.html#Heading2)
        -   [Fast Convex Polygon Filling](39-01.html#Heading3)
            -   [Fast Drawing](39-01.html#Heading4)
            -   [Fast Edge Tracing](39-02.html#Heading5)
        -   [The Finishing Touch: Assembly
            Language](39-03.html#Heading6)
            -   [Maximizing REP STOS](39-04.html#Heading7)
        -   [Faster Edge Tracing](39-04.html#Heading8)

    40. [Chapter 40—Of Songs, Taxes, and the Simplicity of Complex
        Polygons](40-01.html#Heading1)
        -   [Dealing with Irregular Polygonal
            Areas](40-01.html#Heading2)
        -   [Filling Arbitrary Polygons](40-01.html#Heading3)
            -   [Active Edges](40-01.html#Heading4)
        -   [Complex Polygon Filling: An
            Implementation](40-03.html#Heading5)
            -   [More on Active Edges](40-04.html#Heading6)
            -   [Performance Considerations](40-04.html#Heading7)
        -   [Nonconvex Polygons](40-05.html#Heading8)
            -   [Details, Details](40-05.html#Heading9)

    41. [Chapter 41—Those Way-Down Polygon Nomenclature
        Blues](41-01.html#Heading1)
        -   [Names Do Matter when You Conceptualize a Data
            Structure](41-01.html#Heading2)
        -   [Nomenclature in Action](41-01.html#Heading3)

    42. [Chapter 42—Wu'ed in Haste; Fried, Stewed at
        Leisure](42-01.html#Heading1)
        -   [Fast Antialiased Lines Using Wu's
            Algorithm](42-01.html#Heading2)
        -   [Wu Antialiasing](42-01.html#Heading3)
        -   [Tracing and Intensity in One](42-02.html#Heading4)
        -   [Sample Wu Antialiasing](42-03.html#Heading5)
            -   [Notes on Wu Antialiasing](42-05.html#Heading6)

    43. [Chapter 43—Bit-Plane Animation](43-01.html#Heading1)
        -   [A Simple and Extremely Fast Animation Method for Limited
            Color](43-01.html#Heading2)
        -   [Bit-Planes: The Basics](43-01.html#Heading3)
            -   [Stacking the Palette Registers](43-02.html#Heading4)
        -   [Bit-Plane Animation in Action](43-02.html#Heading5)
        -   [Limitations of Bit-Plane Animation](43-04.html#Heading6)
        -   [Shearing and Page Flipping](43-05.html#Heading7)
        -   [Beating the Odds in the Jaw-Dropping
            Contest](43-06.html#Heading8)

    44. [Chapter 44—Split Screens Save the Page Flipped
        Day](44-01.html#Heading1)
        -   [640x480 Page Flipped Animation in
            64K...Almost](44-01.html#Heading2)
            -   [A Plethora of Challenges](44-01.html#Heading3)
            -   [A Page Flipping Animation
                Demonstration](44-01.html#Heading4)
                -   [Write Mode 3](44-04.html#Heading5)
                -   [Drawing Text](44-04.html#Heading6)
                -   [Page Flipping](44-05.html#Heading7)
                -   [Knowing When to Flip](44-06.html#Heading8)
            -   [Enter the Split Screen](44-06.html#Heading9)

    45. [Chapter 45—Dog Hair and Dirty Rectangles](45-01.html#Heading1)
        -   [Different Angles on Animation](45-01.html#Heading2)
        -   [Plus ça Change](45-01.html#Heading3)
        -   [VGA Access Times](45-01.html#Heading4)
        -   [Dirty-Rectangle Animation](45-02.html#Heading5)
            -   [So Why Not Use Page Flipping?](45-02.html#Heading6)
        -   [Dirty Rectangles in Action](45-03.html#Heading7)
        -   [Hi-Res VGA Page Flipping](45-04.html#Heading8)
        -   [Another Interesting Twist on Page
            Flipping](45-06.html#Heading9)

    46. [Chapter 46—Who Was that Masked Image?](46-01.html#Heading1)
        -   [Optimizing Dirty-Rectangle Animation](46-01.html#Heading2)
            -   [Dirty-Rectangle Animation,
                Continued](46-01.html#Heading3)
            -   [Masked Images](46-03.html#Heading4)
            -   [Internal Animation](46-03.html#Heading5)
                -   [Dirty-Rectangle Management](46-03.html#Heading6)
            -   [Drawing Order and Visual Quality](46-03.html#Heading7)

    47. [Chapter 47—Mode X: 256-Color VGA Magic](47-01.html#Heading1)
        -   [Introducing the VGA's Undocumented "Animation-Optimal"
            Mode](47-01.html#Heading2)
        -   [What Makes Mode X Special?](47-01.html#Heading3)
        -   [Selecting 320x240 256-Color Mode](47-02.html#Heading4)
        -   [Designing from a Mode X Perspective](47-04.html#Heading5)
        -   [Hardware Assist from an Unexpected
            Quarter](47-06.html#Heading6)

    48. [Chapter 48—Mode X Marks the Latch](48-01.html#Heading1)
        -   [The Internals of Animation's Best Video Display
            Mode](48-01.html#Heading2)
        -   [Allocating Memory in Mode X](48-03.html#Heading3)
        -   [Copying Pixel Blocks within Display
            Memory](48-03.html#Heading4)
            -   [Copying to Display Memory](48-05.html#Heading5)
        -   [Who Was that Masked Image Copier?](48-05.html#Heading6)

    49. [Chapter 49—Mode X 256-Color Animation](49-01.html#Heading1)
        -   [How to Make the VGA Really Get up and
            Dance](49-01.html#Heading2)
        -   [Masked Copying](49-01.html#Heading3)
            -   [Faster Masked Copying](49-02.html#Heading4)
            -   [Notes on Masked Copying](49-03.html#Heading5)
        -   [Animation](49-04.html#Heading6)
        -   [Mode X Animation in Action](49-04.html#Heading7)
        -   [Works Fast, Looks Great](49-05.html#Heading8)

    50. [Chapter 50—Adding a Dimension](50-01.html#Heading1)
        -   [3-D Animation Using Mode X](50-01.html#Heading2)
        -   [References on 3-D Drawing](50-01.html#Heading3)
        -   [The 3-D Drawing Pipeline](50-01.html#Heading4)
            -   [Projection](50-02.html#Heading5)
            -   [Translation](50-02.html#Heading6)
            -   [Rotation](50-02.html#Heading7)
        -   [A Simple 3-D Example](50-02.html#Heading8)
            -   [Notes on the 3-D Animation
                Example](50-07.html#Heading9)
        -   [An Ongoing Journey](50-07.html#Heading10)

    51. [Chapter 51—Sneakers in Space](51-01.html#Heading1)
        -   [Using Backface Removal to Eliminate Hidden
            Surfaces](51-01.html#Heading2)
        -   [One-sided Polygons: Backface Removal](51-01.html#Heading3)
            -   [Backface Removal in Action](51-02.html#Heading4)
        -   [Incremental Transformation](51-05.html#Heading5)
        -   [A Note on Rounding Negative Numbers](51-06.html#Heading6)
        -   [Object Representation](51-06.html#Heading7)

    52. [Chapter 52—Fast 3-D Animation: Meet
        X-Sharp](52-01.html#Heading1)
        -   [The First Iteration of a Generalized 3-D Animation
            Package](52-01.html#Heading2)
        -   [This Chapter's Demo Program](52-01.html#Heading3)
        -   [A New Animation Framework: X-Sharp](52-07.html#Heading4)
        -   [Three Keys to Realtime Animation
            Performance](52-07.html#Heading5)
            -   [Drawbacks](52-08.html#Heading6)
            -   [Where the Time Goes](52-08.html#Heading7)

    53. [Chapter 53—Raw Speed and More](53-01.html#Heading1)
        -   [The Naked Truth About Speed in 3-D
            Animation](53-01.html#Heading2)
        -   [Raw Speed, Part 1: Assembly Language](53-01.html#Heading3)
        -   [Raw Speed, Part II: Look it Up](53-03.html#Heading4)
            -   [Hidden Surfaces](53-03.html#Heading5)
            -   [Rounding](53-04.html#Heading6)

    54. [Chapter 54—3-D Shading](54-01.html#Heading1)
        -   [Putting Realistic Surfaces on Animated 3-D
            Objects](54-01.html#Heading2)
        -   [Support for Older Processors](54-01.html#Heading3)
            -   [Shading](54-03.html#Heading4)
                -   [Ambient Shading](54-03.html#Heading5)
                -   [Diffuse Shading](54-03.html#Heading6)
            -   [Shading: Implementation Details](54-05.html#Heading7)

    55. [Chapter 55—Color Modeling in 256-Color
        Mode](55-01.html#Heading1)
        -   [Pondering X-Sharp's Color Model in an RGB State of
            Mind](55-01.html#Heading2)
            -   [A Color Model](55-01.html#Heading3)
            -   [A Bonus from the BitMan](55-03.html#Heading4)

    56. [Chapter 56—Pooh and the Space Station](56-01.html#Heading1)
        -   [Using Fast Texture Mapping to Place Pooh on a
            Polygon](56-01.html#Heading2)
        -   [Principles of Quick-and-Dirty Texture
            Mapping](56-01.html#Heading3)
            -   [Mapping Textures Made Easy](56-01.html#Heading4)
        -   [Fast Texture Mapping: An
            Implementation](56-03.html#Heading5)

    57. [Chapter 57—10,000 Freshly Sheared Sheep on the
        Screen](57-01.html#Heading1)
        -   [The Critical Role of Experience in Implementing Fast,
            Smooth Texture Mapping](57-01.html#Heading2)
            -   [Visual Quality: A Black Hole ... Er,
                Art](57-01.html#Heading3)
            -   [Fixed-Point Arithmetic, Redux](57-01.html#Heading4)
            -   [Texture Mapping: Orientation
                Independence](57-02.html#Heading5)
            -   [Mapping Textures across Multiple
                Polygons](57-02.html#Heading6)
                -   [Fast Texture Mapping](57-02.html#Heading7)

    58. [Chapter 58—Heinlein's Crystal Ball, Spock's Brain, and the
        9-Cycle Dare](58-01.html#Heading1)
        -   [Using the Whole-Brain Approach to Accelerate Texture
            Mapping](58-01.html#Heading2)
        -   [Texture Mapping Redux](58-01.html#Heading3)
            -   [Left-Brain Optimization](58-01.html#Heading4)
            -   [A 90-Degree Shift in Perspective](58-02.html#Heading5)
        -   [That's Nice—But it Sure as Heck Ain't 9
            Cycles](58-03.html#Heading6)
            -   [Don't Stop Thinking about Those
                Cycles](58-04.html#Heading7)
        -   [Texture Mapping Notes](58-05.html#Heading8)

    59. [Chapter 59—The Idea of BSP Trees](59-01.html#Heading1)
        -   [What BSP Trees Are and How to Walk
            Them](59-01.html#Heading2)
        -   [BSP Trees](59-01.html#Heading3)
            -   [Visibility Determination](59-01.html#Heading4)
            -   [Limitations of BSP Trees](59-02.html#Heading5)
        -   [Building a BSP Tree](59-02.html#Heading6)
            -   [Visibility Ordering](59-03.html#Heading7)
        -   [Inorder Walks of BSP Trees](59-04.html#Heading8)
            -   [Know It *Cold*](59-04.html#Heading9)
            -   [Measure and Learn](59-05.html#Heading10)
        -   [Surfing Amidst the Trees](59-06.html#Heading11)
            -   [Related Reading](59-06.html#Heading12)

    60. [Chapter 60—Compiling BSP Trees](60-01.html#Heading1)
        -   [Taking BSP Trees from Concept to
            Reality](60-01.html#Heading2)
        -   [Compiling BSP Trees](60-01.html#Heading3)
            -   [Parametric Lines](60-02.html#Heading4)
            -   [Parametric Line Clipping](60-02.html#Heading5)
            -   [The BSP Compiler](60-02.html#Heading6)
        -   [Optimizing the BSP Tree](60-04.html#Heading7)
        -   [BSP Optimization: an Undiscovered
            Country](60-04.html#Heading8)

    61. [Chapter 61—Frames of Reference](61-01.html#Heading1)
        -   [The Fundamentals of the Math behind 3-D
            Graphics](61-01.html#Heading2)
            -   [3-D Math](61-01.html#Heading3)
            -   [Foundation Definitions](61-01.html#Heading4)
        -   [The Dot Product](61-02.html#Heading5)
            -   [Dot Products of Unit Vectors](61-02.html#Heading6)
        -   [Cross Products and the Generation of Polygon
            Normals](61-02.html#Heading7)
        -   [Using the Sign of the Dot Product](61-03.html#Heading8)
        -   [Using the Dot Product for Projection](61-04.html#Heading9)
        -   [Rotation by Projection](61-04.html#Heading10)

    62. [Chapter 62—One Story, Two Rules, and a BSP
        Renderer](62-01.html#Heading1)
        -   [Taking a Compiled BSP Tree from Logical to Visual
            Reality](62-01.html#Heading2)
            -   [BSP-based Rendering](62-01.html#Heading3)
            -   [The Rendering Pipeline](62-03.html#Heading4)
        -   [Moving the Viewer](62-03.html#Heading5)
        -   [Transformation into Viewspace](62-03.html#Heading6)
        -   [Clipping](62-03.html#Heading7)
        -   [Projection to Screenspace](62-03.html#Heading8)
        -   [Walking the Tree, Backface Culling and
            Drawing](62-04.html#Heading9)
            -   [Notes on the BSP Renderer](62-04.html#Heading10)

    63. [Chapter 63—Floating-Point for Real-Time
        3-D](63-01.html#Heading1)
        -   [Knowing When to Hurl Conventional Math Wisdom Out the
            Window](63-01.html#Heading2)
        -   [Not Your Father's Floating-Point](63-01.html#Heading3)
        -   [Pentium Floating-Point Optimization](63-01.html#Heading4)
            -   [Pipelining, Latency, and
                Throughput](63-02.html#Heading5)
            -   [FXCH](63-02.html#Heading6)
        -   [The Dot Product](63-02.html#Heading7)
        -   [The Cross Product](63-03.html#Heading8)
        -   [Transformation](63-03.html#Heading9)
        -   [Projection](63-04.html#Heading10)
        -   [Rounding Control](63-04.html#Heading11)
        -   [A Farewell to 3-D Fixed-Point](63-04.html#Heading12)

    64. [Chapter 64—Quake's Visible-Surface
        Determination](64-01.html#Heading1)
        -   [The Challenge of Separating All Things Seen from All Things
            Unseen](64-01.html#Heading2)
        -   [VSD: The Toughest 3-D Challenge of
            All](64-01.html#Heading3)
        -   [The Structure of Quake Levels](64-02.html#Heading4)
        -   [Culling and Visible Surface
            Determination](64-02.html#Heading5)
            -   [Nodes Inside and Outside the View
                Frustum](64-02.html#Heading6)
        -   [Overdraw](64-02.html#Heading7)
        -   [The Beam Tree](64-03.html#Heading8)
        -   [3-D Engine du Jour](64-03.html#Heading9)
            -   [Subdividing Raycast](64-03.html#Heading10)
            -   [Vertex-Free Surfaces](64-03.html#Heading11)
            -   [The Draw-Buffer](64-03.html#Heading12)
            -   [Span-Based Drawing](64-03.html#Heading13)
            -   [Portals](64-03.html#Heading14)
        -   [Breakthrough!](64-03.html#Heading15)
        -   [Simplify, and Keep on Trying New
            Things](64-04.html#Heading16)
        -   [Learn Now, Pay Forward](64-04.html#Heading17)
        -   [References](64-04.html#Heading18)

    65. [Chapter 65—3-D Clipping and Other
        Thoughts](65-01.html#Heading1)
        -   [Determining What's Inside Your Field of
            View](65-01.html#Heading2)
        -   [3-D Clipping Basics](65-01.html#Heading3)
            -   [Intersecting a Line Segment with a
                Plane](65-02.html#Heading4)
        -   [Polygon Clipping](65-02.html#Heading5)
            -   [Clipping to the Frustum](65-03.html#Heading6)
            -   [The Lessons of Listing 65.3](65-04.html#Heading7)
        -   [Advantages of Viewspace Clipping](65-04.html#Heading8)
        -   [Further Reading](65-04.html#Heading9)

    66. [Chapter 66—Quake's Hidden-Surface Removal](66-01.html#Heading1)
        -   [Struggling with Z-Order Solutions to the Hidden Surface
            Problem](66-01.html#Heading2)
        -   [Creative Flux and Hidden Surfaces](66-01.html#Heading3)
            -   [Drawing Moving Objects](66-01.html#Heading4)
            -   [Performance Impact](66-01.html#Heading5)
            -   [Leveling and Improving
                Performance](66-01.html#Heading6)
        -   [Sorted Spans](66-02.html#Heading7)
        -   [Edges versus Spans](66-02.html#Heading8)
        -   [Edge-Sorting Keys](66-03.html#Heading9)
            -   [Where That 1/Z Equation Comes
                From](66-04.html#Heading10)
            -   [Quake and Z-Sorting](66-04.html#Heading11)
        -   [Decisions Deferred](66-04.html#Heading12)

    67. [Chapter 67—Sorted Spans in Action](67-01.html#Heading1)
        -   [Implementing Independent Span Sorting for Rendering without
            Overdraw](67-01.html#Heading2)
        -   [Quake and Sorted Spans](67-01.html#Heading3)
        -   [Types of 1/z Span Sorting](67-02.html#Heading4)
            -   [Intersecting Span Sorting](67-02.html#Heading5)
            -   [Abutting Span Sorting](67-02.html#Heading6)
            -   [Independent Span Sorting](67-03.html#Heading7)
        -   [1/z Span Sorting in Action](67-03.html#Heading8)
            -   [Implementation Notes](67-05.html#Heading9)

    68. [Chapter 68—Quake's Lighting Model](68-01.html#Heading1)
        -   [A Radically Different Approach to Lighting
            Polygons](68-01.html#Heading2)
        -   [The Lighting Conundrum](68-01.html#Heading3)
        -   [Gouraud Shading](68-01.html#Heading4)
            -   [Problems with Gouraud Shading](68-01.html#Heading5)
            -   [Perspective Correctness](68-02.html#Heading6)
        -   [The Quest for Alternative Lighting](68-02.html#Heading7)
            -   [Decoupling Lighting from
                Rasterization](68-02.html#Heading8)
            -   [Size and Speed](68-03.html#Heading9)
        -   [Surface Caching](68-03.html#Heading10)
            -   [Mipmapping To The Rescue](68-04.html#Heading11)
            -   [Two Final Notes on Surface
                Caching](68-04.html#Heading12)

    69. [Chapter 69—Surface Caching and Quake's Triangle
        Models](69-01.html#Heading1)
        -   [Probing Hardware-Assisted Surfaces and Fast Model Animation
            Without Sprites](69-01.html#Heading2)
        -   [Surface Caching with Hardware
            Assistance](69-01.html#Heading3)
            -   [Letting the Graphics Card Build the
                Textures](69-02.html#Heading4)
            -   [The Light Map as Alpha Texture](69-02.html#Heading5)
        -   [Drawing Triangle Models](69-02.html#Heading6)
            -   [Drawing Triangle Models Fast](69-02.html#Heading7)
            -   [Trading Subpixel Precision for
                Speed](69-03.html#Heading8)
            -   [An Idea that Didn't Work](69-03.html#Heading9)
            -   [An Idea that Did Work](69-03.html#Heading10)
            -   [More Ideas that Might Work](69-04.html#Heading11)

    70. [Chapter 70—Quake: A Post-Mortem and a Glimpse into the
        Future](70-01.html#Heading1)
        -   [Preprocessing the World](70-01.html#Heading2)
        -   [The Potentially Visible Set (PVS)](70-02.html#Heading3)
        -   [Passages: The Last-Minute Change that Didn't
            Happen](70-03.html#Heading4)
        -   [Drawing the World](70-03.html#Heading5)
        -   [Rasterization](70-04.html#Heading6)
            -   [Lighting](70-04.html#Heading7)
            -   [Dynamic Lighting](70-04.html#Heading8)
        -   [Entities](70-05.html#Heading9)
            -   [BSP Models](70-05.html#Heading10)
            -   [Polygon Models and Z-Buffering](70-05.html#Heading11)
            -   [The Subdivision Rasterizer](70-06.html#Heading12)
            -   [Sprites](70-06.html#Heading13)
            -   [Particles](70-06.html#Heading14)
        -   [How We Spent Our Summer Vacation: After Shipping
            Quake](70-06.html#Heading15)
            -   [Verite Quake](70-06.html#Heading16)
            -   [GLQuake](70-07.html#Heading17)
            -   [WinQuake](70-07.html#Heading18)
            -   [QuakeWorld](70-07.html#Heading19)
            -   [Quake 2](70-08.html#Heading20)
        -   [Looking Forward](70-09.html#Heading21)

6.  [Appendix A](appendix-a.html)
7.  [Index](book-index.html)
