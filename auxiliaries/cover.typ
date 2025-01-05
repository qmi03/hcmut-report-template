#let t = toml("/templates.toml")

#let bordered-page(body) = {
  box(width: 100%, height: 100%, stroke: 2pt + black, inset: 1em, body)
}

#show: bordered-page
#set align(center)

#[
  #show: upper
  #set par(leading: 1.2em)
  #set text(size: 15pt)

  *VIETNAM NATIONAL UNIVERSITY HO CHI MINH CITY\
  HO CHI MINH CITY UNIVERSITY OF TECHNOLOGY\
  FACULTY OF COMPUTER SCIENCE AND ENGINEERING*
]

#v(2fr)

#align(center, image("/static/logo.png", height: 5cm))

#v(2fr)

#[
  #set text(size: 15pt)
  #set align(center)

  *#upper(t.at("course").at("name"))*
]

#v(.5fr)

#block(width: 100%, inset: (y: 2em), stroke: (y: 1pt))[
  #set par(leading: 1em)

  #set text(weight: "bold", size: 16pt)
  #upper(t.at("title"))

  #set text(weight: "regular", size: 15pt)
  Major: Computer Science
]

#v(1fr)

#set text(weight: "regular", size: 15pt)
#show: upper
#grid(
  columns: (1fr, 1fr),
  rows: (2em, auto),
  column-gutter: .5cm,
  align(right, [thesis committee:\ member secretary:]),
  align(
    left,
    for c in t.at("committee") [
      #v(1em, weak: true)
      #c.at("id")\
      #c.at("secretary")
    ],
  ),
)
#grid(
  columns: (1fr, 1fr),
  rows: (2em, auto),
  column-gutter: .5cm,
  align(right, [supervisors:]),
  align(
    left,
    for s in t.at("teachers") [
      #v(1em, weak: true)
      #s.at("name")
    ],
  ),
)

#lower[---o0o---]
#grid(
  columns: (1fr, 1fr),
  rows: (2em, auto),
  column-gutter: .5cm,
  align(right, [Student:]),
  align(
    left,
    for s in t.at("students") [
      #v(1em, weak: true)
      #s.at("name") - #s.at("id")
    ],
  ),
)

#v(1fr)

HCMC, #datetime.today().display("[month]/[year]")
