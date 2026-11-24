src_path = r'C:\Users\khan nasywa\Downloads\nesadate_main.dart'
lines = open(src_path).read().splitlines(keepends=True)

blocks = []
current = None
depth = 0
for idx,line in enumerate(lines,1):
    stripped = line.strip()
    if current is None:
        if stripped.startswith('class ') or stripped.startswith('void main') or stripped.startswith('void go'):
            current = [line]
            depth = line.count('{') - line.count('}')
        else:
            pass
    else:
        current.append(line)
        depth += line.count('{') - line.count('}')
        if depth <= 0:
            blocks.append((idx, current[:]))
            current = None
            depth = 0

print('num blocks', len(blocks))
for idx,b in blocks:
    for l in b:
        m=__import__('re').match(r'\s*class\s+(\w+)', l)
        if m:
            print(idx, m.group(1))
            break
    else:
        print(idx, 'NOCLASS', b[0].strip()[:40])
PY