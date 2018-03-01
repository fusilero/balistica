# Icons
foreach size: [ '16x16', '24x24', '32x32', '48x48', '64x64', '128x128', 'scalable' ]
  suffix = 'png'     
  if size == 'scalable'
    suffix = 'svg'     
  endif     
  install_data (join_paths ('hicolor', size, 'apps', 'balistica.' + suffix),
    install_dir: join_paths (icondir, 'hicolor', size, 'actions')
    ) 
endforeach

# Desktop file
i18n.merge_file ('desktop-file',
                 input: 'balistica.desktop.in',
                 output: 'balistica.desktop',
                 install: true,
                 install_dir: join_paths (datadir, 'applications'),
                 po_dir: '../po',
                 type: 'desktop')

# Appdata file
i18n.merge_file ('appdata-file',
                 input: 'balistica.appdata.xml.in',
                 output: 'balistica.appdata.xml',
                 install: true,
                 install_dir: join_paths (datadir, 'metainfo'),
                 po_dir: '../po')

# Gschema
install_data('org.gnome.balistica.gschema.xml',
  install_dir: join_paths(datadir, 'glib-2.0', 'schemas')
)
