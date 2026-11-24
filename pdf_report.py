import json, sys

d = json.load(open(r'C:\Users\khan nasywa\AppData\Local\Temp\opencode\pdf_dump.json'))
lo = int(sys.argv[1]) if len(sys.argv) > 1 else 1
hi = int(sys.argv[2]) if len(sys.argv) > 2 else 16

for p in d[lo-1:hi]:
    print('=' * 24, 'PAGE', p['page'], int(p['w']), int(p['h']), '=' * 24)
    for t in p['text']:
        print('%7.1f %7.1f-%7.1f sz%5.1f %s %-20s | %s' % (
            t['y'], t['x'], t['x2'], t['size'], t['color'], t['font'][:20], t['t']))
    print('--- DRAWINGS ---')
    for dr in p['drawings']:
        print('rect=%s fill=%s stroke=%s w=%s items=%s' % (
            dr['r'], dr['fill'], dr['stroke'], dr['w'], dr['items']))
    print('--- IMAGES ---', p['images'])
    print()
