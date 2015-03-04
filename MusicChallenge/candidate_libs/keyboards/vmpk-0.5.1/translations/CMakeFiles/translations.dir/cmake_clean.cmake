FILE(REMOVE_RECURSE
  "CMakeFiles/translations"
  "vmpk_cs.qm"
  "vmpk_de.qm"
  "vmpk_es.qm"
  "vmpk_fr.qm"
  "vmpk_ru.qm"
  "vmpk_sv.qm"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/translations.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
