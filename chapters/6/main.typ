= Conclusions and Future Works <conclusions>
This chapter presents the accomplishments and future direction of the research.

#pagebreak()

== Accomplishments This Semester <accomplishments>
#lorem(30)

== Challenges and Learnings <challenges_and_learnings>

#lorem(59)

== Planned Research Trajectory <future_works>
#lorem(60)

#import "@preview/timeliney:0.0.1"

#figure(
  kind: image,
  caption: [Gantt chart timeline.],
  timeliney.timeline(
    show-grid: true,
    {
      import timeliney: *

      // Header for months
      headerline(
        group(([*January*], 4)),
        group(([*February*], 4)),
        group(([*March*], 4)),
        group(([*April*], 4)),
      )
      headerline(
        group(..range(4).map(n => strong("" + str(n + 1)))),
        group(..range(4).map(n => strong("" + str(n + 1)))),
        group(..range(4).map(n => strong("" + str(n + 1)))),
        group(..range(4).map(n => strong("" + str(n + 1)))),
      )
      taskgroup(
        title: [*Barrier Implementation*],
        {
          task("Research and Design", (0, 1), style: (stroke: 2pt + green))
          task(
            "Brook Dissemination & Tournament",
            (1, 3),
            style: (stroke: 2pt + green),
          )
          task("Tree Based", (3, 4), style: (stroke: 2pt + green))
          task("Other barrier algorithms", (4, 5), style: (stroke: 2pt + green))
        },
      )

      taskgroup(
        title: [*C++11 and MPI Hybrid model*],
        {
          task("Research and Design", (4, 5), style: (stroke: 2pt + green))
          task("Implementation", (6, 8), style: (stroke: 2pt + green))
        },
      )
      taskgroup(
        title: [*Testing and Benchmarking*],
        {
          task("Cluster Testing Setup", (8, 9), style: (stroke: 2pt + green))
          task("Performance Benchmarking", (9, 11), style: (stroke: 2pt + green))
        },
      )

      taskgroup(
        title: [*Documentation and Integration*],
        {
          task("Algorithm Comparison", (11, 12), style: (stroke: 2pt + green))
          task("Report Writing", (12, 13), style: (stroke: 2pt + green))
          task(
            "MPI Library Contribution Preparation",
            (13, 15),
            style: (stroke: 2pt + green),
          )
        },
      )

      // Milestones
      milestone(
        at: 8,
        style: (stroke: (dash: "dashed")),
        align(
          center,
          [
            *Implementation*\
          ],
        ),
      )

      milestone(
        at: 11,
        style: (stroke: (dash: "dashed")),
        align(
          center,
          [
            *Testing*\
          ],
        ),
      )
    },
  ),
)
