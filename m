Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] libkmod-elf: resolve CRC if module is built with MODULE_REL_CRCS
Date: Wed, 19 Jul 2017 17:56:49 +0300
Message-Id: <20170719145649.20334-1-yauheni.kaliuta@redhat.com>
List-ID: <linux-modules.vger.kernel.org>

Normally exported symbol's crc is stored as absolute (SHN_ABS)
value of special named symbol __crc_<symbol name>.

When the kernel and modules are built with the config option
CONFIG_MODULE_REL_CRCS, all the CRCs are put in a special section
and the __crc_<symbol name> symbols values are offsets in the
section. See patch description of the commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=56067812d5b0e737ac2063e94a50f76b810d6ca3

Add kmod support of this configuration.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 libkmod/libkmod-elf.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/libkmod/libkmod-elf.c b/libkmod/libkmod-elf.c
index 90da89aebbaf..ef4a8a3142a1 100644
--- a/libkmod/libkmod-elf.c
+++ b/libkmod/libkmod-elf.c
@@ -747,6 +747,31 @@ static inline uint8_t kmod_symbol_bind_from_elf(uint8_t elf_value)
 	}
 }
 
+static uint64_t kmod_elf_resolve_crc(const struct kmod_elf *elf, uint64_t crc, uint16_t shndx)
+{
+	int err;
+	uint64_t off, size;
+	uint32_t nameoff;
+
+	if (shndx == SHN_ABS || shndx == SHN_UNDEF)
+		return crc;
+
+	err = elf_get_section_info(elf, shndx, &off, &size, &nameoff);
+	if (err < 0) {
+		ELFDBG("Cound not find section index %"PRIu16" for crc", shndx);
+		return (uint64_t)-1;
+	}
+
+	if (crc > (size - sizeof(uint32_t))) {
+		ELFDBG("CRC offset %"PRIu64" is too big, section %"PRIu16" size is %"PRIu64"\n",
+		       crc, shndx, size);
+		return (uint64_t)-1;
+	}
+
+	crc = elf_get_uint(elf, off + crc, sizeof(uint32_t));
+	return crc;
+}
+
 /* array will be allocated with strings in a single malloc, just free *array */
 int kmod_elf_get_symbols(const struct kmod_elf *elf, struct kmod_modversion **array)
 {
@@ -830,6 +855,7 @@ int kmod_elf_get_symbols(const struct kmod_elf *elf, struct kmod_modversion **ar
 		uint32_t name_off;
 		uint64_t crc;
 		uint8_t info, bind;
+		uint16_t shndx;
 
 #define READV(field)							\
 		elf_get_uint(elf, sym_off + offsetof(typeof(*s), field),\
@@ -839,11 +865,13 @@ int kmod_elf_get_symbols(const struct kmod_elf *elf, struct kmod_modversion **ar
 			name_off = READV(st_name);
 			crc = READV(st_value);
 			info = READV(st_info);
+			shndx = READV(st_shndx);
 		} else {
 			Elf64_Sym *s;
 			name_off = READV(st_name);
 			crc = READV(st_value);
 			info = READV(st_info);
+			shndx = READV(st_shndx);
 		}
 #undef READV
 		name = elf_get_mem(elf, str_off + name_off);
@@ -856,7 +884,7 @@ int kmod_elf_get_symbols(const struct kmod_elf *elf, struct kmod_modversion **ar
 		else
 			bind = ELF64_ST_BIND(info);
 
-		a[count].crc = crc;
+		a[count].crc = kmod_elf_resolve_crc(elf, crc, shndx);
 		a[count].bind = kmod_symbol_bind_from_elf(bind);
 		a[count].symbol = itr;
 		slen = strlen(name);
-- 
2.14.0.rc0
