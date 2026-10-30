import pathlib,unittest,json
ROOT=pathlib.Path(__file__).resolve().parents[1]
class ThemeTests(unittest.TestCase):
    def test_no_argon_runtime_dependencies(self):
        for p in (ROOT/'root/usr/share/ucode/luci/template/themes/zona').glob('*.ut'):
            s=p.read_text('utf8');self.assertNotIn("from 'luci.argon",s);self.assertNotIn('/luci-static/argon',s)
    def test_language_keys_match(self):
        en=json.loads((ROOT/'i18n/en.json').read_text());ru=json.loads((ROOT/'i18n/ru.json').read_text());self.assertEqual(set(en),set(ru))
    def test_login_keeps_standard_luci_fields(self):
        s=(ROOT/'root/usr/share/ucode/luci/template/themes/zona/sysauth.ut').read_text('utf8')
        self.assertIn('name="luci_username"',s);self.assertIn('name="luci_password"',s);self.assertIn('method="post"',s)
if __name__=='__main__':unittest.main()
