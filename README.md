# Tại sao Typst mà không phải LaTeX

Mình không thích xài `LaTeX`, dùng `Typst` dễ chịu hơn (syntax, ux,...). Typst
giống như sự kết hợp giữa `LaTeX` và `Markdown` ấy, và có đầy đủ sức mạnh của
`LaTeX` (arguably better than `LaTeX`). `Typst` này tuy mới và chưa được sử dụng
rộng rãi nhưng tương lai có khả năng thay thế hoàn toàn `LaTeX` :)

Thay vì dùng `LaTeX` trên [overleaf](https://overleaf.com) thì có thể dùng trang
chính thức của `Typst` ở [đây](https://typst.app)

# Tại sao mình tạo ra cái này?

Trong lúc viết báo cáo đồ án chuyên ngành, tự nhiên hứng lên muốn share cho mọi
người nên mình làm thôi .

Template này cho mấy bạn sinh viên BK có thể dùng để viết báo cáo môn học, đồ án
chuyên ngành, đồ án tốt nghiệp,... bằng `Typst` thay vì `LaTeX`.

#

Xem <https://myriad-dreamin.github.io/tinymist/frontend/main.html>

# Tổ chức thư mục

Typst không có hướng dẫn tổ chức thư mục theo convention nào cả, đây chỉ là cách
mình tổ chức theo ý mình. Các bạn có thể tùy ý theo cách các bạn.

Mô tả:

- `templates.toml`: !!!!!!!!!Nhớ thay đổi thông tin trong cái này theo môn học
  của bạn
- `main.typ`: entrypoint của bài báo cáo
- `chapters/`: thư mục chứa nội dung bài báo cáo của bạn. Đọc file `main.typ`
  trước rồi sẽ hiểu
- `BibLaTeX.bib` or `bibliography.yml`: Chọn 1 trong 2 file cho việc thêm tài
  liệu tham khảo. Xem thêm ở
  [document của typst](https://typst.app/docs/reference/model/bibliography/)
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
