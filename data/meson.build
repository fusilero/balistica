subdir('icons')

# Desktop file
i18n.merge_file ('desktop-file',
                 input: 'balistica.desktop.in',
                 output: 'balistica.desktop',
                 install: true,
                 install_dir: join_paths (datadir, 'applications'),
                 po_dir: join_paths(meson.source_root(), 'po'),
                 type: 'desktop')

# Appdata file
i18n.merge_file ('appdata-file',
                 input: 'balistica.appdata.xml.in',
                 output: 'balistica.appdata.xml',
                 install: true,
                 install_dir: join_paths (datadir, 'metainfo'),
                 po_dir: join_paths(meson.source_root(), 'po'))
