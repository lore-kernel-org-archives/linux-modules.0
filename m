Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580992;
	b=3VCzE32ioB9IFSt5n66GIub/+jXvfms2tYvK0Glq4e3+Wx4JEuQ8mJBrnGu0PclzLyxm
	 1e6zIhBSQwIbC4SI1ggMtDrvrCX6XN0enz+w+ENkuLZfey2+p2gWlMcHBFX3wvLGXkc88
	 TE7hNawBxkTYs9Fsb4L7izmVZkLZEuRUKDe81xlUUAt9u3bZfM1r3S1DDgFRYX9DEfTAj
	 OtHczDX3sPP+MuoyFf8aK7FTxAmKuv+X8c1S5Ia/YoIO+4+IeF+TMPlp6lJxmtmNep89L
	 k18Qf8z2LHhIaiqau7X7wVTqoS/plc1zy7uL/J+FCY1cM/pCP2V36aaKywiWPdlrCFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580992;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:DKIM-Signature;
	bh=7B2lNQGtkw6TJK0Rcdn6JQnFa34WsFQPJWY/8LYQpHI=;
	b=HN9ZoYs3vqeVXfvD5jrVUpzHVGZB6yzkgxqAWRQlkLdg99tr0R+gS3RyzBjLvjoN0MoR
	 jQvaNYUUXyeCSGH4n1CIHrNpODHQCB6Splo+4U1AxfZF0lqqacj5gNKbMLN84HlMw6BiV
	 MN20v4BlgfLU9gUxFb8I0wvp7hBqW4dP1lM0PWJedzlqpj658GOjJb55sGjx1uhjMxgKI
	 uuRY2EoagKsoro4VQSHeKZatuMfJ+c/tG7FdXUnNTAN5EHKIBq6UGHMI7leUcloUFVlUI
	 8OOiltGiU9uRAuvBlJjDRtR0p2XlNYp+fH7ct42Icf6d14bTxJOYo8+chLR6NQsooQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=Q2xRvE+1;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD27606A338;
	Fri, 13 Nov 2026 14:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFD27606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=Q2xRvE+1
Received: from abreu.molgen.mpg.de (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CF23F4C2F3FFBE;
	Fri, 13 Nov 2026 15:42:41 +0100 (CET)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH] module: Add LZ4 module compression
Date: Fri, 13 Nov 2026 15:42:29 +0100
Message-ID: <20261113144233.193782-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1794580962; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=7B2lNQGtkw6TJK0Rcdn6JQnFa34WsFQPJWY/8LYQpHI=; 
	b=Q2xRvE+1oCZmdeg+QA/wc+aLxkeQniY84uCZsJyeBcaxem33odOs0Vc4xNcJOS39U/BBkWgZVqDD
	8HjJb1LqOZWYFGa3+81pSZARGxO7k0GVfZrnOX9BgIowU5PA4A80o6Zaux1dFZqNhWHU3GgE+tVkl/
	Lm3I/irElYMCCrut7d42FmsfkDjkkYn1t17mdBo27HkjmqYjOWqtKubZXGyiHCBXG3Wtsm/its01nH
	ejqMrkOuYdiRI2HPgJUDldaEYbW0rv4Nw5oOG5U5J9y8yvPfo897dOSD2DUvI03+EulyeQ0EFjI85n
	8NaHk7PPtQIMVsafdnEiX7H3DKNnBa1Q==

XZ modules are small but slow to decompress in the kernel. Therefore,
support modules compressed in the LZ4 frame format (.ko.lz4), as written
by lz4(1). Decode block by block into a scratch buffer and copy into the
module pages. Linked blocks keep the last 64 KiB of output in front of
the scratch buffer as the dictionary. Verify the header checksum, block
checksums, content checksum and content size when the frame has them.
Frames with a dictionary ID are rejected.

modules_install uses `lz4 -12 -B4 -BD`: 64 KiB linked blocks are as
small as 4 MiB blocks (i915.ko: 3587140 vs 3585364 bytes) and keep the
scratch buffer at 128 KiB.

Userspace needs kmod with LZ4 support for depmod and modprobe [1].

