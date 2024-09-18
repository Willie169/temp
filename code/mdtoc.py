import re

def generate_toc(md_content):
    # Regular expressions for headers
    header_pattern = re.compile(r'^(##|###)\s+(.*)$')
    
    toc_lines = []
    last_level = 0
    
    def format_header_text(header_text):
        # Convert header text to a URL-friendly format
        return re.sub(r'[^\w\s-]', '', header_text).strip().lower().replace(' ', '-')
    
    for line in md_content.splitlines():
        match = header_pattern.match(line)
        if match:
            header_level, header_text = match.groups()
            level = 2 if header_level == '##' else 3
            
            header_id = format_header_text(header_text)
            
            if level == 2:
                if last_level == 3:
                    toc_lines.append('')
                toc_lines.append(f'- [{header_text}](#{header_id})')
            elif level == 3:
                toc_lines.append(f'  - [{header_text}](#{header_id})')
            
            last_level = level
    
    return '\n'.join(toc_lines).replace('\n\n', '\n')

def main():
    input_file = 'README.md'  # Input markdown file
    output_file = 'toc.md'     # Output TOC file
    
    with open(input_file, 'r') as f:
        md_content = f.read()
    
    toc = generate_toc(md_content)
    
    with open(output_file, 'w') as f:
        f.write(toc)

    print(f'TOC has been written to {output_file}')

if __name__ == '__main__':
    main()