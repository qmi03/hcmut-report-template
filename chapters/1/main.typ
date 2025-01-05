= Introduction <introduction>

Chapter 1 introduces the project's research topic, focusing on distributed barrier
synchronization algorithms in high-performance computing.

@motivation explores the motivation behind the research, highlighting the growing importance of
high-performance computing across scientific domains, including large language
model training and complex simulations. Particularly, the section emphasizes the
critical role of barrier algorithms in synchronizing computational processes
across different nodes.

@objectives details the project objectives, which encompass a comprehensive
exploration of high-performance computing concepts, including MPI-3 and C++11
threading technologies. The research aims to investigate a hybrid programming
model that combines the communication strengths of MPI with the synchronization
capabilities of C++11. The objectives include surveying existing barrier
synchronization algorithms and proposing methods for their deployment on current
high-performance computing systems.

@scope narrows down the project's focus, the scope includes exploring key HPC concepts,
studying MPI-3 and C++11 threading features, and implementing a simple barrier
synchronization algorithm using the hybrid programming model. This aims to equip the author with new concepts before
tackling the research objectives.

The project report structure, outlined in @structure, provides a clear roadmap
for the research. The document is organized into six chapters, progressing from
foundational concepts to detailed algorithm proposals, experimental results, and
future research directions. Each chapter builds upon the previous one, creating
a comprehensive narrative of the research journey from introduction to
conclusion.

#pagebreak()
#set heading(offset: 1)
#{ include "./motivation.typ" }
#{ include "./objectives.typ" }
#{ include "./scope.typ" }
#{ include "./structure.typ" }