On a Dell XPS 13 9310 with an Intel Core i7-1165G7 (Tiger Lake) and an
NVMe SSD, decompressing and checking the signatures of the 237 modules
loaded during boot takes 624 ms of CPU time with XZ (i915: 91 ms) and
131 ms with LZ4 (i915: 12 ms), measured by calling finit_module() again
for each loaded module. The LZ4 modules take 20.3 MB instead of 11.0 MB.
Both kernels are v7.4-rc1 with the same patches, including pending
lib/xz decoder speed-ups. Ten alternating boots of each kernel:

  | ms (median)                               |  XZ  | LZ4  | change |
  +-------------------------------------------+------+------+--------+
  | early-i915 (modprobe i915 + dependencies) |  295 |   90 |   -205 |
  | first i915 message                        |  738 |  547 |   -192 |
  | GDM autologin                             |  973 |  876 |    -96 |
  | GRUB start to autologin                   | 1292 | 1197 |    -94 |

QEMU 11.1.2 (KVM, AMD EPYC 7763, 8 vCPUs, module.sig_enforce=1, 10
rounds), loading the same 237 modules in dependency order:

  | median                   |   XZ    |   LZ4   | uncompressed |
  +--------------------------+---------+---------+--------------+
  | one at a time            | 2082 ms | 1499 ms |      1461 ms |
  | 8 in parallel, like udev |  619 ms |  573 ms |       593 ms |

Link: https://github.com/kmod-project/kmod/pull/505 [1]
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---

