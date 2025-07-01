import os
from fpdf import FPDF

# Initialize PDF
pdf = FPDF()
pdf.set_auto_page_break(auto=True, margin=15)
pdf.set_font("Courier", size=10)

# Function to add file content to the PDF
def add_file_to_pdf(file_path):
    pdf.add_page()
    pdf.set_font("Courier", "B", 12)
    pdf.cell(200, 10, txt=f"{file_path}", ln=True)
    pdf.set_font("Courier", size=10)
    with open(file_path, "r", encoding="utf-8") as f:
        for line in f:
            line = line.replace("\t", "    ").strip()
            pdf.multi_cell(0, 5, txt=line)

# Include all Dart files in lib/
for root, dirs, files in os.walk("lib"):
    for file in files:
        if file.endswith(".dart"):
            add_file_to_pdf(os.path.join(root, file))

# Include pubspec.yaml
if os.path.exists("pubspec.yaml"):
    add_file_to_pdf("pubspec.yaml")

# Save output PDF
pdf.output("DocFusion_Source_Bundle.pdf")
print("✅ PDF successfully created: DocFusion_Source_Bundle.pdf")
