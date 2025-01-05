# Why I created this

Mình không thích xài LaTeX, xài cái này viết dễ chịu hơn. Trong lúc viết báo cáo
đồ án chuyên ngành tự nhiên hứng lên muốn share cho mọi người làm chung nên mình
làm thôi .

Template này cho mấy bạn sinh viên BK có thể dùng để viết báo cáo môn học, đồ án
chuyên ngành, đồ án tốt nghiệp bằng `typst` thay vì `LaTeX`.

# Use with a code editor

Xem <https://myriad-dreamin.github.io/tinymist/frontend/main.html>

# File structure

Mô tả:

- `BibLaTeX.bib` or `bibliography.yml`: Chọn 1 trong 2 file cho việc thêm tài
  liệu tham khảo. Xem thêm ở
  [document của typst](https://typst.app/docs/reference/model/bibliography/)
- `templates.toml`: Nhớ thay đổi thông tin trong cái này theo môn học của bạn
- `main.typ`: entrypoint của bài báo cáo
- `chapters/`: thư mục chứa nội dung bài báo cáo của bạn. Đọc file `main.typ`
  trước rồi sẽ hiểu
- `target/`: thư mục output mặc định của typst lsp (tinymist).
- `static/`: thư mục chứa các file ảnh.
- `auxiliaries/`: thư mục chứa các file header, footer, trang bìa (bìa theo mẫu
  ĐÁCN của Khoa theo
  [link này](https://elearning-cse.hcmut.edu.vn/mod/forum/discuss.php?d=10))

```
.
├── BibLaTeX.bib
├── LICENSE
├── README.md
├── auxiliaries
│   ├── acknowledgement.typ
│   ├── cover.typ
│   ├── disclaimer.typ
│   ├── footer.typ
│   ├── header.typ
│   ├── outline.typ
│   └── signature.typ
├── bibliography.yml
├── chapters
│   ├── 1
│   │   ├── main.typ
│   │   ├── motivation.typ
│   │   ├── objectives.typ
│   │   ├── scope.typ
│   │   └── structure.typ
│   ├── 2
│   │   ├── cpp11.typ
│   │   ├── main.typ
│   │   └── mpi.typ
│   ├── 3
│   │   ├── barrier_algos.typ
│   │   ├── hybrid.typ
│   │   └── main.typ
│   ├── 4
│   │   └── main.typ
│   ├── 5
│   │   └── main.typ
│   ├── 6
│   │   └── main.typ
│   └── main.typ
├── main.typ
├── static
│   ├── images
│   │   ├── res.png
│   └── logo.png
├── target
│   └── main.pdf
│── templates.toml
```