Notes:
    Assisted-by: Claude Opus 5.5 (Claude Code) wrote the decoder and this message. Tests: W=1 compile (GCC 16.2, Debian config); QEMU with module.sig_enforce=1: 11 LZ4 frame variants (64 KiB-4 MiB, linked/independent, block/content checksums, content size, stored blocks) load, 7 corrupt or truncated files are rejected; 237-module boot set loads in QEMU and on a Dell XPS 13 9310 (20 boots).

 kernel/module/Kconfig      |  13 ++-
 kernel/module/decompress.c | 227 +++++++++++++++++++++++++++++++++++++
 scripts/Makefile.modinst   |   6 +
 3 files changed, 245 insertions(+), 1 deletion(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 43b1bb01fd273..36f12612c74dd 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -344,7 +344,7 @@ config MODULE_COMPRESS
 	  This is fully compatible with signed modules.
 
 	  The tool used to work with modules needs to support the selected
-	  compression type. kmod MAY support gzip, xz and zstd. Other tools
+	  compression type. kmod MAY support gzip, lz4, xz and zstd. Other tools
 	  might have a limited selection of the supported types.
 
 	  Note that for modules inside an initrd or initramfs, it's more
@@ -377,6 +377,15 @@ config MODULE_COMPRESS_ZSTD
 	  Support modules compressed with ZSTD. The installed modules are
 	  suffixed with .ko.zst.
 
+config MODULE_COMPRESS_LZ4
+	bool "LZ4"
+	help
+	  Support modules compressed with LZ4. The installed modules are
+	  suffixed with .ko.lz4.
+
+	  LZ4 modules are larger than XZ or ZSTD ones but decompress
+	  several times faster.
+
 endchoice
 
 config MODULE_COMPRESS_ALL
@@ -394,6 +403,8 @@ config MODULE_DECOMPRESS
 	select ZLIB_INFLATE if MODULE_COMPRESS_GZIP
 	select XZ_DEC if MODULE_COMPRESS_XZ
 	select ZSTD_DECOMPRESS if MODULE_COMPRESS_ZSTD
+	select LZ4_DECOMPRESS if MODULE_COMPRESS_LZ4
+	select XXHASH if MODULE_COMPRESS_LZ4
 	help
 	  Support for decompressing kernel modules by the kernel itself
 	  instead of relying on userspace to perform this task. Useful when
diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index cce098671be97..5828b7ec9d7b6 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -287,6 +287,233 @@ static ssize_t module_zstd_decompress(struct load_info *info,
 	kvfree(wksp);
 	return retval;
 }
+#elif defined(CONFIG_MODULE_COMPRESS_LZ4)
+#include <linux/bitfield.h>
+#include <linux/lz4.h>
+#include <linux/sizes.h>
+#include <linux/unaligned.h>
+#include <linux/xxhash.h>
+#define MODULE_COMPRESSION	lz4
+#define MODULE_DECOMPRESS_FN	module_lz4_decompress
+
+/* LZ4 frame format, as written by lz4(1) */
+#define LZ4F_MAGIC		0x184d2204
+#define LZ4F_FLG_VERSION_MASK	GENMASK(7, 6)
+#define LZ4F_FLG_VERSION	0x40
+#define LZ4F_FLG_BLOCK_INDEP	BIT(5)
+#define LZ4F_FLG_BLOCK_CSUM	BIT(4)
+#define LZ4F_FLG_CONTENT_SIZE	BIT(3)
+#define LZ4F_FLG_CONTENT_CSUM	BIT(2)
+#define LZ4F_FLG_RESERVED	BIT(1)
+#define LZ4F_FLG_DICT_ID	BIT(0)
+#define LZ4F_BD_MAX_SIZE	GENMASK(6, 4)
+#define LZ4F_BD_RESERVED	(BIT(7) | GENMASK(3, 0))
+#define LZ4F_BLOCK_UNCOMPRESSED	BIT(31)
+/* Linked blocks may reference up to 64 KiB of earlier output. */
+#define LZ4F_DICT_SIZE		SZ_64K
+
+static int module_lz4_copy_out(struct load_info *info, const u8 *src,
+			       size_t len, size_t *total)
+{
+	while (len) {
+		size_t offset = *total % PAGE_SIZE;
+		size_t chunk = min_t(size_t, len, PAGE_SIZE - offset);
+		struct page *page;
+
+		if (offset)
+			page = info->pages[info->used_pages - 1];
+		else
+			page = module_get_next_page(info);
+		if (IS_ERR(page))
+			return PTR_ERR(page);
+
+		memcpy_to_page(page, offset, src, chunk);
+		src += chunk;
+		len -= chunk;
+		*total += chunk;
+	}
+
+	return 0;
+}
+
+static int module_lz4_verify_content(struct load_info *info, size_t total,
+				     u32 expected)
+{
+	void *data;
+	u32 csum;
+
+	data = vmap(info->pages, info->used_pages, VM_MAP, PAGE_KERNEL_RO);
+	if (!data)
+		return -ENOMEM;
+	csum = xxh32(data, total, 0);
+	vunmap(data);
+
+	if (csum != expected) {
+		pr_err("LZ4-compressed data is corrupt (content checksum)\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static ssize_t module_lz4_decompress(struct load_info *info,
+				     const void *buf, size_t size)
+{
+	const u8 *in = buf, *end = in + size, *desc;
+	size_t block_max, total = 0, dict_len = 0;
+	u64 content_size = 0;
+	u8 *scratch, *out;
+	bool linked;
+	u8 flg, bd;
+	int retval;
+
+	if (size < 7 || get_unaligned_le32(in) != LZ4F_MAGIC) {
+		pr_err("not an lz4 compressed module\n");
+		return -EINVAL;
+	}
+
+	desc = in + 4;
+	flg = desc[0];
+	bd = desc[1];
+	in = desc + 2;
+	if ((flg & LZ4F_FLG_VERSION_MASK) != LZ4F_FLG_VERSION ||
+	    (flg & LZ4F_FLG_RESERVED) || (bd & LZ4F_BD_RESERVED) ||
+	    FIELD_GET(LZ4F_BD_MAX_SIZE, bd) < 4) {
+		pr_err("LZ4-compressed data has an unsupported frame descriptor\n");
+		return -EINVAL;
+	}
+	if (flg & LZ4F_FLG_DICT_ID) {
+		pr_err("LZ4-compressed data needs a dictionary\n");
+		return -EINVAL;
+	}
+	if (flg & LZ4F_FLG_CONTENT_SIZE) {
+		if (end - in < 8)
+			goto truncated_header;
+		content_size = get_unaligned_le64(in);
+		in += 8;
+	}
+	if (end - in < 1)
+		goto truncated_header;
+	if (*in != ((xxh32(desc, in - desc, 0) >> 8) & 0xff)) {
+		pr_err("LZ4-compressed data has a corrupt frame descriptor\n");
+		return -EINVAL;
+	}
+	in++;
+
+	/* 4: 64 KiB, 5: 256 KiB, 6: 1 MiB, 7: 4 MiB */
+	block_max = SZ_64K << (2 * (FIELD_GET(LZ4F_BD_MAX_SIZE, bd) - 4));
+	linked = !(flg & LZ4F_FLG_BLOCK_INDEP);
+
+	scratch = kvmalloc((linked ? LZ4F_DICT_SIZE : 0) + block_max,
+			   GFP_KERNEL);
+	if (!scratch)
+		return -ENOMEM;
+	out = scratch + (linked ? LZ4F_DICT_SIZE : 0);
+
+	for (;;) {
+		u32 block_size;
+		size_t len;
+		int ret;
+
+		if (end - in < 4)
+			goto truncated;
+		block_size = get_unaligned_le32(in);
+		in += 4;
+		if (!block_size)
+			break;
+
+		len = block_size & ~LZ4F_BLOCK_UNCOMPRESSED;
+		if (len > block_max) {
+			pr_err("LZ4-compressed data has an oversized block\n");
+			retval = -EINVAL;
+			goto out;
+		}
+		if ((size_t)(end - in) < len +
+		    (flg & LZ4F_FLG_BLOCK_CSUM ? 4 : 0))
+			goto truncated;
+
+		if ((flg & LZ4F_FLG_BLOCK_CSUM) &&
+		    xxh32(in, len, 0) != get_unaligned_le32(in + len)) {
+			pr_err("LZ4-compressed data is corrupt (block checksum)\n");
+			retval = -EINVAL;
+			goto out;
+		}
+
+		if (block_size & LZ4F_BLOCK_UNCOMPRESSED) {
+			memcpy(out, in, len);
+			ret = len;
+		} else if (linked) {
+			ret = LZ4_decompress_safe_usingDict(in, out, len,
+							    block_max,
+							    out - dict_len,
+							    dict_len);
+		} else {
+			ret = LZ4_decompress_safe(in, out, len, block_max);
+		}
+		if (ret < 0) {
+			pr_err("LZ4-decompression failed\n");
+			retval = -EINVAL;
+			goto out;
+		}
+
+		retval = module_lz4_copy_out(info, out, ret, &total);
+		if (retval)
+			goto out;
+
+		if (linked) {
+			/*
+			 * The dictionary ends where the new output starts:
+			 * move the last 64 KiB of both in front of the
+			 * output area for the next block.
+			 */
+			size_t keep = min_t(size_t, dict_len + ret,
+					    LZ4F_DICT_SIZE);
+
+			memmove(out - keep, out + ret - keep, keep);
+			dict_len = keep;
+		}
+
+		in += len;
+		if (flg & LZ4F_FLG_BLOCK_CSUM)
+			in += 4;
+	}
+
+	if (flg & LZ4F_FLG_CONTENT_CSUM) {
+		if (end - in < 4)
+			goto truncated;
+		retval = module_lz4_verify_content(info, total,
+						   get_unaligned_le32(in));
+		if (retval)
+			goto out;
+		in += 4;
+	}
+
+	if (in != end) {
+		pr_err("LZ4-compressed module has trailing data\n");
+		retval = -EINVAL;
+		goto out;
+	}
+
+	if ((flg & LZ4F_FLG_CONTENT_SIZE) && content_size != total) {
+		pr_err("LZ4-compressed data has a wrong content size\n");
+		retval = -EINVAL;
+		goto out;
+	}
+
+	retval = total;
+	goto out;
+
+truncated:
+	pr_err("LZ4-compressed data is truncated\n");
+	retval = -EINVAL;
+out:
+	kvfree(scratch);
+	return retval;
+
+truncated_header:
+	pr_err("LZ4-compressed data is truncated\n");
+	return -EINVAL;
+}
 #else
 #error "Unexpected configuration for CONFIG_MODULE_DECOMPRESS"
 #endif
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 9ba45e5b32b18..aebc5e89d0e75 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -57,6 +57,7 @@ ifdef CONFIG_MODULE_COMPRESS_ALL
 suffix-$(CONFIG_MODULE_COMPRESS_GZIP)	:= .gz
 suffix-$(CONFIG_MODULE_COMPRESS_XZ)	:= .xz
 suffix-$(CONFIG_MODULE_COMPRESS_ZSTD)	:= .zst
+suffix-$(CONFIG_MODULE_COMPRESS_LZ4)	:= .lz4
 endif
 
 modules := $(patsubst %.o, $(dst)/%.ko$(suffix-y), $(modules))
@@ -151,6 +152,8 @@ quiet_cmd_xz = XZ      $@
       cmd_xz = $(XZ) --check=crc32 --lzma2=dict=1MiB -f $<
 quiet_cmd_zstd = ZSTD    $@
       cmd_zstd = $(ZSTD) --rm -f -q $<
+quiet_cmd_lz4 = LZ4     $@
+      cmd_lz4 = $(LZ4) -12 -B4 -BD --rm -f -q $< $@
 
 $(dst)/%.ko.gz: $(dst)/%.ko FORCE
 	$(call cmd,gzip)
@@ -161,6 +164,9 @@ $(dst)/%.ko.xz: $(dst)/%.ko FORCE
 $(dst)/%.ko.zst: $(dst)/%.ko FORCE
 	$(call cmd,zstd)
 
+$(dst)/%.ko.lz4: $(dst)/%.ko FORCE
+	$(call cmd,lz4)
+
 PHONY += FORCE
 FORCE:
 
-- 
2.54.0

